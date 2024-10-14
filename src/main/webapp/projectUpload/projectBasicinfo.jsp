<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%
request.setCharacterEncoding("UTF-8");
String user_id = (String) session.getAttribute("idKey");

System.out.println("-----------------------------------------");

usersMgr uMgr = new usersMgr();
usersBean mybean = new usersBean();
mybean=uMgr.oneUserList(user_id);
alarmMgr aMgr=new alarmMgr();
fundingMgr fdMgr=new fundingMgr();
fundingBean fdbean=new fundingBean();
createFundingMgr cfMgr=new createFundingMgr();
createFundingBean cfbean=cfMgr.createFundingList(mybean.getUser_id());


String selectedProject=fdMgr.getCategory(cfbean.getCreatefunding_category());

String action = request.getParameter("Action");
System.out.println("action: " + action); // 디버깅 로그
String nextPage = request.getParameter("nextPage");
System.out.println("Next page: " + nextPage); // 디버깅 로그

if ("submit".equals(action)) {
    String projectCategory = request.getParameter("project");
    String projectTitle = request.getParameter("projectTitle");
    String projectSummary = request.getParameter("projectSummary");
    Part projectImagePart = request.getPart("projectImage");
    
    System.out.println("ProjectCategory: " + projectCategory);
    System.out.println("Project Title: " + projectTitle);
    System.out.println("Project Summary: " + projectSummary);

    // 데이터 설정 및 저장 로직
    cfbean.setCreatefunding_category(fdMgr.getCategory(projectCategory));
    cfbean.setCreatefunding_title(projectTitle);
    cfbean.setCreatefunding_summary(projectSummary);

    // 이미지 파일 업로드 처리
    if (projectImagePart != null && projectImagePart.getSize() > 0) {
        String fileName = extractFileName(projectImagePart);

        // 저장할 실제 서버 경로 설정
        String uploadPath = getServletContext().getRealPath("/fundingimage");
        File uploadDir = new File(uploadPath);

        // 디렉터리가 없으면 생성
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // 저장할 경로 및 파일 이름 생성
        String filePath = uploadPath + File.separator + fileName;
        
        System.out.println("Upload Path: " + uploadPath);  // 경로 출력
        System.out.println("File Path: " + filePath);  // 파일 경로 출력
        
        // 파일 저장
        projectImagePart.write(filePath);

        // 파일 경로를 데이터베이스에 저장 
        String relativePath = request.getContextPath() + "/fundingimage/" + fileName;
        cfbean.setCreatefunding_image(relativePath);
    }
    

    // 데이터베이스에 저장
    cfMgr.createFundingUpdate(cfbean);  // 데이터 저장

    // 저장이 성공하면 전송된 페이지로 이동
    if (nextPage != null && !nextPage.isEmpty()) {
        response.sendRedirect(nextPage);
    } else {
    	request.getRequestDispatcher("projectBasicinfo.jsp").forward(request, response);  // 기본 페이지로 이동
    }
}


%>
<%!
private String extractFileName(Part part) {
    String contentDisposition = part.getHeader("content-disposition");
    String[] items = contentDisposition.split(";");
    for (String item : items) {
        if (item.trim().startsWith("filename")) {
            return item.substring(item.indexOf("=") + 2, item.length() - 1);
        }
    }
    return "";
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로젝트 기본 정보</title>
<link href="projectBasicinfo.css" rel="stylesheet"/>
<script>
    // 폼 제출을 위한 JavaScript 함수
    function submitForm(actionUrl) {
        // 숨겨진 input에 actionUrl을 설정
        var form = document.getElementById("projectForm");
        var actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "nextPage";
        actionInput.value = actionUrl;  // 이동할 페이지 경로

        form.appendChild(actionInput);  // 폼에 추가
        form.submit();  // 폼 제출
    }
</script>
</head>

<body>
    <div class="header">
        <!-- 뒤로가기 버튼이 있는 줄 -->
        <div class="back-row">
            <button class="back-button" onclick="history.back();">←</button>
        </div>
        
        <!-- 프로젝트 기획 로고 -->
        <div class="logo">
            <h1>프로젝트 기획</h1>
        </div>

        <!-- 사용자 컨트롤 -->
        <div class="user-controls">
            <input type="button" class="heart-button" onclick="location.href='../interestProject/interestProject.jsp'">
			<%if(aMgr.alarmOnOff(mybean.getUser_id())){ %>
			<input type="button" class="bell-button2" onclick="location.href='../alarm/alarm.jsp';">
			<%}else{ %>
			<input type="button" class="bell-button" onclick="location.href='../alarm/alarm.jsp';"> 
			<%} %>

			<span class="dropbtn" onclick="toggleDropdown()">
				<img src='<%=mybean.getUser_image() %>' alt="User Icon">
			    <b><%= mybean.getUser_name() %></b>
			</span>
        </div>
        
    <div class="dropdown-content">
		<a href="../profile/profile.jsp?selectedid=<%=user_id%>">프로필</a>
	    <a href="../interestProject/interestProject.jsp">관심프로젝트</a>
	    <a href="../alarm/alarm.jsp">알림</a>
	    <%if(mybean.getUser_master()==1){ %>
	    <a href="../manager/managerUI.jsp">게시글 관리</a>
	    <%} %>
	    <a href="../logout/logout.jsp">로그아웃</a>
    </div>

        <!-- 메뉴들 -->
        <nav class="menu-bar">
            <label class="category-label" onclick="submitForm('projectBasicinfo.jsp')">기본 정보</label>
			<label class="category-label" onclick="submitForm('projectFundingschedule.jsp')">펀딩 계획</label>
			<label class="category-label" onclick="submitForm('projectExplanation.jsp')">프로젝트 계획</label>
			<label class="category-label" onclick="submitForm('projectCreatorinfo.jsp')">창작자 정보</label>
        </nav>
    </div>
	<form id="projectForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="Action" value="submit" >
    <div class="container">
        <!-- 프로젝트 카테고리 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>프로젝트 카테고리</h2>
                <p>프로젝트 성격과 가장 일치하는 카테고리를 선택해주세요.</p>
                <p>적합하지 않을 경우 운영자에 의해 조정될 수 있습니다.</p>
            </div>
            <div class="input-group-inline">
                <div>
                    <label for="main-category">카테고리:</label>
                        <select id="main-category" name="project">
        					<option value="보드게임, TRPG" <%= "보드게임, TRPG".equals(selectedProject) ? "selected" : "" %>>보드게임, TRPG</option>
							<option value="디지털 게임" <%= "디지털 게임".equals(selectedProject) ? "selected" : "" %>>디지털 게임</option>
							<option value="웹툰 만화" <%= "웹툰 만화".equals(selectedProject) ? "selected" : "" %>>웹툰 만화</option>
							<option value="웹툰 리소스" <%= "웹툰 리소스".equals(selectedProject) ? "selected" : "" %>>웹툰 리소스</option>
							<option value="디자인 문구" <%= "디자인 문구".equals(selectedProject) ? "selected" : "" %>>디자인 문구</option>
							<option value="캐릭터 굿즈" <%= "캐릭터 굿즈".equals(selectedProject) ? "selected" : "" %>>캐릭터 굿즈</option>
							<option value="홈, 리빙" <%= "홈, 리빙".equals(selectedProject) ? "selected" : "" %>>홈, 리빙</option>
							<option value="테크, 가전" <%= "테크, 가전".equals(selectedProject) ? "selected" : "" %>>테크, 가전</option>
							<option value="반려동물" <%= "반려동물".equals(selectedProject) ? "selected" : "" %>>반려동물</option>
							<option value="푸드" <%= "푸드".equals(selectedProject) ? "selected" : "" %>>푸드</option>
							<option value="향수, 뷰티" <%= "향수, 뷰티".equals(selectedProject) ? "selected" : "" %>>향수, 뷰티</option>
							<option value="의류" <%= "의류".equals(selectedProject) ? "selected" : "" %>>의류</option>
							<option value="잡화" <%= "잡화".equals(selectedProject) ? "selected" : "" %>>잡화</option>
							<option value="주얼리" <%= "주얼리".equals(selectedProject) ? "selected" : "" %>>주얼리</option>
							<option value="출판" <%= "출판".equals(selectedProject) ? "selected" : "" %>>출판</option>
							<option value="디자인" <%= "디자인".equals(selectedProject) ? "selected" : "" %>>디자인</option>
							<option value="예술" <%= "예술".equals(selectedProject) ? "selected" : "" %>>예술</option>
							<option value="사진" <%= "사진".equals(selectedProject) ? "selected" : "" %>>사진</option>
							<option value="음악" <%= "음악".equals(selectedProject) ? "selected" : "" %>>음악</option>
							<option value="영화, 비디오" <%= "영화, 비디오".equals(selectedProject) ? "selected" : "" %>>영화, 비디오</option>
							<option value="공연" <%= "공연".equals(selectedProject) ? "selected" : "" %>>공연</option>


					    </select>
                </div>
                <div></div>

            </div>
        </div>

        <!-- 프로젝트 제목 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>프로젝트 제목</h2>
                <p>프로젝트의 주제, 창작물의 품목이 정확하게</p>
                <p>드러나는 멋진 제목을 붙여주세요.</p>
            </div>
            <div class="input-group-inline">
            	<%if(cfbean.getCreatefunding_title()==null||cfbean.getCreatefunding_title().equals("")){ %>
                <input type="text" name="projectTitle" placeholder="프로젝트의 제목을 입력해 주세요." >
                <%}else{ %>
                <input type="text" name="projectTitle" value=<%=cfbean.getCreatefunding_title() %> >
                <%} %>

            </div>
        </div>

        <!-- 프로젝트 요약 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>프로젝트 요약</h2>
                <p>후원자 분들이 프로젝트를 빠르게 이해할 수 있도록</p>
                <p>명확하고 간략하게 소개해주세요.</p>
            </div>
            <div class="input-group-inline">
            <textarea placeholder="프로젝트를 간단히 요약해 보세요." name="projectSummary"><%=cfbean.getCreatefunding_summary() %></textarea>
            </div>
        </div>

        <!-- 이미지 업로드 섹션 -->
        <div class="section">
        <div class="text-info">
            <h2>프로젝트 대표 이미지</h2>
            <p>후원자 분들이 프로젝트의 내용을 쉽게 파악하고 좋은 인상을 받을 수 있도록 이미지를 업로드 해주세요.</p>
        </div>
        <div class="upload-controls">
        <%
            String imagePath = cfbean.getCreatefunding_image();  // 이미지 경로를 서버로부터 가져옴
            if (imagePath != null && !imagePath.isEmpty()) {
                // 이미지가 있을 경우
        %>
         	<div id="previewBox" class="preview-box" style="background-image: url('<%=imagePath %>');"></div>
        <%
            } else {
                // 이미지가 없을 경우 빈칸
        %>
            <div class="preview-box">이미지 미리보기</div>
        <%
            }
        %>
            <input type="file" class="upload-input" id="projectImage" name="projectImage">
        </div>
    </div>
  	
  	<button class="next-button" onclick="submitForm('projectFundingschedule.jsp')">확인</button>
    </div>
	</form>
<script>
document.addEventListener("DOMContentLoaded", function() {
    var uploadInput = document.querySelector('.upload-input');
    var previewBox = document.querySelector('.preview-box');

    uploadInput.addEventListener('change', function() {
        var file = this.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var imgElement = document.createElement('img');
                imgElement.src = e.target.result;
                imgElement.className = 'preview-image';
                previewBox.innerHTML = '';  // 기존 미리보기 내용을 지우고
                previewBox.appendChild(imgElement);  // 새로운 이미지를 추가
            };
            reader.readAsDataURL(file);
        } else {
            previewBox.innerHTML = '<div class="preview-box">이미지 미리보기</div>';  // 파일이 없을 경우 빈칸으로 표시
        }
    });
});
</script>
<script src="dropdown.js"></script>
</body>
</html>

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

acountMgr acMgr=new acountMgr();
acountBean abean=new acountBean();

if(acMgr.acountCheck(mybean.getUser_id())){

	abean=acMgr.acountList(mybean.getUser_id());

}else{
	acMgr.acountInsert(mybean.getUser_id());
	abean.setAcount_user_id(mybean.getUser_id());

}
String action = request.getParameter("Action");
System.out.println("action: " + action); // 디버깅 로그
String nextPage = request.getParameter("nextPage");
System.out.println("Next page: " + nextPage); // 디버깅 로그

if ("submit".equals(action)) {
    String name = request.getParameter("name");
    String info = request.getParameter("info");
    Part fileupload = request.getPart("file-upload");


    System.out.println("name: " + name);
    System.out.println("info: " + info);
    System.out.println("fileupload: " + fileupload);


    // 데이터 설정 및 저장 로직
	mybean.setUser_name(name);
	mybean.setUser_info(info);

	if (fileupload != null && fileupload.getSize() > 0) {
        String fileName = extractFileName(fileupload);

        // 저장할 실제 서버 경로 설정
        String uploadPath = getServletContext().getRealPath("/userimage");
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
        fileupload.write(filePath);

        // 파일 경로를 데이터베이스에 저장 
        String relativePath = request.getContextPath() + "/userimage/" + fileName;

        mybean.setUser_image(relativePath);
    }


    // 데이터베이스에 저장
    uMgr.userUpdate(mybean);  // 데이터 저장

    String accountType = request.getParameter("accountType");

    if(accountType.equals("personal")){

    	abean.setAcount_type(0);

    }else if(accountType.equals("business")){

    	abean.setAcount_type(1);

    }

    String bank = request.getParameter("bank");
    abean.setAcount_bank(bank);

    String accountNumberStr = request.getParameter("accountNumber");
    int accountNumber = 0;

    if (accountNumberStr != null && !accountNumberStr.isEmpty()) {
        try {
            accountNumber = Integer.parseInt(accountNumberStr);
        } catch (NumberFormatException e) {
            // 예외 처리: 숫자가 아닌 경우 처리 로직
            System.out.println("잘못된 계좌 번호 형식입니다.");
        }
    } else {
        // accountNumberStr가 null이거나 비어 있는 경우 처리 로직
        System.out.println("계좌 번호가 제공되지 않았습니다.");
    }

    abean.setAcount_num(accountNumber);

    String accountHolder = request.getParameter("accountHolder");

    abean.setAcount_name(accountHolder);

    acMgr.acountUpdate(abean);



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
<title>프로젝트 창작자 정보</title>
<link href="projectCreatorinfo.css" rel="stylesheet"/>
<script>
    // 폼 제출을 위한 JavaScript 함수
    function submitForm(pageURL) {
        var form = document.getElementById("projectForm");  // 'projectForm' ID를 가진 폼을 가져옵니다.
        form.action = pageURL;  // action 속성을 동적으로 변경합니다.
        form.submit();  // 폼을 제출합니다.
    }
</script>

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
        <!-- 창작자 이름 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>창작자 이름</h2>
                <p>창작자 개인이나 팀을 대표할 수 있는 이름을 써주세요.</p>
            </div>
            <div class="input-group-inline">
                <input type="text" name="name" id="name" value=<%=mybean.getUser_name() %>>
            </div>
        </div>

        <!-- 프로필 이미지 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>프로필 이미지</h2>
                <p>창작자 개인이나 팀의 사진을 올려주세요.</p>              
            </div>
            <div class="upload-controls">
                <div class="upload-box">
                <%
		            String imagePath = mybean.getUser_image();  // 이미지 경로를 서버로부터 가져옴
		            if (imagePath != null && !imagePath.isEmpty()) {
		                // 이미지가 있을 경우
		        %>
		         	<span class="upload-placeholder" style="background-image: url('<%=imagePath %>');"></span>
		        <%
		            } else {
		                // 이미지가 없을 경우 빈칸
		        %>
		            <span class="upload-placeholder">이미지 미리보기</span>
		        <%
		            }
		        %>
                    
                </div>
                <label for="file-upload" class="upload-button">이미지 파일 업로드</label>
                <input type="file" id="file-upload" name="file-upload" class="upload-input" style="display:none;">
                <div class="upload-info">파일 형식은 jpg, png 또는 gif로, 사이즈는 가로 150px, 세로 150px 이상으로 올려주세요.</div>
            </div>
        </div>
        
        <!-- 창작자 소개 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>창작자 소개</h2>
                <p>2~3문장으로 창작자님의 이력과 간단한 소개를 써주세요.</p>
            </div>
            <div class="input-group-inline" >
                <textarea name="info" id="info"><%=mybean.getUser_info() %></textarea>
            </div>
        </div>
        
         <!-- 본인 인증 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>본인 인증</h2>
                <p>창작자 본인 명의의 휴대폰 번호로 인증해주세요.</p>
            </div>
            <div class="auth-box" id="authBox">
                <button class="auth-button" id="authButton">인증하기</button>
            </div>
        </div>
    
    <!-- 입금 계좌 섹션 -->
    <div class="section">
        <div class="text-info">
            <h2>입금 계좌</h2>
            <p>후원금을 전달받을 계좌를 등록해주세요.<br>법인사업자는 법인계좌로만 청산받을 수 있습니다.</p>
        </div>
        
        <!-- 계좌 입력 박스 -->
        <div class="form-box">
            <!-- 계좌 종류 토글 버튼 -->
            <div class="input-group-inline">
                <label for="accountType">계좌 종류</label>
                <div class="account-type-toggle">
                    <input type="radio" id="personal" name="accountType" value="personal" <%= 0==abean.getAcount_type() ? "checked" : "" %>>
                    <label for="personal"><span>개인</span></label>
                    <input type="radio" id="business" name="accountType" value="business"<%= 1==abean.getAcount_type() ? "checked" : "" %>>
                    <label for="business"><span>사업자</span></label>
                </div>
            </div>

            <!-- 거래 은행 드롭다운 -->
            <div class="input-group-inline">
                <label for="bank">거래 은행</label>
                <select id="bank" name="bank">
                    <option value="" <%= "".equals(abean.getAcount_bank()) ? "selected" : "" %>>은행을 선택해주세요</option>
                    <option value="kookmin"<%= "kookmin".equals(abean.getAcount_bank()) ? "selected" : "" %>>국민은행</option>
                    <option value="shinhan"<%= "shinhan".equals(abean.getAcount_bank()) ? "selected" : "" %>>신한은행</option>
                    <option value="woori"<%= "woori".equals(abean.getAcount_bank()) ? "selected" : "" %>>우리은행</option>
                    <option value="hana"<%= "hana".equals(abean.getAcount_bank()) ? "selected" : "" %>>하나은행</option>
                    <!-- Add other banks as needed -->
                </select>
            </div>

            <!-- 예금주명 입력 -->
            <div class="input-group-inline">
                <label for="accountHolder">예금주명</label>
                <input type="text" id="accountHolder" name="accountHolder" placeholder="예금주명을 입력해주세요" value=<%=abean.getAcount_name() %>>
            </div>

            <!-- 계좌번호 입력 -->
            <div class="input-group-inline">
                <label for="accountNumber">계좌번호</label>
                <input type="text" id="accountNumber" name="accountNumber" placeholder="계좌번호를 입력해주세요" maxlength="16" value=<%=abean.getAcount_num() %>>
            </div>
        </div>
    </div>
    <button class="next-button" onclick="submitForm('createFunding.jsp')">확인</button>
    </div>
    
    
</form>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var uploadInput = document.querySelector('.upload-input');
            var uploadBox = document.querySelector('.upload-box');
            var uploadPlaceholder = document.querySelector('.upload-placeholder');

            uploadInput.addEventListener('change', function() {
                var file = this.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        var imgElement = document.createElement('img');
                        imgElement.src = e.target.result;
                        imgElement.className = 'preview-image';
                        uploadBox.innerHTML = '';
                        uploadBox.appendChild(imgElement);
                    };
                    reader.readAsDataURL(file);
                }
            });

            // 인증하기 버튼 클릭 이벤트
            var authButton = document.getElementById('authButton');
            authButton.addEventListener('click', function() {
                completeAuth();
            });
        });

        function completeAuth() {
            var authBox = document.getElementById('authBox');
            authBox.innerHTML = `
                <div class="auth-info">
                    <span class="icon">👤</span>
                    <div>
                        김유준<br>
                        001002 / 010-1234-5678
                    </div>
                </div>
                <div class="auth-complete">
                    ✔ 인증 완료
                </div>
            `;
        }
    </script>
    <script src="dropdown.js"></script>
</body>
</html>

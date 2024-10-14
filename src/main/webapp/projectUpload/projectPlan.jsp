<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>
<%
request.setCharacterEncoding("UTF-8");

usersMgr uMgr = new usersMgr();
usersBean mybean = new usersBean();


String user_id = (String) session.getAttribute("idKey");

mybean=uMgr.oneUserList(user_id);
alarmMgr aMgr=new alarmMgr();
createFundingMgr cfMgr=new createFundingMgr();
createFundingBean cfbean=new createFundingBean();
cfbean.setCreatefunding_user_id(mybean.getUser_id());

String Action = request.getParameter("Action");
// 폼으로부터 전송된 프로젝트 종류(project)는 int 값으로 처리해야 합니다.


// 프로젝트 요약문 처리


if ("action".equals(Action)) {
	String projectSummary = request.getParameter("projectSummary");
	String projectStr = request.getParameter("project"); // 문자열로 받아온 후
	int project = 0;

	try {
	    project = Integer.parseInt(projectStr); // 문자열을 int로 변환
	} catch (NumberFormatException e) {
	    // 변환에 실패하면 예외 처리
	    out.println("프로젝트 종류를 숫자로 변환할 수 없습니다.");
	    return; // 오류가 발생한 경우 더 이상 진행하지 않음
	}
	
	
	cfbean.setCreatefunding_category(project);
	cfbean.setCreatefunding_summary(projectSummary);
	
    LocalDate currentDate = LocalDate.now();
 // 날짜를 문자열로 포맷팅하기
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String dateString = currentDate.format(formatter);
    
	cfbean.setCreatefunding_term(dateString);
	
	cfMgr.createFunding_insert(cfbean);
    
    response.sendRedirect("projectBasicinfo.jsp"); // 성공 알림
}

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>프로젝트 계획 화면</title>
<link href="projectPlan.css" rel="stylesheet"/>
</head>
<body>
	<!-- 상단바 1 -->
	<header class="title-header">
		<h1>Dream Catcher</h1>
		<div>
			<%
			if (mybean.getUser_id() == null || mybean.getUser_id().equals("")) {
			%>
			<input type="button" class="upload-button" onclick=""> 
			<input type="button" class="login-button" onclick="location.href='../login/login.jsp';">


			<%
			} else {
			%>

			

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

		<%
		}
		%>
	</header>
	
	<div class="dropdown-content">
		<a href="../profile/profile.jsp?selectedid=<%=user_id%>">프로필</a>
	    <a href="../interestProject/interestProject.jsp">관심프로젝트</a>
	    <a href="../alarm/alarm.jsp">알림</a>
	    <a href="../logout/logout.jsp">로그아웃</a>
    </div>
	<!-- 카테고리 시작 -->
	<nav class="menu-bar">
		<label class="category-label"><img src="image/menubar.png">카테고리</label>
		 <label class="category-label" style="cursor:pointer;" onclick="window.location.href='../home/home.jsp'">홈</label> 
		<label class="category-label">인기</label>
		<label class="category-label">신규</label> 
		<label class="category-label">스토어</label>

		<form method="GET" action="../searchTab/searchTab.jsp">
		    <span class="search-span">
		        <input type="text" class="input_text" name="search" placeholder="검색어를 입력하세요." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
		        <button type="submit"><img alt="searchicon" src="image/searchicon.png" class="input_icon"></button>
		    </span>
		</form>
	</nav>
	<hr id="default-hr" width="100%" noshade />
	<form id="projectForm" method="POST">
	<!-- 두 번째 코드 추가 -->
	<div class="container">
        <div class="left">
            <!-- 왼쪽 이미지 전체 커버 -->
        </div>
        <div class="right">
            <h2>멋진 아이디어가 있으시군요!</h2>
            <h2>어떤 프로젝트를 계획 중이신가요?</h2>
            <p>나중에 변경 가능하니 너무 걱정하지 마세요.</p>
			    <!-- 프로젝트 종류 선택 영역 -->
			    <div class="toggle-container" id="toggleContainer"></div>
				
			    <!-- 프로젝트 소개 텍스트 영역 -->
			    <div class="textarea-container">
			        <h2>프로젝트를 간단하게 소개해주세요.</h2>
			        <textarea name="projectSummary" rows="4" placeholder="프로젝트 요약을 입력해주세요."></textarea>
			    </div>
				<input type="hidden" name="Action" value="action">
			    <!-- 다음 버튼 -->
			    <button class="next-button" onclick="document.getElementById('projectForm').submit();">다음</button>
			
        </div>
    </div>
	</form>
    <script>
        const projects = [
            "보드게임, TRPG", "디지털 게임", "웹툰 만화",
            "웹툰 리소스", "디자인 문구", "캐릭터 굿즈", "홈, 리빙",
            "테크, 가전", "반려동물", "푸드", "향수, 뷰티",
            "의류", "잡화", "주얼리", "출판", "디자인",
            "예술", "사진", "음악", "영화, 비디오", "공연"
        ];

        const container = document.getElementById('toggleContainer');

        projects.forEach((project, index) => {
            const radio = document.createElement('input');
            radio.type = 'radio';
            radio.id = project.replace(/,|\s+/g, '_').toLowerCase();
            radio.name = 'project';
            radio.className = 'toggle-button';
            radio.value = index+1;
            

            const label = document.createElement('label');
            label.htmlFor = radio.id;
            label.textContent = project;
            label.classList.add('toggle-button-label');

            container.appendChild(radio);
            container.appendChild(label);
        });
    </script>
    
    <script src="dropdown.js"></script>
</body>
</html>

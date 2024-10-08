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
	
	cfMgr.createFunding_insert(cfbean);
    
    response.sendRedirect("projectBasicinfo.jsp"); // 성공 알림
}

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>프로젝트 계획 화면</title>
<style>
body {
	margin: 0;
	padding: 0 15%;
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	overflow: hidden; /* 추가: 바깥쪽 스크롤바 제거 */
}

.category-label {
	font-size: 25px;
	font-weight: 700;
	margin-right: 20px;
	display: inline-block;
}

.category-label img {
	width: 20px;
	height: 20px;
	margin-right: 15px;
}

.category-label:hover {
	color: red;
}

.category-label:hover img {
	filter: brightness(0) saturate(100%) invert(26%) sepia(93%) saturate(2500%) hue-rotate(351deg) brightness(100%) contrast(100%);
}

.interest-label {
	font-size: 20px;
	font-weight: 500;
	margin-right: 30px;
	color: gray;
	cursor: pointer;
}

.active {
	color: black;
}

hr {
	border: none;
	height: 1px;
	background-color: #dee2e6;
}

.title-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.title-header div {
	display: flex;
	align-items: center;
}

.title-header .upload-button {
	background: url("image/uploadproject.png") no-repeat;
	width: 140px;
	height: 40px;
	border-width: 0;
	margin-right: 10px;
}

.title-header .login-button {
	background: url("image/login.png") no-repeat;
	width: 225px;
	height: 49px;
	margin-left: 20px;
	border-width: 0;
}

.title-header .heart-button {
	background: url("image/hearticon.png") no-repeat;
	width: 40px;
	height: 40px;
	border: 0px;
	margin-left: 20px;
}

.title-header .bell-button {
	background: url("image/bellicon.png") no-repeat;
	width: 40px;
	height: 40px;
	border: 0px;
	margin-left: 20px;
}

.title-header .bell-button2 {
	background: url("image/bellicon2.png") no-repeat;
	width: 40px;
	height: 40px;
	border: 0px;
	margin-left: 20px;
}

.title-header span {
	display: inline-block;
	width: 150px;
	padding: 15px;
	align-items: center;
	border: 1px solid black;
	margin-left: 20px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.title-header span img {
	width: 35px;
	height: 35px;
	vertical-align: middle;
	margin-right: 5px;
}

.search-span {
	width: 260px;
	height: 35px;
	border: 1px solid #000000;
	display: flex;
	align-items: center;
	background: #dee2e6;
	margin-left: auto; /* 검색창을 우측 정렬 */
}

.search-span .input_text {
	font-size: 18px;
	border: 0px;
	outline: none;
	background: #dee2e6;
	width: 100%;
}

.search-span .input_icon {
	width: 20px;
	height: 20px;
}

.menu-bar {
	display: flex;
	align-items: center;
	margin-top: 10px;
}

.menu-bar .category-label {
	margin-right: 20px;
	cursor: pointer;
}

.menu-bar .category-label + .category-label {
	margin-left: 20px;
}

@media (max-width: 768px) {
	.menu-bar {
		flex-direction: column;
		align-items: flex-start;
	}
	.menu-bar .category-label {
		margin-bottom: 10px;
	}
}

/* 추가한 스타일 */
#interest-project img {
	width: 320px;
	height: 320px;
}

#interest-project {
	width: 324px;
	height: 457px;
	margin-right: 50px;
	margin-bottom: 10px;
}

.creator-name {
	font-size: 15px;
	font-weight: bold;
	color: #6D6D6D;
	text-decoration: none;
}

.creator-name:hover {
    text-decoration: underline;
    color: #6D6D6D;
}

.product-name {
	font-size: 18px;
	font-weight: bold;
	color: #000000;
}

.description {
	font-size: 14px;
	color: #777;
	margin-top: 5px;
	margin-bottom: 0px;
}

.dropdown-array {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
    margin-bottom: 20px;
}

.dropdown select {
    padding: 5px;
    font-size: 18px;
    border: 1px solid #ccc;
    border-radius: 2px;
    background-color: white;
    cursor: pointer;
}

.dropdown select option:hover {
    background-color: #D0D0D0;
}

.dropdown {
    position: relative; /* 부모 요소가 dropdown-content를 기준으로 잡을 수 있도록 설정 */
    display: inline-block; /* dropdown 요소가 인라인 블록으로 정렬되도록 설정 */
}

.dropbtn {
    background-color: transparent;
    border: none;
    cursor: pointer;
}

.dropdown-content {
    display: none; /* 기본적으로 숨김 */
    position: absolute; /* 부모 요소에 대해 절대 위치 */
    background-color: #f9f9f9;
    min-width: 160px; /* 드롭다운의 최소 너비 설정 */
    min-height: 160px;
    box-shadow: rgba(0,0,0,0.2);
    z-index: 1000; /* 다른 요소보다 위에 표시되도록 설정 */
    right: 0;
    margin-right: 15%;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block; /* 세로로 나열되도록 설정 */
    width: 100%;
}
/* 두 번째 코드에서 필요한 스타일 */
.container {
	display: flex;
	height: calc(100vh - 80px);
	margin-top: 20px;
	overflow-y: auto; /* 내부 콘텐츠만 스크롤 */
}

.left {
	width: 40%;
	background: url('image/image.jpg') no-repeat center center / cover;
	border-right: 1px solid #ccc;
}

.right {
	width: 60%;
	overflow-y: auto;
	padding: 20px;
	display: flex;
	flex-direction: column;
	box-sizing: border-box;
	padding-bottom: 100px;
}

.toggle-container {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 10px;
	margin: 20px 0;
}

label.toggle-button-label {
	display: block;
	background-color: #fff;
	border: 2px solid #ccc;
	padding: 10px;
	text-align: center;
	cursor: pointer;
	transition: all 0.3s ease;
	border-radius: 5px;
}

input[type="radio"] {
	display: none;
}

input[type="radio"]:checked + label.toggle-button-label {
	background-color: red;
	color: white;
	border-color: red;
}

.textarea-container {
	margin-top: 20px;
	flex-grow: 1;
}

textarea {
	width: calc(100% - 40px);
	padding: 10px;
	border: 2px solid #ccc;
	border-radius: 5px;
	resize: none;
}

.next-button {
	position: fixed;
	bottom: 20px;
	right: 20px;
	padding: 15px 25px;
	background-color: red;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	z-index: 100;
}

</style>
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

		<span class="search-span"> 
			<input type="text" class="input_text" name="search" placeholder="검색어를 입력하세요."> 
			<img alt="searchicon" src="image/searchicon.png" class="input_icon">
		</span>
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

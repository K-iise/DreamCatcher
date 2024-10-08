<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
request.setCharacterEncoding("UTF-8");
String user_id = (String) session.getAttribute("idKey");

usersMgr uMgr = new usersMgr();
usersBean mybean = new usersBean();
mybean=uMgr.oneUserList(user_id);
alarmMgr aMgr=new alarmMgr();
fundingMgr fdMgr=new fundingMgr();
fundingBean fdbean=new fundingBean();


String selectedProject = (String) session.getAttribute("selectedProject");
String projectDescription = (String) session.getAttribute("projectSummary");

if (selectedProject == null || selectedProject.isEmpty()) {
    selectedProject = "default";
}



%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로젝트 기본 정보</title>
<style>
/* 전체 페이지의 기본 스타일 설정 */
body, html {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    height: 100%;
    overflow: auto;
    box-sizing: border-box;
}

*, *::before, *::after {
    box-sizing: inherit;
}

/* 상단바 디자인 */
.header {
    background-color: #fff;
    display: flex;
    flex-direction: column; /* 세로 정렬 */
    justify-content: flex-start;
    align-items: flex-start;
    padding: 20px 15%;
    border-bottom: 1px solid #dee2e6;
    position: relative;
}

/* 뒤로가기 버튼이 있는 줄 */
.back-row {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    width: 100%;
    margin-bottom: 30px; /* 로고와 공간 추가 */
}

/* 뒤로가기 버튼 */
.back-button {
    width: 30px;
    height: 30px;
    background-color: transparent;
    cursor: pointer;
    font-size: 24px; /* 화살표 크기 조정 */
    color: black;
    border: none;
}

/* 로고 영역 */
.logo {
    margin-bottom: 25px; /* 아래 메뉴와 간격 추가 */
    display: flex;
    align-items: center;
}

.logo h1 {
    margin: 0;
    font-size: 30px;
    font-weight: 700;
}

.menu-bar {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    width: 100%;
}

.menu-bar .category-label {
    font-size: 25px; /* 글자 크기 동일하게 */
    font-weight: 700;
    margin-right: 20px;
    cursor: pointer;
    white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 설정 */
}

.menu-bar .category-label:hover {
    color: red; /* 마우스 올리면 빨간색 */
}

.menu-bar .category-label + .category-label {
    margin-left: 20px;
}

/* 추가한 요소들 */
.user-controls {
    position: absolute;
    right: 15%;
    top: 20px;
    display: flex;
    align-items: center;
}

.user-controls {
	display: flex;
	align-items: center;
}

.user-controls .upload-button {
    background: url("image/uploadproject.png") no-repeat;
    width: 140px;
    height: 40px;
    border-width: 0;
    margin-right: 10px;
}

.user-controls .heart-button {
    background: url("image/hearticon.png") no-repeat;
    width: 40px;
    height: 40px;
    border: 0px;
    margin-left: 20px;
}

.user-controls .bell-button {
    background: url("image/bellicon.png") no-repeat;
    width: 40px;
    height: 40px;
    border: 0px;
    margin-left: 20px;
}

.user-controls .bell-button2 {
	background: url("image/bellicon2.png") no-repeat;
	width: 40px;
	height: 40px;
	border: 0px;
	margin-left: 20px;
}

.user-controls span {
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

.user-controls span img {
	width: 35px;
	height: 35px;
	vertical-align: middle;
	margin-right: 5px;
}

/* 기본 컨테이너 스타일 */
.container {
    padding: 20px;
    margin: 0 auto;
    width: calc(100% - 40px);
    max-width: 1200px;
}

.section {
    border-bottom: 1px solid #ccc;
    padding: 30px 0;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
}

.text-info {
    flex-basis: 50%;
}

.input-group-inline {
    display: flex;
    flex-grow: 1;
    justify-content: space-evenly;
    align-items: center;
}

label {
    margin-right: 10px;
}

select, input[type="text"], textarea {
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}

input[type="text"], textarea {
    width: 100%;
}

input[type="text"] {
    height: 60px;
    font-size: 18px;
}

textarea {
    height: 150px;
    font-size: 16px;
}

.input-group-full {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
}

.image-upload-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    background-color: #fff;
}

.upload-details {
    flex: 1;
}

.upload-controls {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    width: 50%;
}

.preview-box {
    width: 300px;
    height: 200px;
    background-color: #eee;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px dashed #ccc;
    margin-bottom: 10px;
}

.preview-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.url-input {
    display: flex;
    align-items: center;
    flex-grow: 1;
}

.url-prefix {
    margin-right: 8px;
}

.check-button {
    padding: 8px 16px;
    background-color: #f5f5f5;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: pointer;
}

.radio-group {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin-top: 10px;
}

.radio-label {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    cursor: pointer;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 10px 20px;
    background-color: #fff;
    width: 100%;
}

.radio-custom {
    width: 20px;
    height: 20px;
    margin-right: 10px;
    border-radius: 50%;
    border: 2px solid #ccc;
    position: relative;
    display: inline-block;
    background-color: #fff;
    transition: background-color 0.2s, border-color 0.2s;
}

.radio-label input[type="radio"] {
    display: none;
}

.radio-label input[type="radio"]:checked + .radio-custom {
    background-color: red;
    border-color: red;
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

</style>
<script>
    // 폼 제출을 위한 JavaScript 함수
    function submitForm(pageURL) {
        var form = document.getElementById("projectForm");  // 'projectForm' ID를 가진 폼을 가져옵니다.
        form.action = pageURL;  // action 속성을 동적으로 변경합니다.
        form.submit();  // 폼을 제출합니다.
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
            <label class="category-label" onclick="submitForm('uploadData.jsp?page=projectBasicinfo')">기본 정보</label>
            <label class="category-label" onclick="submitForm('uploadData.jsp?page=projectFundingschedule')">펀딩 계획</label>
            <label class="category-label" onclick="submitForm('uploadData.jsp?page=projectExplanation')">프로젝트 계획</label>
            <label class="category-label" onclick="submitForm('uploadData.jsp?page=projectCreatorinfo')">창작자 정보</label>
        </nav>
    </div>
	<form id="projectForm" action="" method="post">
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
        					<option value="board_game" <%= "보드게임, TRPG".equals(selectedProject) ? "selected" : "" %>>보드게임, TRPG</option>
							<option value="digital_game" <%= "디지털 게임".equals(selectedProject) ? "selected" : "" %>>디지털 게임</option>
							<option value="webtoon_comics" <%= "웹툰 만화".equals(selectedProject) ? "selected" : "" %>>웹툰 만화</option>
							<option value="webtoon_resources" <%= "웹툰 리소스".equals(selectedProject) ? "selected" : "" %>>웹툰 리소스</option>
							<option value="design_stationery" <%= "디자인 문구".equals(selectedProject) ? "selected" : "" %>>디자인 문구</option>
							<option value="character_goods" <%= "캐릭터 굿즈".equals(selectedProject) ? "selected" : "" %>>캐릭터 굿즈</option>
							<option value="home_living" <%= "홈, 리빙".equals(selectedProject) ? "selected" : "" %>>홈, 리빙</option>
							<option value="tech_gadgets" <%= "테크, 가전".equals(selectedProject) ? "selected" : "" %>>테크, 가전</option>
							<option value="pets" <%= "반려동물".equals(selectedProject) ? "selected" : "" %>>반려동물</option>
							<option value="food" <%= "푸드".equals(selectedProject) ? "selected" : "" %>>푸드</option>
							<option value="perfume_beauty" <%= "향수, 뷰티".equals(selectedProject) ? "selected" : "" %>>향수, 뷰티</option>
							<option value="clothing" <%= "의류".equals(selectedProject) ? "selected" : "" %>>의류</option>
							<option value="accessories" <%= "잡화".equals(selectedProject) ? "selected" : "" %>>잡화</option>
							<option value="jewelry" <%= "주얼리".equals(selectedProject) ? "selected" : "" %>>주얼리</option>
							<option value="publishing" <%= "출판".equals(selectedProject) ? "selected" : "" %>>출판</option>
							<option value="design" <%= "디자인".equals(selectedProject) ? "selected" : "" %>>디자인</option>
							<option value="art" <%= "예술".equals(selectedProject) ? "selected" : "" %>>예술</option>
							<option value="photography" <%= "사진".equals(selectedProject) ? "selected" : "" %>>사진</option>
							<option value="music" <%= "음악".equals(selectedProject) ? "selected" : "" %>>음악</option>
							<option value="film_video" <%= "영화, 비디오".equals(selectedProject) ? "selected" : "" %>>영화, 비디오</option>
							<option value="performance" <%= "공연".equals(selectedProject) ? "selected" : "" %>>공연</option>

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
                <input type="text" name="projectTitle" placeholder="프로젝트의 제목을 입력해 주세요.">

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
            <textarea placeholder="프로젝트를 간단히 요약해 보세요."><%=projectDescription %></textarea>
            </div>
        </div>

        <!-- 이미지 업로드 섹션 -->
        <div class="section">
        <div class="text-info">
            <h2>프로젝트 대표 이미지</h2>
            <p>후원자 분들이 프로젝트의 내용을 쉽게 파악하고 좋은 인상을 받을 수 있도록 이미지를 업로드 해주세요.</p>
        </div>
        <div class="upload-controls">
            <div class="preview-box">이미지 미리보기</div>
            <input type="file" class="upload-input" id="projectImage" name="projectImage">
        </div>
    </div>
  
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
                    previewBox.innerHTML = '';
                    previewBox.appendChild(imgElement);
                };
                reader.readAsDataURL(file);
            }
        });
    });
</script>
<script src="dropdown.js"></script>
</body>
</html>

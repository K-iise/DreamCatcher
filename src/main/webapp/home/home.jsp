<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.usersMgr"%>
<%@ page import="entity.usersBean"%>
<%@ page import="control.followMgr"%>
<%@ page import="entity.followBean"%>
<%
usersBean ubean = new usersBean();
usersBean mybean = new usersBean();
usersMgr uMgr = new usersMgr();
followBean fbean = new followBean();
followMgr fMgr = new followMgr();

ubean.setUser_address("aaa");
ubean.setUser_id("aaaa");
ubean.setUser_info("안뇽하세요");
ubean.setUser_master(0);
ubean.setUser_name("aaa");
ubean.setUser_phone("111-1111-1111");
ubean.setUser_pw("1234");
ubean.setUser_resnum("111111-1111111");

mybean.setUser_address("aaa");
mybean.setUser_id("aaa");
mybean.setUser_info("안뇽하세요");
mybean.setUser_master(0);
mybean.setUser_name("닉네이미이이이이이이이이이ㅣ이이이잉ㅁ");
mybean.setUser_phone("111-1111-1111");
mybean.setUser_pw("1234");
mybean.setUser_resnum("111111-1111111");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈 화면</title>
<style>
body {
	margin: 0;
	padding: 0 15%;
}

/* 카테고리 css */
.category-label {
	font-size: 25px;
	font-weight: 700;
	margin-right: 20px;
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
	filter: brightness(0) saturate(100%) invert(26%) sepia(93%)
		saturate(2500%) hue-rotate(351deg) brightness(100%) contrast(100%);
}

.active {
	color: black;
}

hr {
	border: none;
	height: 1px;
	background-color: #dee2e6;
}

/* 검색 바 css */
.search-span {
	width: 260px;
	height: 35px;
	border: 1px solid #000000;
	float: right;
	display: flex;
	align-items: center;
	background: #dee2e6;
	border: 5px;
}

.search-span .input_text {
	font-size: 18px;
	border: 0px;
	outline: none;
	background: #dee2e6;
}

.search-span .input_icon {
	border: 0px;
	float: right;
}

/* 상단바 1 css */
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
	border: 0px;
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

.MainTop {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 20px;
}

.left-section {
	flex: 4;
	display: flex;
	flex-direction: column;
}

.right-section {
	flex: 2;
	background-color: #f9f9f9;
	margin-left: 20px;
	border-radius: 5px;
	border: 1px solid #ddd;
}

.slider-container {
	width: 933px;
	overflow: hidden; /* 슬라이더가 넘치는 부분 숨김 */
	position: relative;
}

.slides {
	display: flex;
	transition: transform 0.5s ease-in-out;
	width: calc(933px * 3); /* 슬라이드 수에 따라 너비 조정 */
}

.slide {
	width: 933px;
}

.slide img {
	width: 933px;
	height: 300px;
	object-fit: fill;
}

.prev, .next {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: rgba(0, 0, 0, 0.5);
	color: white;
	border: none;
	padding: 10px;
	cursor: pointer;
	z-index: 100;
}

.prev {
	left: 10px;
}

.next {
	right: 10px;
}

/* Optional: pagination (dots) */
.dots {
	text-align: center;
	margin-top: 0px;
}

.dot {
	height: 15px;
	width: 15px;
	margin: 0 5px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
	cursor: pointer;
}

.active {
	background-color: #717171;
}

/* 추가 콘텐츠 스타일 */
.additional-content {
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 5px;
}

/* 오른쪽 인기 프로젝트 랭킹 스타일 */
.right-section h2 {
	font-size: 24px;
	margin-bottom: 10px;
}

.right-section ul {
	list-style: none;
	padding: 0;
}

.right-section li {
	margin-bottom: 10px;
	font-size: 18px;
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
			<input type="button" class="upload-button" onclick=""> <input
				type="button" class="login-button" onclick="">
			<%
			} else {
			%>

			<input type="button" class="upload-button" onclick=""> <input
				type="button" class="heart-button" onclick=""> <input
				type="button" class="bell-button" onclick=""> <span
				onclick=""> <img src="image/guest.png"> <b><%=mybean.getUser_name()%></b>
			</span>
		</div>

		<%
		}
		%>
	</header>

	<!-- 카테고리 시작 -->
	<header>
		<label class="category-label"><img src="image/menubar.png">카테고리</label>
		<label class="category-label">홈</label> <label class="category-label">인기</label>
		<label class="category-label">신규</label> <label class="category-label">스토어</label>

		<span class="search-span"> <input type="text"
			class="input_text" name="search" placeholder="검색어를 입력하세요."> <img
			alt="searchicon" src="image/searchicon.png" class="input_icon">
		</span>
	</header>

	<hr id="default-hr" width="100%" noshade />

	<!--  Main 화면 위쪽 영역 -->
	<div class="MainTop">
		<!-- 왼쪽 섹션 (슬라이더 포함) -->
		<div class="left-section">
			<div class="slider-container">
				<div class="slides">
					<div class="slide">
						<img src="image/banner_image1.png" alt="Slide 1">
					</div>
					<div class="slide">
						<img src="image/banner_image2.png" alt="Slide 2">
					</div>
					<div class="slide">
						<img src="image/banner_image3.png" alt="Slide 3">
					</div>
				</div>
				<button class="prev" onclick="moveSlide(-1)">&#10094;</button>
				<button class="next" onclick="moveSlide(1)">&#10095;</button>
			</div>


			<!-- Optional: Pagination (Dots) -->
			<div class="dots">
				<span class="dot" onclick="currentSlide(1)"></span> <span
					class="dot" onclick="currentSlide(2)"></span> <span class="dot"
					onclick="currentSlide(3)"></span>
			</div>

			<!-- 추가 콘텐츠 영역 -->
			<div class="additional-content">
				<h2>추가 콘텐츠</h2>
				<p>여기에 추가 콘텐츠가 들어갑니다.</p>
			</div>
		</div>

		<!-- 오른쪽 섹션 (인기 프로젝트 랭킹) -->
		<div class="right-section">
			<h2>인기 프로젝트 랭킹</h2>
			<ul>
				<li>프로젝트 1</li>
				<li>프로젝트 2</li>
				<li>프로젝트 3</li>
			</ul>
		</div>
	</div>
	<script src="slide.js"></script>

</body>
</html>

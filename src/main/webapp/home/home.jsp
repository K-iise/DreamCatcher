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
</style>
<link href="home.css" rel="stylesheet" />
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

			<!-- 주목할 만한 프로젝트 영역 -->
			<div class="additional-content">
				<h2 style="margin: 20px;">주목할 만한 프로젝트</h2>

				<div id="projects">
					<div id="interest-project">
						<!-- 프로젝트 사진 -->
						<img src="image/interest-project1.jpg">
						<!-- 창작자 명 -->
						<a class="creator-name">몽상부띠그</a><br>
						<!-- 제품명 -->
						<label class="product-name"> 한복원단으로 만나는 [십장생 매듭원피스2] </label><br>
						<!-- 진행 정보 -->
						<div class="progress-info">
							<span class="progress-percentage">1408% 달성</span>
						</div>
					</div>

			
				</div>



			</div>
		</div>

		<!-- 오른쪽 섹션 (인기 프로젝트 랭킹) -->
		<div class="right-section">
			<div id="header-ranking">
				<div class="title-group">
					<h2>인기 프로젝트</h2>
					<p>24.09.30 15.24 기준</p>
				</div>
				<a href="#">전체 보기</a>
			</div>
			
			<div id="project-ranking">
				<img src="image/interest-project1.jpg">
				<b>1등</b>
				<div id="project-rankinfo">
					<b style="color: #6D6D6D">무용지용</b>
					<p>어디서든지 누를 수 있는 <키보드 키링></p>
					<b>5434 % 달성</b>
				</div>
			</div>
			
		</div>
	</div>
	<script src="slide.js"></script>

</body>
</html>

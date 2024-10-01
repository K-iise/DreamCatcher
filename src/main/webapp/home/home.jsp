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
<style>
.cat-container {
	position: relative;
	display: flex;
}

.depth1-wrapper {
	display: none; /* 기본적으로 숨김 */ 
	position : absolute; /* 절대 위치 설정 */
	overflow : hidden;
	width: 100%;
	height: auto;
	justify-content: space-between; /* 아이템 간의 공간을 균등하게 분할 */
	transition: max-height 0.3s ease-in-out;
	flex-direction: row;
	background: rgb(255, 255, 255);
	z-index: 999;
	user-select: none;
	box-shadow: rgba(0, 0, 0, 0.08) 0px 6px 7px;
	position: absolute; /* 절대 위치 설정 */
	overflow: hidden;
	margin-top: 10px;
}

.category-label:hover ~ .depth1-wrapper {
	display: flex; /* 호버 시에 보이게 */
	flex-wrap: wrap; /* 내용에 맞게 줄 바꿈 */
}

.depth1-group {
	display: flex; /* 가로 방향 정렬 */
	flex-direction: column; /* 세로 방향 정렬 */
}

.depth1-item {
	display: flex;
	align-items: center; /* 아이콘과 텍스트 정렬 */
	padding: 8px 12px; /* 항목 패딩 */
	cursor: pointer;
}

.depth1-item:hover {
	background-color: #f1f1f1; /* 호버 시 배경색 변화 */
}

.depth1-icon {
	margin-right: 8px; /* 아이콘과 텍스트 간격 */
}

.depth1-icon-img {
	width: 45px; /* 아이콘 크기 조정 */
	height: 45px;
}

.depth1-text {
	font-size: 18px;
}
</style>
</head>

<script>
//JavaScript 코드를 문서의 끝에 추가
document.addEventListener('DOMContentLoaded', function () {
    const categoryLabel = document.getElementById('category-label');
    const depth1Wrapper = document.querySelector('.depth1-wrapper');
    
    let isHovering = false; // 카테고리와 상세 카테고리 영역에 마우스가 있는지 여부

    // 카테고리 라벨에 마우스 오버 이벤트 추가
    categoryLabel.addEventListener('mouseenter', function () {
        depth1Wrapper.style.display = 'flex'; // 상세 카테고리 보이기
        isHovering = true;
    });

    // 상세 카테고리 영역에 마우스 오버 이벤트 추가
    depth1Wrapper.addEventListener('mouseenter', function () {
        isHovering = true; // 상세 카테고리 영역에 마우스가 있음
    });

    // 마우스가 카테고리 라벨이나 상세 카테고리에서 벗어났을 때
    categoryLabel.addEventListener('mouseleave', function () {
        if (!isHovering) {
            depth1Wrapper.style.display = 'none'; // 상세 카테고리 숨기기
        }
    });

    depth1Wrapper.addEventListener('mouseleave', function () {
        isHovering = false; // 마우스가 상세 카테고리 영역에서 벗어났음
        depth1Wrapper.style.display = 'none'; // 상세 카테고리 숨기기
    });
});
</script>

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
		<label class="category-label" id="category-label"> <img src="image/menubar.png">카테고리
		</label> <label class="category-label">홈</label> <label class="category-label">인기</label>
		<label class="category-label">신규</label> <label class="category-label">스토어</label>

		<span class="search-span"> <input type="text"
			class="input_text" name="search" placeholder="검색어를 입력하세요."> <img
			alt="searchicon" src="image/searchicon.png" class="input_icon">
		</span>

	</header>
	<!-- 카테고리 끝 -->

	<!-- 상세 카테고리 창 -->
		<div class="cat-container">
			<div class="depth1-wrapper">
				<div class="depth1-group">
					<div class="depth1-item">
						<div class="depth1-icon">
							<svg width="45" height="45" viewBox="0 0 38 38" fill="none"
								xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
									clip-rule="evenodd"
									d="M16.4 9.6H9.6V16.4H16.4V9.6ZM8 8V18H18V8H8Z" fill="#0D0D0D"></path>
                                    <path fill-rule="evenodd"
									clip-rule="evenodd"
									d="M28.4 9.6H21.6V16.4H28.4V9.6ZM20 8V18H30V8H20Z"
									fill="#0D0D0D"></path>
                                    <path fill-rule="evenodd"
									clip-rule="evenodd"
									d="M16.4 21.6H9.6V28.4H16.4V21.6ZM8 20V30H18V20H8Z"
									fill="#0D0D0D"></path>
                                    <path d="M20 20H30V30H20V20Z"
									fill="#FF5757"></path>
                                </svg>
						</div>
						<div class="depth1-text">전체</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/board.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">보드게임 · TRPG</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/digital-game.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">디지털 게임</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/comics.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">웹툰 · 만화</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/webtoon-resource.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">웹툰 리소스</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/stationary.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">디자인 문구</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/charactor-goods.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">캐릭터 · 굿즈</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/home-living.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">홈 · 리빙</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/tech-electronics.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">테크 · 가전</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/pet.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">반려동물</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/food.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">푸드</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/perfumes-cosmetics.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">향수 · 뷰티</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/fashion.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">의류</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/accessories.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">잡화</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/jewerly.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">주얼리</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/publishing.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">출판</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/design.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">디자인</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/art.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">예술</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/photography.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">사진</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/music.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">음악</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/film.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">영화 · 비디오</div>
					</div>
					<div class="depth1-item">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/performing-art.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">공연</div>
					</div>
				</div>
			</div>
		</div>

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
				<img src="image/interest-project1.jpg"> <b>1등</b>
				<div id="project-rankinfo">
					<b style="color: #6D6D6D">무용지용</b>
					<p>
						어디서든지 누를 수 있는
						<키보드 키링>
					</p>
					<b>5434 % 달성</b>
				</div>
			</div>

		</div>
	</div>
	<script src="slide.js"></script>

</body>
</html>

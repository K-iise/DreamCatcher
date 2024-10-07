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
<title>게시물 확인 화면</title>
<link href="fundingcheck.css" rel="stylesheet" />
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
				class="dropbtn" onclick="toggleDropdown()"> <img
				src="image/guest.png" alt="User Icon"> <b><%=mybean.getUser_name()%></b>
			</span>


		</div>


		<%
		}
		%>
	</header>

	<!-- 사용자 클릭 드롭다운. -->
	<div class="dropdown-content">
		<a href="#">프로필</a> <a href="#">관심프로젝트</a> <a href="#">알림</a> <a
			href="#">로그아웃</a>
	</div>

	<!-- 카테고리 시작 -->
	<header>
		<label class="category-label" id="category-label"> <img
			src="image/menubar.png">카테고리
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

	<!-- 상단 부분. -->
	<div class="MainTop">
		<div class="left-section">
			<div class="slider-container">
				<div class="slides">
					<div class="slide">
						<img src="image/fundingimage.jpg" alt="Slide 1">
					</div>
					<div class="slide">
						<img src="image/banner_image.png" alt="Slide 2">
					</div>
					<div class="slide">
						<img src="image/banner_image.png" alt="Slide 3">
					</div>
				</div>
				<button class="prev" onclick="moveSlide(-1)">&#10094;</button>
				<button class="next" onclick="moveSlide(1)">&#10095;</button>
			</div>
		</div>

		<div class="right-section">
			<div class="funding-info">
				<p id="funding-category">생활가전 ></p>
				<b id="funding-name">귀, 파지말고 관리하세요! 세계가 인정한 이어스캐너 비비드 Home30S</b>
				<h2 id="funding-people">970 명 참여</h2>
				<h2 id="funding-money">80,302,700 원 달성</h2>
				<hr id="default-hr" width="100%" noshade />
				<div class="funding-detail">
					<p>목표 금액 : 5,000,000 원</p>
					<p>펀딩 기간 : 2024.09.16 ~ 2024.09.27</p>
					<p>결제 : 목표 금액 달성 시 2024.09.28에 결제 진행</p>
				</div>
				<div id="funding-buttons">
					<div class="button-container">
						<button class="circle-button">
							<img src="image/heartbutton.png"></img>
						</button>
						<span class="button-number">123</span>
					</div>

					<div class="button-container">
						<button class="share-button">
							<img src="image/sharebuttonicon.png"></img>
						</button>
						<span class="button-number">123</span>
					</div>

					<button id="donate-button">프로젝트 후원하기</button>
				</div>
			</div>
		</div>
	</div>

	<hr id="default-hr" width="100%" noshade />

	<!-- 하단 부분 -->
	<div>
		<label class="funding-label active"
			onclick="highlight(this, 'funding-content')">프로젝트 계획</label> <label
			class="funding-label" onclick="highlight(this, 'community-content')">커뮤니티</label>
		<hr id="highlight-hr" width="100%" noshade />
	</div>

	<!-- 각 관심 카테고리 마다 사용될 body. -->
	<div class="MainBottom">
		<div class="left-section">
			<div id="content">
				<div id="funding-content" class="tab-content">
					<!-- 펀딩 내용 -->
					<div id="project-plan">
						<!-- 프로젝트 계획 내용 -->
					</div>
				</div>

				<div id="community-content" class="tab-content"
					style="display: none;">
					<!-- 커뮤니티 내용 -->
					<div id="community">
						<!-- 댓글 입력 창 -->
						<div class="comment-box">
							<textarea class="comment-input" placeholder="메시지를 입력하세요..."></textarea>
							<button class="submit-btn">작성</button>
						</div>

						<!-- 댓글 창 Example -->
						<div id="comments">
							<div id="comments-profile">
								<div id="comment-top">
									<img alt="information-image" src="image/guest.png">
									<div id="information-text">
										<b>홍길동</b>
										<p>응원글</p>
									</div>
								</div>
								<div id="comment-option">
									<img alt="option-icon" src="image/optionicon.png"
										onclick="toggleCommentDropdown(event)">
									<div id="comment-dropdown" class="dropdown-comment">
										<p onclick="editComment()">수정</p>
										<p onclick="deleteComment()">삭제</p>
										<p onclick="replyToComment()">답변</p>
									</div>
								</div>
							</div>
							<p id="comment-text">펀딩 마감까지 일주일도 남지 않았는데 주사위를 포함한 상품 부록의
								디자인은 언제쯤 공개되는 걸까요? 단순한 디자인 상품도 아니고 '텀블벅 후원 한정'으로 소장할 수 있는 상품이라는
								것이 펀딩 부록의 차별점인데, 디자인을 알지 못하고 무턱대고 구매하기엔 부록이 포함된 세트가 절대 싼 가격은 아니지
								않습니까? 더욱이 캐릭터 시트나 클리어 파일은 디자인을 쉽게 예상할 수 있지만 주사위와 주머니 세트는 그렇지
								않으니까요. 아무리 원작사와 컨펌 중에 있다고 해도 후원 기간이 한 달이나 되는데 아직도 소식이 없다는 건 소비자
								입장에서 마음이 불편하지 않겠습니까? 그렇다고 하루종일 텀블벅만 확인하고 있을 수도 없는 노릇이고요. 프로젝트 진행
								전에 완벽히 검수받은 후에 펀딩을 시작할 수는 없었던 걸까요? 대외비라는 게 있으니 모든 상황을 다 공유할 수 없는
								상황이야 이해하지만 펀딩이 얼마 남지 않은 상황까지도 아무런 경과 보고가 없다는 건 불만스럽습니다. 어떤 소식이든
								좋으니 부록과 관련된 부분은 펀딩 마감 전에 제대로 된 공지를 한 번 더 해주셨으면 합니다.</p>

							<div id="comment-bottom">
								<p>5일 전</p>
								<div id="comment-recommend">
									<img alt="recommend-image" src="image/recommend.png">
									<p id="recommed-score">0</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>





		<div class="right-section">
			<div id="donate-content">
				<b>선물하기</b>


				<!-- 상품 선택(구매)  예시 -->
				<div id="product-buy">
					<div id="buy-info">
						<label id="product-information"> <b>더블크로스 The 3rd
								Edition 기본 세트</b>
							<ul id="product-ul">
								<li><더블크로스 The 3rd Edition 룰북1> 서적 1권 (x1)</li>
								<li><더블크로스 The 3rd Edition 룰북2> 서적 1권 (x1)</li>
								<li><더블크로스 The 3rd Edition 시나리오집 문리스 나이트> 서적
									1권 (x1)</li>
								<li><더블크로스 The 3rd Edition 상급 룰북> 서적 1권 (x1)</li>
								<li>더블크로스 A4 클리어파일 2매 세트 (x1)</li>
								<li>더블크로스 A4 기본 시트 4장 세트 (x1)</li>
							</ul>

							<div id="product-bottom">
								<div class="stepper">
									<button type="button" id="decrease" disabled>-</button>
									<input type="number" value="1" class="stepper-input" readonly>
									<button type="button" id="increase">+</button>
								</div>
								<p>42,600원</p>
							</div>
						</label>
					</div>
					<button id="select-button">선물 선택하기</button>
					<button id="buy-button">총 42,600원 후원하기</button>
				</div>

				<!-- 상품 예시 1 -->
				<div id="donate-information">
					<p>2148개 선택</p>
					<b>78,000 원 +</b> <label id="product-information"> 더블크로스
						The 3rd Edition 기본 세트
						<ul id="product-ul">
							<li><더블크로스 The 3rd Edition 룰북1> 서적 1권 (x1)</li>
							<li><더블크로스 The 3rd Edition 룰북2> 서적 1권 (x1)</li>
							<li><더블크로스 The 3rd Edition 시나리오집 문리스 나이트> 서적 1권 (x1)</li>
							<li><더블크로스 The 3rd Edition 상급 룰북> 서적 1권 (x1)</li>
							<li>더블크로스 A4 클리어파일 2매 세트 (x1)</li>
							<li>더블크로스 A4 기본 시트 4장 세트 (x1)</li>
						</ul>
					</label>
				</div>

				<!-- 상품 예시 2 -->
				<div id="donate-information">
					<p>2148개 선택</p>
					<b>78,000 원 +</b> <label id="product-information"> 더블크로스
						The 3rd Edition 기본 세트
						<ul id="product-ul">
							<li><더블크로스 The 3rd Edition 룰북1> 서적 1권 (x1)</li>
							<li><더블크로스 The 3rd Edition 룰북2> 서적 1권 (x1)</li>
							<li><더블크로스 The 3rd Edition 시나리오집 문리스 나이트> 서적 1권 (x1)</li>
							<li><더블크로스 The 3rd Edition 상급 룰북> 서적 1권 (x1)</li>
							<li>더블크로스 A4 클리어파일 2매 세트 (x1)</li>
							<li>더블크로스 A4 기본 시트 4장 세트 (x1)</li>
						</ul>
					</label>
				</div>

			</div>
		</div>
	</div>

	<hr id="default-hr" width="100%" noshade />

	<script src="detailInfo.js"></script>
	<script src="dropdown.js"></script>
	<script src="fundinglabel.js"></script>
	<script src="comment_dropdown.js"></script>
	<script src="stepper.js"></script>
</body>
</html>

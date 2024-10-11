<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.usersMgr"%>
<%@ page import="entity.usersBean"%>
<%@ page import="control.followMgr"%>
<%@ page import="entity.followBean"%>
<%@ page import="control.commentsMgr" %>
<%@ page import="entity.commentsBean" %>
<%@ page import="control.resomeCommentMgr" %>
<%@ page import="control.fundingMgr"%>
<%@ page import="entity.fundingBean"%>
<%
usersBean ubean = new usersBean();
usersBean mybean = new usersBean();
usersMgr uMgr = new usersMgr();
followBean fbean = new followBean();
followMgr fMgr = new followMgr();
commentsMgr cMgr = new commentsMgr();
resomeCommentMgr rMgr = new resomeCommentMgr();
fundingMgr fndMgr = new fundingMgr();

//funding_num을 쿼리 파라미터에서 가져옴
int fundingNum = Integer.parseInt(request.getParameter("fundingNum"));

//댓글 목록을 가져옴
Vector<commentsBean> commentsList = cMgr.commentList(fundingNum);

//funding_user_id를 가져오기 위한 funding 정보 조회
Vector<fundingBean> fundingList = fndMgr.fundingListForNum(fundingNum);
String fundingUserId = null;

//fundingList가 비어있지 않은 경우 funding_user_id를 가져옴
if (!fundingList.isEmpty()) {
 fundingUserId = fundingList.get(0).getFunding_user_id();
}

String user_id = (String) session.getAttribute("idKey");
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
						    <form action="commentInsert.jsp" method="post"> <!-- action을 commentInsert.jsp로 설정 -->
						        <textarea name="comment_con" class="comment-input" placeholder="메시지를 입력하세요..." required></textarea>
						        <input type="hidden" name="fundingNum" value="<%= fundingNum %>"> <!-- fundingNum을 hidden 필드로 추가 -->
						        <input type="submit" class="submit-btn" value="작성"> <!-- submit 버튼으로 변경 -->
						    </form>
						</div>

						<!-- 댓글 창 Example -->
						<div id="comments">
							<%
							if (commentsList != null && !commentsList.isEmpty()) {
								for (commentsBean comment : commentsList) {
									int daysAgo = new commentsMgr().commentDate(comment.getComment_num()); // 댓글 작성일로부터 경과된 일수 가져오기
									// 댓글 작성자의 user_name 가져오기
									usersBean commentUser = uMgr.oneUserList(comment.getComment_user_id()); 
									// 해당 댓글의 추천 수 가져오기
					                int recomeCount = rMgr.recomeCount(comment.getComment_num());
							%>
							<div id="comments-profile">
								<div id="comment-top">
									<img alt="information-image" src="<%=commentUser.getUser_image()%>">
									<div id="information-text">
										<b><%= commentUser.getUser_name() %></b>
									</div>
								</div>
								<div id="comment-option">
									<%
							        	if (user_id != null && user_id.equals(comment.getComment_user_id())) {
							        %>
									<img alt="option-icon" src="image/optionicon.png"
										onclick="toggleCommentDropdown(event)">
									<div id="comment-dropdown" class="dropdown-comment">
										<p onclick="editComment()">수정</p>
										<p onclick="deleteComment(<%= comment.getComment_num() %>, <%= fundingNum %>)">삭제</p>
									</div>
									<%
							        } else if (user_id != null && user_id.equals(fundingUserId)) {
							        %>
									<img alt="option-icon" src="image/optionicon.png"
										onclick="toggleCommentDropdown(event)">
									<div id="comment-dropdown" class="dropdown-comment">
										<p onclick="replyToComment()">답변</p>
									</div>
									<%
							        }
							        %>
								</div>
							</div>
							<p id="comment-text"><%= comment.getComment_con() %></p>

							<div id="comment-bottom">
						        <p><%= (daysAgo == 0) ? "오늘" : daysAgo + "일 전" %></p> <!-- 0일 전이면 '오늘'로 출력 -->					        
								<div id="comment-recommend">
								    <form action="commentInsert.jsp" method="post">
								        <input type="hidden" name="recom_comment_num" value="<%= comment.getComment_num() %>"> 
								        <input type="hidden" name="fundingNum" value="<%= fundingNum %>">
								        <img alt="recommend-image" src="image/recommend.png" style="cursor:pointer;" onclick="this.closest('form').submit();"> <!-- 클릭 시 폼 제출 -->
								    </form>
								    <p id="recommed-score"><%= recomeCount %></p>
								</div>
						    </div>
						    
								<%
							            }
							        } else {
							    %>
							        <p>댓글이 없습니다.</p>
							    <%
							        }
							    %>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="right-section">
		
			<div id="creator-content">	
				<div id="creator-box">
					<b style="font-size: 18px">창작자 소개</b>
					<div id="creator-info">
						<img alt="creator-image" src="image/guest.png">
						<a>다람북스</a>
					</div>
					
					<p id="creator-intro">
					다람북스는 책과 일상 속에서 의미 있는 제품을 만드는 창작 팀입니다. 이야기가 가진 힘을 믿으며, 그 이야기를 다양한 형태로 풀어내 사람들에게 영감을 주는 것을 목표로 하고 있습니다. 실용적이면서도 특별한 제품들을 통해 일상 속에 이야기를 더해 나갑니다.
					</p>
					<hr id="default-hr" width="100%" noshade />
					<div id="creator-buttons">
						<button id="inquiry-button">창작자 문의</button>
						<button id="follow-button">+ 팔로우</button>
					</div>
				</div>
			</div>
		
		
		
			<div id="donate-content">
				<b>선물하기</b>

				<!-- 상품 선택(구매)  예시 -->
				<div id="product-buy">
					<div id="buy-info">
						<label id="product-information"> 
						<div id="product-title">
							<b>더블크로스 The 3rd	Edition 기본 세트</b>
							<button id="delete-button">X</button>
						</div>
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

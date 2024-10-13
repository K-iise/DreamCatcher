<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>

<%
usersBean mybean = new usersBean();
usersMgr uMgr = new usersMgr();
followBean fbean = new followBean();
followMgr fMgr = new followMgr();
commentsMgr cMgr = new commentsMgr();
resomeCommentMgr rMgr = new resomeCommentMgr();
fundingMgr fndMgr = new fundingMgr();
readRecordMgr reMgr = new readRecordMgr();
readRecordBean reBean = new readRecordBean();
createFundingMgr cfMgr=new createFundingMgr();
alarmMgr aMgr=new alarmMgr();
priceMgr pMgr=new priceMgr();
//funding_num을 쿼리 파라미터에서 가져옴
int fundingNum = Integer.parseInt(request.getParameter("fundingNum"));

//댓글 목록을 가져옴
Vector<commentsBean> commentsList = cMgr.commentList(fundingNum);

//funding_user_id를 가져오기 위한 funding 정보 조회
Vector<fundingBean> fundingList = fndMgr.fundingListForNum(fundingNum);

Vector<priceBean> priceList = pMgr.priceList(fundingNum);
//fundingList에서 첫 번째 fundingBean 객체 가져오기
fundingBean fundingData = null;
if (!fundingList.isEmpty()) {
 fundingData = fundingList.get(0);
}

//funding_user_id, funding_image, funding_title, funding_nprice를 가져오기
String fundingUserId = fundingData.getFunding_user_id();
String fundingImage = fundingData.getFunding_image();
String fundingTitle = fundingData.getFunding_title();
int fundingNprice = fundingData.getFunding_nprice(); 
int fundingTprice = fundingData.getFunding_tprice();
String fundingTerm = fundingData.getFunding_term();
String fundingDate = fundingTerm.substring(0, fundingTerm.indexOf(" "));
int wishCount = reMgr.getWishCountForFunding(fundingNum);

String user_id = (String) session.getAttribute("idKey");
mybean=uMgr.oneUserList(user_id);
//열람 기록이 이미 존재하는지 확인
boolean readExists = reMgr.checkIfRead(user_id, fundingNum);
if(!readExists){
	reBean.setRead_funding_num(fundingNum); // 현재 funding_num 설정
	reBean.setRead_user_id(user_id); // 세션에서 가져온 user_id 설정
	reBean.setRead_wish(0); // read_wish를 0으로 설정

	// DB에 열람 내역 저장
	reMgr.readInsert(reBean);
}
int userCount = reMgr.getUserCountForFunding(fundingNum);
//해당 펀딩의 카테고리 가져오기
String categoryFunding = fndMgr.getCategoryForFunding(fundingNum);
boolean isFollowing = fMgr.followCheck(user_id, fundingUserId); // 팔로우 여부 확인
//펀딩 넘버에 해당하는 가격 목록을 가져옴
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
			<input type="button" class="upload-button" onclick="alert('로그인 해주세요');"> 
			<input type="button" class="login-button" onclick="location.href='../login/login.jsp';">


			<%
			} else {
			%>
			<%if(cfMgr.createFundingCheck(mybean.getUser_id())){%>
			<input type="button" class="upload-button" onclick="location.href='../projectUpload/projectBasicinfo.jsp'">
			<%}else{ %>
			<input type="button" class="upload-button" onclick="location.href='../projectUpload/projectPlan.jsp'"> 
			<%} %>
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

	<!-- 사용자 클릭 드롭다운. -->
	<div class="dropdown-content">
		<a href="../profile/profile.jsp?selectedid=<%=user_id%>">프로필</a>
	    <a href="../interestProject/interestProject.jsp">관심프로젝트</a>
	    <a href="../alarm/alarm.jsp">알림</a>
	    <a href="../logout/logout.jsp">로그아웃</a>
    </div>
    
	<!-- 카테고리 시작 -->
	<header>
		<label class="category-label" id="category-label"> <img src="image/menubar.png">카테고리
		</label> <label class="category-label" style="cursor:pointer;" onclick="window.location.href='../home/home.jsp'">홈</label> <label class="category-label">인기</label>
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
						<img src="<%= fundingImage %>" alt="Slide 1">
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
				<p id="funding-category"><%= categoryFunding %></p>
				<b id="funding-name"><%= fundingTitle %></b>
				
				<!-- 수정 부분 남은 날짜 추가. -->
				<div class="info-box">
					<h2 id="funding-people"><%= userCount %> <span style="font-size: 0.7em; font-weight: 600;">명 참여</span></h2>
					<label class="funding-box" style="color: red;"><%= fndMgr.fundDate(fundingNum) %>일 남음</label>
				</div>
				<!-- 수정 부분 달성 퍼센트 추가. -->
				<div class="info-box">
					<h2 id="funding-money"><%= fundingNprice %> <span style="font-size: 0.7em; font-weight: 600;">원 달성</span></h2>
					<label class="funding-box"><%= fundingData.getFunding_nprice() * 100 / fundingData.getFunding_tprice() %>% 달성</label>
				</div>
				<hr id="default-hr" width="100%" noshade />
				<div class="funding-detail">
					<p>목표 금액 : <%= fundingTprice %> 원</p>
					<p>펀딩 기간 : <%= fundingDate %> 정각 마감</p>
					<p>결제 : 목표 금액 달성 시 <%= fundingDate %> 익일에 결제 진행</p>
				</div>
				<div id="funding-buttons">
					<div class="button-container">
					    <form action="updateWishStatus.jsp" method="post">
					        <input type="hidden" name="fundingNum" value="<%= fundingNum %>">
					        <input type="hidden" name="userId" value="<%= user_id %>">
					        <button type="submit" class="circle-button">
					            <img src="image/heartbutton.png" alt="하트 버튼" style="cursor:pointer;"></img>
					        </button>
					    </form>
					    <span class="button-number"><%= wishCount %></span>
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
						<%
							if (commentsList != null && !commentsList.isEmpty()) {
								for (commentsBean comment : commentsList) {
									int daysAgo = new commentsMgr().commentDate(comment.getComment_num()); // 댓글 작성일로부터 경과된 일수 가져오기
									// 댓글 작성자의 user_name 가져오기
									usersBean commentUser = uMgr.oneUserList(comment.getComment_user_id());
									usersBean replyUser = uMgr.oneUserList(fundingUserId);
									// 해당 댓글의 추천 수 가져오기
					                int recomeCount = rMgr.recomeCount(comment.getComment_num());
						%>
						<div class="comment-engratf">	
										
						<div id="comments">				
							
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
										<p onclick="editComment(event)">수정</p>
										<p onclick="deleteComment(<%= comment.getComment_num() %>, <%= fundingNum %>)">삭제</p>
									</div>
									<%
							        } else if (user_id != null && user_id.equals(fundingUserId)) {
							        %>
									<img alt="option-icon" src="image/optionicon.png"
										onclick="toggleCommentDropdown(event)">
									<div id="comment-dropdown" class="dropdown-comment">
										<p onclick="replyToComment(event)">답변</p>
									</div>
									<%
							        }
							        %>
								</div>
							</div>
							<p id="comment-text"><%= comment.getComment_con() %></p>
							<textarea placeholder="<%= comment.getComment_con() %>" class="input_textarea" style="display:none;"></textarea>
							<input type="hidden" class="comment_num" value="<%= comment.getComment_num() %>"> <!-- 댓글 번호 hidden 필드 -->
							<input type="hidden" name="fundingNum" value="<%= fundingNum %>">
							<button class="save-button" onclick="saveComment(event)">변경하기</button>
							
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
						    
						   	</div><!-- comments 끝 -->	
						   	
						   	<!-- 댓글 답변 -->
						   	<div class="comment-reply" style="<%= (comment.getComment_ans() == null || comment.getComment_ans().isEmpty()) ? "display:none;" : "display:flex;" %>">
						   	
							<div id="comments-profile">
								<div id="comment-top">
									<img alt="information-image" src="<%=replyUser.getUser_image()%>">
									<div id="information-text">
										<b><%= replyUser.getUser_name() %></b>
									</div>
								</div>
								<div id="comment-option">
									<%
							        	if (user_id != null && user_id.equals(fundingUserId)) {
							        %>
									<img alt="option-icon" src="image/optionicon.png"
										onclick="toggleCommentDropdown(event)">
									<div id="comment-dropdown" class="dropdown-comment">
										<p onclick="deleteReply(<%= comment.getComment_num() %>, <%= fundingNum %>)">삭제</p>
									</div>
									<%
							        } 
									%>
								</div>
							</div>
							<p id="comment-text"><%= comment.getComment_ans() %></p> <!-- 답변 내용 표시 -->
							<textarea placeholder="답변을 입력하세요..." class="input_textarea" style="display:none;"></textarea>
							<input type="hidden" class="comment_num" value="<%= comment.getComment_num() %>">
							<button class="save-button" onclick="saveReply(event)" style="display:none;">작성</button>
							
							<div id="comment-bottom">
								<div id="comment-recommend">
								    <form action="commentInsert.jsp" method="post">
								        <input type="hidden" name="recom_comment_num" value="<%= comment.getComment_num() %>"> 
								        <input type="hidden" name="fundingNum" value="<%= fundingNum %>">
								    </form>
								</div>
						    </div>
						   	
						   		</div> <!-- comment-reply 끝 -->
						   		
						   	</div><!-- comment-engratf 끝 -->
								<%
							            }
								
							        } else{ %>
							        
							    
							        <p>댓글이 없습니다.</p>

							    <%
							        }
							    %>
					
						
					</div> <!-- community 끝 -->
					
				</div> <!-- community-content 끝 -->
				
			</div> <!-- content 끝 -->
			
		</div> <!-- left-section 끝 -->

		<div class="right-section">
    
        <div id="creator-content">    
            <div id="creator-box">
                <b style="font-size: 18px">창작자 소개</b>
                <div id="creator-info">
                    <img alt="creator-image" src="<%= uMgr.oneUserList(fundingUserId).getUser_image() %>">
                    <a><%= uMgr.oneUserList(fundingUserId).getUser_name() %></a>
                </div>
                
                <p id="creator-intro">
                <%=uMgr.oneUserList(fundingUserId).getUser_info() %>
                </p>
                <hr id="default-hr" width="100%" noshade />
                <div id="creator-buttons">
                    <button id="inquiry-button">창작자 문의</button>
                    <form action="<%= isFollowing ? "followDelete.jsp" : "followInsert.jsp" %>" method="post"> <!-- 팔로우 여부에 따라 action 변경 -->
                        <input type="hidden" name="follow_set_user_id" value="<%= user_id %>">
                        <input type="hidden" name="follow_get_user_id" value="<%= fundingUserId %>">
                        <input type="hidden" name="fundingNum" value="<%= fundingNum %>">
                        <button type="submit" id="follow-button"><%= isFollowing ? "팔로우 취소" : "+ 팔로우" %></button> <!-- 텍스트 변경 -->
                    </form>
                </div>
            </div>
        </div>
    
        <div class="donate-content">
            <b>선물하기</b>

            <!-- 상품 선택(구매) 예시 -->
            <div class="product-buy" style="display: none;"> <!-- 기본적으로 숨김 -->
                <div class="buy-info">
                    <label class="product-information"> 
                    <div class="product-title">
                        <b><!-- "donate-information" 이름 --></b>
                        <button id="delete-button">X</button>
                    </div>
                        
                    <div class="product-bottom">
                        <div class="stepper">
                            <button type="button" id="decrease" disabled>-</button>
                            <input type="number" value="1" class="stepper-input" readonly>
                            <button type="button" id="increase">+</button>
                        </div>
                        <p><!-- "donate-information" 금액 --></p>
                    </div>
                    </label>
                </div>
                <button class="select-button">선물 선택하기</button>
                <button class="buy-button">총 <label class="button-price"><!-- "donate-information" 금액 --></label> 후원하기</button>
            </div>

            <!-- 상품 예시 반복문 시작 -->
            <% for (priceBean priceData : priceList) { %>
                <div class="donate-information" data-price-num="<%= priceData.getPrice_num() %>">
                    <p><%= priceData.getPrice_count() %>개 남음</p>
                    <b><%= priceData.getPrice() %>원</b>
                    <label class="product-information">
                        <%= priceData.getPrice_comp() %> <!-- 상품 제목 -->
                    </label>
                </div>
            <% } %>
            <!-- 상품 예시 반복문 끝 -->
            
        </div> <!-- donate-content 끝 -->
    </div> <!-- right-section 끝 -->
		
	</div> <!-- Main Bottom 끝 -->

	<hr id="default-hr" width="100%" noshade />

	<script src="detailInfo.js"></script>
	<script src="dropdown.js"></script>
	<script src="fundinglabel.js"></script>
	<script src="comment_dropdown.js"></script>
	<script src="stepper.js"></script>
	<script src="commentEdit.js"></script>
	<script src="commentReply.js"></script>
	<script src="productBuy.js"></script>
</body>
</html>

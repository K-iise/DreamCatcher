<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>

<% 
usersMgr uMgr = new usersMgr();
usersBean mybean = new usersBean();


String user_id = (String) session.getAttribute("idKey");

mybean=uMgr.oneUserList(user_id);

fundingMgr fdMgr=new fundingMgr();
readRecordMgr rMgr=new readRecordMgr();
alarmMgr aMgr=new alarmMgr();
createFundingMgr cfMgr=new createFundingMgr();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈 화면</title>
<link href="home.css" rel="stylesheet"/>
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
				<%
				Vector<fundingBean> fdjvlist=fdMgr.fundingListForPercent();
				int d3 = Math.min(4, fdjvlist.size());
				%>
				<div id="projects">
				<%for(int i=0;i<d3;i++){ %>
				
					<div id="interest-project">
					    <!-- 프로젝트 사진 -->
				
					    <a href="../fundingcheck/fundingcheck.jsp?fundingNum=<%=fdjvlist.get(i).getFunding_num()%>">
					        <img src=<%=fdjvlist.get(i).getFunding_image() %> >
					    </a>
					    <!-- 창작자 명 -->
					    <a class="creator-name" href="../profile/profile.jsp?userId=<%=fdjvlist.get(i).getFunding_user_id() %>">
					        <%=uMgr.oneUserList(fdjvlist.get(i).getFunding_user_id()).getUser_name() %>
					    </a><br>
					    <!-- 제품명 -->
					    <a href="../fundingcheck/fundingcheck.jsp?fundingNum=<%=fdjvlist.get(i).getFunding_num()%>">
					        <label class="product-name"><%=fdjvlist.get(i).getFunding_title() %></label>
					    </a><br>
					    <!-- 진행 정보 -->
					    <div class="progress-info">
					        <span class="progress-percentage"><%= (int)(((double)fdjvlist.get(i).getFunding_nprice() / fdjvlist.get(i).getFunding_tprice()) * 100)%>% 달성</span>
					    </div>
					</div>
				
				<%} %>
				</div>
			</div>
		</div>

		<!-- 오른쪽 섹션 (인기 프로젝트 랭킹) -->
		<div class="right-section">
			<div id="header-ranking">
				<div class="title-group">
					<h2>인기 프로젝트</h2>
					<p><%= LocalDate.now() %> 기준</p>
				</div>
				<a href="#">전체 보기</a>
			</div>
			<%
			Vector<fundingBean> fdivlist=fdMgr.fundingByRecordHigh();
			int d=5;
			if(fdivlist.size()<5) {d=fdivlist.size();}
			%>
			<%for(int i=0;i<d;i++){ %>
			<div id="project-ranking">
			 <a href="../fundingcheck/fundingcheck.jsp?fundingNum=<%=fdivlist.get(i).getFunding_num()%>">
				<img src='<%=fdivlist.get(i).getFunding_image()%>'> <b><%=i+1 %>등</b>
			</a>
				<div id="project-rankinfo">
					<a href="../profile/profile.jsp?userId=<%=fdivlist.get(i).getFunding_user_id() %>">
    					<b style="color: #6D6D6D !important"><%= uMgr.oneUserList(fdivlist.get(i).getFunding_user_id()).getUser_name() %></b>
					</a>
					<p>
						<%= fdivlist.get(i).getFunding_title() %>
					</p>
					<b><%= (int)(((double)fdivlist.get(i).getFunding_nprice() / fdivlist.get(i).getFunding_tprice()) * 100) %>% 달성</b>
				</div>
			</div>
			<%} %>
		</div>
	</div>
	
	<hr id="default-hr" width="100%" noshade />
	
	<!-- Main 화면 아래쪽 영역 -->
	<div class="MainBottom">
					<!-- 최근 본 프로젝트 -->
			<div class="recent-content">
				<div id="recent-head">
				<h2 style="margin: 20px;">최근 본 프로젝트</h2>
				<a href="#">전체 보기</a>
				</div>
				<div id="projects">
				<!-- 최대 5개 까지만 하면 좋음. -->
				<%
				Vector<fundingBean> fdcvlist=fdMgr.fundingByRecord(rMgr.readList30(user_id));
				int d2 = Math.min(5, fdcvlist.size());
				%>
				<%for(int i=0;i<d2;i++){ %>
					<div id="recent-project">
				    <!-- 프로젝트 사진 -->
				    <a href="../fundingcheck/fundingcheck.jsp?fundingNum=<%=fdcvlist.get(i).getFunding_num()%>">
				        <img src=<%=fdcvlist.get(i).getFunding_image()%> >
				    </a>
				    <!-- 창작자 명 -->
				    <a class="creator-name" href="../profile/profile.jsp?userId=<%=fdcvlist.get(i).getFunding_user_id()%>">
				        <%=uMgr.oneUserList(fdcvlist.get(i).getFunding_user_id()).getUser_name()%>
				    </a><br>
				    <!-- 제품명 -->
				    <a href="../fundingcheck/fundingcheck.jsp?fundingNum=<%=fdcvlist.get(i).getFunding_num()%>">
				        <label class="product-name"><%=fdcvlist.get(i).getFunding_title() %></label>
				    </a><br>
				    <!-- 진행 정보 -->
				    <div class="progress-info">
				        <span class="progress-percentage"><%= (int)(((double)fdcvlist.get(i).getFunding_nprice() / fdcvlist.get(i).getFunding_tprice()) * 100)%>% 달성</span>
				    </div>
				</div>
				<%} %>
				</div><!-- projects end -->
			</div> <!-- recent-content end-->
	</div>
	
	<hr id="default-hr" width="100%" noshade style="margin-top: 50px; margin-bottom: 50px;"/>
	
	<script src="slide.js"></script>
	<script src="detailInfo.js"></script>
	<script src="dropdown.js"></script>
</body>
</html>

<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>

<%
usersMgr uMgr = new usersMgr();
usersBean mybean = new usersBean();

String user_id = (String) session.getAttribute("idKey");

mybean = uMgr.oneUserList(user_id);

fundingMgr fdMgr = new fundingMgr();
readRecordMgr rMgr = new readRecordMgr();
alarmMgr aMgr = new alarmMgr();
createFundingMgr cfMgr = new createFundingMgr();

String categoryNumStr = request.getParameter("category_num");
//카테고리 번호가 지정되지 않았으면 기본값을 설정하지 않음
int categoryNum = (categoryNumStr != null) ? Integer.parseInt(categoryNumStr) : -1;
// 해당 카테고리의 funding 정보 가져오기
Vector<fundingBean> fundingList;
//categoryNum이 -1인 경우 모든 카테고리의 프로젝트 가져오기
if (categoryNum == -1) {
 fundingList = fdMgr.fundingListForAllCategories(); // 모든 카테고리의 프로젝트를 가져오는 메소드 추가 필요
} else {
 fundingList = fdMgr.fundingListForCategory(categoryNum);
}
// 프로젝트 수 계산
int projectCount = 0; // 카운트 초기화
Vector<fundingBean> activeFundingList = new Vector<>(); // 종료되지 않은 프로젝트를 저장할 리스트

for (fundingBean funding : fundingList) {
    int fundingNum = funding.getFunding_num();
    // 사용자의 이름을 가져오기 위해 usersMgr 호출
    usersBean user = uMgr.oneUserList(funding.getFunding_user_id());
    
    if (fdMgr.fundDate(fundingNum) > 0) { // 종료되지 않은 프로젝트만
        activeFundingList.add(funding); // 종료되지 않은 프로젝트를 리스트에 추가
        projectCount++; // 카운트 증가
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 화면</title>
<link href="categoryTab.css" rel="stylesheet" />
</head>
<body>

	<!-- 상단바 1 -->
	<header class="title-header">
		<h1>Dream Catcher</h1>
		<div>
			<%
			if (mybean.getUser_id() == null || mybean.getUser_id().equals("")) {
			%>
			<input type="button" class="upload-button"
				onclick="alert('로그인 해주세요');"> <input type="button"
				class="login-button" onclick="location.href='../login/login.jsp';">


			<%
			} else {
			%>
			<%
			if (cfMgr.createFundingCheck(mybean.getUser_id())) {
			%>
			<input type="button" class="upload-button"
				onclick="location.href='../projectUpload/projectBasicinfo.jsp'">
			<%
			} else {
			%>
			<input type="button" class="upload-button"
				onclick="location.href='../projectUpload/projectPlan.jsp'">
			<%
			}
			%>
			<input type="button" class="heart-button"
				onclick="location.href='../interestProject/interestProject.jsp'">
			<%
			if (aMgr.alarmOnOff(mybean.getUser_id())) {
			%>
			<input type="button" class="bell-button2"
				onclick="location.href='../alarm/alarm.jsp';">
			<%
			} else {
			%>
			<input type="button" class="bell-button"
				onclick="location.href='../alarm/alarm.jsp';">
			<%
			}
			%>

			<span class="dropbtn" onclick="toggleDropdown()"> <img
				src='<%=mybean.getUser_image()%>' alt="User Icon"> <b><%=mybean.getUser_name()%></b>
			</span>
		</div>

		<%
		}
		%>
	</header>

	<div class="dropdown-content">
		<a href="../profile/profile.jsp?selectedid=<%=user_id%>">프로필</a> <a
			href="../interestProject/interestProject.jsp">관심프로젝트</a> <a
			href="../alarm/alarm.jsp">알림</a> 
			<%if(mybean.getUser_master()==1){ %>
	    	<a href="../manager/managerUI.jsp">게시글 관리</a>
	    	<%} %>
			<a href="../logout/logout.jsp">로그아웃</a>
	</div>


	<!-- 카테고리 시작 -->
	<header>
		<label class="category-label" id="category-label"> <img
			src="image/menubar.png">카테고리
		</label> <label class="category-label" style="cursor: pointer;"
			onclick="window.location.href='../home/home.jsp'">홈</label> 
			<label onclick="window.location.href='../popularTab/popularTab.jsp'" class="category-label" style="cursor: pointer;">인기</label> 
			<label class="category-label">신규</label>
		<label class="category-label">스토어</label> 
		<form method="GET" action="../searchTab/searchTab.jsp">
		    <span class="search-span">
		        <input type="text" class="input_text" name="search" placeholder="검색어를 입력하세요." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
		        <button type="submit"><img alt="searchicon" src="image/searchicon.png" class="input_icon"></button>
		    </span>
		</form>

	</header>
	<!-- 카테고리 끝 -->

	<!-- 상세 카테고리 창 -->
	<div class="cat-container">
			<div class="depth1-wrapper">
				<div class="depth1-group">
					<div class="depth1-item"  onclick="location.href='../categoryTab/categoryTab.jsp?category_num=-1'">
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
					
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=1'" >
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/board.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">보드게임 · TRPG</div>
					</div>
					
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=2'">
				        <div class="depth1-icon">
				            <img 
				            	src="https://tumblbug-assets.imgix.net/categories/svg/digital-game.svg" 
				            	class="depth1-icon-img">
				        </div>
				        <div class="depth1-text">디지털 게임</div>
				    </div>
				    
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=3'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/comics.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">웹툰 · 만화</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=4'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/webtoon-resource.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">웹툰 리소스</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=5'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/stationary.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">디자인 문구</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=6'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/charactor-goods.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">캐릭터 · 굿즈</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=7'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/home-living.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">홈 · 리빙</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=8'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/tech-electronics.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">테크 · 가전</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=9'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/pet.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">반려동물</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=10'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/food.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">푸드</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=11'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/perfumes-cosmetics.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">향수 · 뷰티</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=12'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/fashion.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">의류</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=13'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/accessories.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">잡화</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=14'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/jewerly.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">주얼리</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=15'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/publishing.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">출판</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=16'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/design.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">디자인</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=17'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/art.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">예술</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=18'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/photography.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">사진</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=19'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/music.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">음악</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=20'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/film.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">영화 · 비디오</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=21'">
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

	<div class="Main">
		<div class="Main-header">
	
			<!-- 상세 카테고리 버튼 -->
			<div class="category-section">
				<button class="scroll-button left" onclick="scrollLeftItems()">◀</button>
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=-1'">
							<div class="category-icon">
								<svg width="48" height="48" viewBox="0 0 48 48" fill="none"
									xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd"
										d="M20.7158 12.1263H12.1263V20.7158H20.7158V12.1263ZM10.1052 10.1053V22.7369H22.7368V10.1053H10.1052Z"
										fill="#0D0D0D"></path>
                        <path fill-rule="evenodd" clip-rule="evenodd"
										d="M35.8736 12.1263H27.2842V20.7158H35.8736V12.1263ZM25.2631 10.1053V22.7369H37.8947V10.1053H25.2631Z"
										fill="#0D0D0D"></path>
                        <path fill-rule="evenodd" clip-rule="evenodd"
										d="M20.7158 27.2842H12.1263V35.8737H20.7158V27.2842ZM10.1052 25.2632V37.8948H22.7368V25.2632H10.1052Z"
										fill="#0D0D0D"></path>
                        <path
										d="M25.2632 25.2632H37.8948V37.8948H25.2632V25.2632Z"
										fill="#FF5757"></path>
                    </svg>
							</div>
							<div class="category-text">전체</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=1'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/board.svg"
									alt="보드게임 아이콘">
							</div>
							<div class="category-text">보드게임 · TRPG</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=2'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/digital-game.svg"
									alt="디지털 게임 아이콘">
							</div>
							<div class="category-text">디지털 게임</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=3'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/comics.svg"
									alt="웹툰 · 만화 아이콘">
							</div>
							<div class="category-text">웹툰 · 만화</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=4'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/webtoon-resource.svg"
									alt="웹툰 리소스 아이콘">
							</div>
							<div class="category-text">웹툰 리소스</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=5'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/stationary.svg"
									alt="디자인 문구 아이콘">
							</div>
							<div class="category-text">디자인 문구</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=6'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/charactor-goods.svg"
									alt="캐릭터 · 굿즈 아이콘">
							</div>
							<div class="category-text">캐릭터 · 굿즈</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=7'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/home-living.svg"
									alt="홈 · 리빙 아이콘">
							</div>
							<div class="category-text">홈 · 리빙</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=8'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/tech-electronics.svg"
									alt="테크 · 가전 아이콘">
							</div>
							<div class="category-text">테크 · 가전</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=9'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/pet.svg"
									alt="반려동물 아이콘">
							</div>
							<div class="category-text">반려동물</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=10'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/food.svg"
									alt="푸드 아이콘">
							</div>
							<div class="category-text">푸드</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=11'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/perfumes-cosmetics.svg"
									alt="향수 · 뷰티 아이콘">
							</div>
							<div class="category-text">향수 · 뷰티</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=12'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/fashion.svg"
									alt="의류 아이콘">
							</div>
							<div class="category-text">의류</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=13'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/accessories.svg"
									alt="잡화 아이콘">
							</div>
							<div class="category-text">잡화</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=14'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/jewerly.svg"
									alt="주얼리 아이콘">
							</div>
							<div class="category-text">주얼리</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=15'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/publishing.svg"
									alt="출판 아이콘">
							</div>
							<div class="category-text">출판</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=16'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/design.svg"
									alt="디자인 아이콘">
							</div>
							<div class="category-text">디자인</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=17'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/art.svg"
									alt="예술 아이콘">
							</div>
							<div class="category-text">예술</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=18'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/photography.svg"
									alt="사진 아이콘">
							</div>
							<div class="category-text">사진</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=19'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/music.svg"
									alt="음악 아이콘">
							</div>
							<div class="category-text">음악</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=20'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/film.svg"
									alt="영화 · 비디오 아이콘">
							</div>
							<div class="category-text">영화 · 비디오</div>
						</div>
						<div class="category-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=21'">
							<div class="category-icon">
								<img
									src="https://tumblbug-assets.imgix.net/categories/svg/performing-art.svg"
									alt="공연 아이콘">
							</div>
							<div class="category-text">공연</div>
						</div>
					</div>
				</div>
				<button class="scroll-button right" onclick="scrollRightItems()">▶</button>
			</div>

			<!-- 현재 카테고리 제목 -->
			<div class="current-text"><%= fdMgr.getCategory(categoryNum) %></div>

			<!-- 달성률 드롭다운. -->
			<div class="dropdown1">
			    <select id="add-sort" onchange="filterProjects()">
			        <option value="added">전체보기</option>
			        <option value="less_than_75">75% 이하</option>
			        <option value="between_75_and_100">75% ~ 100%</option>
			        <option value="more_than_100">100% 이상</option>
			    </select>
			</div>
		</div>

		<div class="Main-body">
			<div class="body-header">총
				<span style="color: red"> <%= projectCount %></span> 개의 프로젝트가 있습니다.
			</div>

			<div class="body-content">
            <!-- funding 정보를 출력 -->
	            <%
	            	
	                for (fundingBean funding : fundingList) {
	                	int fundingNum = funding.getFunding_num();
	                	 // 사용자의 이름을 가져오기 위해 usersMgr 호출
			            usersBean user = uMgr.oneUserList(funding.getFunding_user_id());
			            if (fdMgr.fundDate(fundingNum) > 0) {
	            %>
	            <!-- 샘플 프로젝트 -->
	            <div id="interest-project" class="funding-project" data-percentage="<%= funding.getFunding_nprice() * 100 / funding.getFunding_tprice() %>">
	                <!-- 프로젝트 사진 -->
	                <a href="../fundingcheck/fundingcheck.jsp?fundingNum=<%= funding.getFunding_num() %>">
				        <img src="<%= funding.getFunding_image() %>" alt="프로젝트 이미지">
				    </a>
	                <!-- 창작자 명 -->
	                <a class="creator-name" href="../profile/profile.jsp?userId=<%=user.getUser_id() %>"><%= user.getUser_name() %></a><br>
	                <!-- 제품명 -->
	                <label class="product-name"><%= funding.getFunding_title() %></label><br>
	                <!-- 진행 정보 -->
	                <div class="progress-info">
	                    <span class="progress-percentage"><%= funding.getFunding_nprice() * 100 / funding.getFunding_tprice() %>%</span> 
	                    <span class="progress-amount"><%= funding.getFunding_nprice() %>원</span> 
	                    <span class="progress-time">
							<% if (fdMgr.fundDate(fundingNum) > 0) {%>
			                <%= fdMgr.fundDate(fundingNum) %>일 남음
			            	<% } else { %>
			                종료
			            	<% } %>
						</span>
	                </div>
	                <!-- 진행 바 -->
	                <progress id="progress" value="<%= funding.getFunding_nprice() %>" max="<%= funding.getFunding_tprice() %>"></progress>
	            </div>
	            <!-- 샘플 프로젝트 끝 -->
	            <%
			            }
	                }
	            %>
	        </div>
			<!-- body-content 끝 -->

		</div>
		<!-- Main-body 끝 -->

	</div>
	<!-- Main 끝 -->

	<script src="detailInfo.js"></script>
	<script src="dropdown.js"></script>
	<script src="categoryslide.js"></script>
</body>
</html>

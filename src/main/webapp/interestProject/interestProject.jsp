<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="control.*" %>
<%@page import="entity.*" %>

<%
	String id = (String)session.getAttribute("idKey");
	readRecordMgr rmgr = new readRecordMgr();
	fundingMgr fmgr = new fundingMgr();
	usersMgr umgr = new usersMgr();
	usersBean mybean = new usersBean();
	mybean=umgr.oneUserList(id);
	
	// 사용자 ID와 관련된 read_wish가 1인 read_funding_num 가져오기
    Vector<readRecordBean> wishList = rmgr.readListWish(id);
    String message = "";
    
 	// 현재 선택된 정렬 옵션
    String selectedSort = request.getParameter("sortType");
    if (selectedSort == null) {
        selectedSort = "all"; // 기본값 설정
    }
    
    if (wishList.size() > 0) {
        StringBuilder fundingNums = new StringBuilder();
        for (readRecordBean bean : wishList) {
            fundingNums.append(bean.getRead_funding_num()).append(", ");
        }
    }
    
 	// 유저 이름을 위한 유저리스트 가져오기
    Vector<usersBean> userList = umgr.userList();
    // 유저 이름 찾기
    String userName = "";
    for (usersBean user : userList) {
        if (user.getUser_id().equals(id)) {
            userName = user.getUser_name();
            break; // 사용자를 찾으면 루프 종료
        }
    }
    
    alarmMgr aMgr=new alarmMgr();
    createFundingMgr cfMgr=new createFundingMgr();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심프로젝트 화면</title>
<link href="interestProject.css" rel="stylesheet" />
<script>
        // 카테고리 색상 변경.
        function highlight(selectedLabel, contentId) {
            // 모든 프로필 라벨 색상 초기화
            const labels = document.querySelectorAll('.interest-label');
            labels.forEach(label => {
                label.classList.remove('active');
            });

            // 선택된 라벨 색상 변경
            selectedLabel.classList.add('active');

            // 모든 콘텐츠 숨기기
            const contents = document.querySelectorAll('.tab-content');
            contents.forEach(content => {
                content.style.display = 'none';
            });

            // 선택된 콘텐츠만 보이기
            document.getElementById(contentId).style.display = 'block';
        }
        
        // 드롭다운 색상 변경
        function changeColor(selectElement) {
            const options = selectElement.options;

            // 모든 옵션의 색상 초기화
            for (let i = 0; i < options.length; i++) {
                options[i].style.color = 'black'; // 기본 색상
            }

            // 선택된 옵션의 색상을 빨간색으로 변경
            options[selectElement.selectedIndex].style.color = 'red';
        }

        // 페이지가 로드될 때 드롭다운의 선택 상태를 유지하는 함수
        window.onload = function() {
            const sortType = "<%= selectedSort != null ? selectedSort : "all" %>";
            document.getElementById(sortType).selected = true;
        };
</script>
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
		<a href="../profile/profile.jsp?selectedid=<%=id%>">프로필</a>
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
    
    <!-- 카테고리 끝 -->
    <hr id="default-hr" width="100%" noshade />

    <!-- 관심 프로젝트 -->
    <div class="interest">
        <h1>관심 프로젝트</h1>
    </div>

    <!-- 관심 카테고리 시작 -->
    <div>
        <label class="interest-label active"
            onclick="highlight(this, 'interest-content')">좋아한</label> <label
            class="interest-label" onclick="highlight(this, 'alarm-content')">알림신청</label>
        <hr id="highlight-hr" width="100%" noshade />
    </div>

    <!-- 각 관심 카테고리 마다 사용될 body. -->
    <div id="content">
        <div id="interest-content" class="tab-content">	

            <!-- 정렬 드롭다운들 -->
            <div class="dropdown1-array">
                <!-- 날짜순 드롭다운 -->
                <div class="dropdown1">
                    <form method="get" action="">
                        <select id="date-sort" name="sortType" onchange="this.form.submit(); changeColor(this)"> 
					    <option value="all" <%= "all".equals(selectedSort) ? "selected" : "" %>>전체</option> 
					    <option value="ongoing" <%= "ongoing".equals(selectedSort) ? "selected" : "" %>>진행중</option> 
					    <option value="ended" <%= "ended".equals(selectedSort) ? "selected" : "" %>>종료된</option> 
					</select>
                    </form>
                </div>
                
                <!-- 추가순 드롭다운 -->
                <div class="dropdown1">
                    <select id="add-sort" onchange="changeColor(this)"> 
                        <option value="added">추가순</option> 
                        <option value="deadline_approaching">마감 임박순</option> 
                    </select>
                </div>
            </div>
        
	        <div id="projects">

			    <%	
			        // 각 funding_num에 대해 funding 정보를 가져와서 출력
			        if (wishList.size() > 0) {
			            for (readRecordBean bean : wishList) {
			    %>
			    <%
			        int fundingNum = bean.getRead_funding_num();
			        Vector<fundingBean> fundingInfo = fmgr.fundingListForNum(fundingNum);
			
			        // funding 정보가 있는 경우 출력
			        if (fundingInfo.size() > 0) {
			            fundingBean funding = fundingInfo.get(0); // 첫 번째 결과만 사용
			
			            // 사용자의 이름을 가져오기 위해 usersMgr 호출
			            usersBean user = umgr.oneUserList(funding.getFunding_user_id());
			
			            // 진행 상태 확인
			            boolean isOngoing = fmgr.fundDate(fundingNum) > 0;
			            boolean isEnded = fmgr.fundDate(fundingNum) <= 0;
			
			            // 선택된 정렬 옵션에 따라 출력 조건
			            if ("ongoing".equals(selectedSort) && isOngoing) {
			    %>
			    <div id="interest-project">
			        <!-- 프로젝트 사진 -->
			        <img src="<%= funding.getFunding_image() %>" alt="<%= funding.getFunding_title() %>"> 
			        <!-- 창작자 명 -->
			        <a class="creator-name" href="../profile/profile.jsp?userId=<%=user.getUser_id() %>"><%= user.getUser_name() %></a><br>
			        <!-- 제품명 -->
			        <label class="product-name"><%= funding.getFunding_title() %></label><br>
			        <!-- 진행 정보 -->
			        <div class="progress-info">
			            <span class="progress-percentage"><%= (funding.getFunding_nprice() * 100 / funding.getFunding_tprice()) + "%" %></span> 
			            <span class="progress-amount"><%= funding.getFunding_nprice() %>원</span> 
			            <span class="progress-time">
			            <% if (fmgr.fundDate(fundingNum) > 0) {%>
			                <%= fmgr.fundDate(fundingNum) %>일 남음
			            <% } else { %>
			                종료
			            <% } %>
			            </span>
			        </div>
			        <!-- 진행 바 -->
			        <progress id="progress" value="<%= funding.getFunding_nprice() %>" min="0" max="<%= funding.getFunding_tprice() %>"></progress>
			        <hr /> <!-- 구분선 추가 -->
			    </div>
			    <%
			            } else if ("ended".equals(selectedSort) && isEnded) {
			    %>
			    <div id="interest-project">
			        <!-- 종료된 프로젝트만 출력하는 블록 -->
			        <!-- 프로젝트 사진 -->
			        <img src="<%= funding.getFunding_image() %>" alt="<%= funding.getFunding_title() %>"> 
			        <!-- 창작자 명 -->
			        <a class="creator-name" href="../profile/profile.jsp?userId=<%=user.getUser_id() %>"><%= user.getUser_name() %></a><br>
			        <!-- 제품명 -->
			        <label class="product-name"><%= funding.getFunding_title() %></label><br>
			        <!-- 진행 정보 -->
			        <div class="progress-info">
			            <span class="progress-percentage"><%= (funding.getFunding_nprice() * 100 / funding.getFunding_tprice()) + "%" %></span> 
			            <span class="progress-amount"><%= funding.getFunding_nprice() %>원</span> 
			            <span class="progress-time">종료</span>
			        </div>
			        <!-- 진행 바 -->
			        <progress id="progress" value="<%= funding.getFunding_nprice() %>" min="0" max="<%= funding.getFunding_tprice() %>"></progress>
			        <hr /> <!-- 구분선 추가 -->
			    </div>
			    <%
			            } else if ("all".equals(selectedSort)) { // 'all' 선택 시
			    %>
			    <div id="interest-project">
			        <!-- 모든 프로젝트를 출력하는 블록 -->
			        <!-- 프로젝트 사진 -->
			        <img src="<%= funding.getFunding_image() %>" alt="<%= funding.getFunding_title() %>"> 
			        <!-- 창작자 명 -->
			        <a class="creator-name" href="../profile/profile.jsp?userId=<%=user.getUser_id() %>"><%= user.getUser_name() %></a><br>
			        <!-- 제품명 -->
			        <label class="product-name"><%= funding.getFunding_title() %></label><br>
			        <!-- 진행 정보 -->
			        <div class="progress-info">
			            <span class="progress-percentage"><%= (funding.getFunding_nprice() * 100 / funding.getFunding_tprice()) + "%" %></span> 
			            <span class="progress-amount"><%= funding.getFunding_nprice() %>원</span> 
			            <span class="progress-time">
			            <% if (fmgr.fundDate(fundingNum) > 0) {%>
			                <%= fmgr.fundDate(fundingNum) %>일 남음
			            <% } else { %>
			                종료
			            <% } %>
			            </span>
			        </div>
			        <!-- 진행 바 -->
			        <progress id="progress" value="<%= funding.getFunding_nprice() %>" min="0" max="<%= funding.getFunding_tprice() %>"></progress>
			        <hr /> <!-- 구분선 추가 -->
			    </div>
			    <%
			            }
			        }				           
			    %>
			    <% 
			            }
			        } else {
			            message = "관심 프로젝트가 없습니다.";
			        }
			    %>

			</div>
        </div>
    </div>
    <script src="dropdown.js"></script>
    <script src="detailInfo.js"></script>
</body>
</html>
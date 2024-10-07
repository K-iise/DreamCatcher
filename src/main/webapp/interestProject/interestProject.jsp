<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="control.readRecordMgr" %>
<%@page import="entity.readRecordBean" %>
<%@page import="control.fundingMgr" %>
<%@page import="entity.fundingBean" %>
<%@page import="control.usersMgr" %> 
<%@page import="entity.usersBean" %>
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심프로젝트 화면</title>
<style>
body {
	margin: 0; /* 기본 여백 제거 */
	padding: 0 15%; /* 왼쪽과 오른쪽에 15%의 여백 추가 */
}

.category-label {
	font-size: 25px; /* 원하는 크기로 변경 */
	font-weight: 700;
	margin-right: 20px;
}

.category-label img {
	width: 20px; /* 이미지의 너비를 조정 */
	height: 20px; /* 이미지의 높이를 조정 */
	margin-right: 15px; /* 이미지와 텍스트 사이의 간격 */
}

/* 마우스를 올렸을 때의 스타일 */
.category-label:hover {
	color: red; /* 마우스 오버 시 텍스트 색상 */
}

.category-label:hover img {
	filter: brightness(0) saturate(100%) invert(26%) sepia(93%)
		saturate(2500%) hue-rotate(351deg) brightness(100%) contrast(100%);
	/* 이미지 색상 변경 */
}

.interest-label {
	font-size: 20px; /* 원하는 크기로 변경 */
	font-weight: 500;
	margin-right: 30px;
	color: gray; /* 기본 텍스트 색상 */
	cursor: pointer; /* 클릭 가능 표시 */
}

.active {
	color: black; /* 활성화된 텍스트 색상 */
}

hr {
	border: none; /* 기본 경계 제거 */
	height: 1px; /* 높이 설정 */
	background-color: #dee2e6; /* 기본 색상 */
}

.interest {
	display: flex; /* Flexbox 사용 */
	margin-bottom: 20px;
	margin-top: 20px;
	align-items: center; /* 추가 */
}

.search-span {
	width: 260px; /* 너비를 조정 */
	height: 35px; /* 높이를 조정 */
	border: 1px solid #000000;
	float: right;
	display: flex; /* Flexbox 사용 */
	align-items: center; /* 추가 */
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

.title-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.title-header div {
    display: flex;
    align-items: center; /* 내부 요소 수직 가운데 정렬 */
}


.title-header .upload-button {
	background: url("image/uploadproject.png") no-repeat;
	width: 140px;
	height: 40px;
	border-width: 0;
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
	display: inline-block; /* 인라인 블록으로 변경하여 크기 제한 적용 */
	width: 150px;
	padding: 15px;
	align-items: center; /* 수직 가운데 정렬 */
	border: 1px solid black; /* 테두리 두께, 스타일, 색상 모두 명시 */
	margin-left: 20px;
	white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 */
    overflow: hidden; /* 넘치는 텍스트 숨기기 */
    text-overflow: ellipsis; /* 말줄임표(...) 적용 */
}

.title-header span img {
	width: 35px; /* 원하는 너비 설정 */
	height: 35px; /* 원하는 높이 설정 */
	vertical-align: middle;
	margin-right: 5px;
}

#projects {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap; /* 아이템들이 넘치면 줄 바꿈 */
}

/* 추가한 스타일 */
#interest-project img {
	width: 320px; /* 원하는 너비 설정 */
	height: 320px; /* 원하는 높이 설정 */
}

#interest-project {
	width: 324px; /* 원하는 너비 설정 */
	height: 457px; /* 비율 유지 */
	margin-right: 50px; /* 오른쪽 여백 */
	margin-bottom: 10px; /* 아래쪽 여백 */
}

.creator-name {
	font-size: 15px; /* 창작자 이름 크기 */
	font-weight: bold; /* 굵게 */
	color: #6D6D6D; /* 색상 */
	text-decoration: none; /* 밑줄 제거 */
}

.creator-name:hover {
    text-decoration: underline; /* 마우스 오버 시 밑줄 추가 */
    color: #6D6D6D; /* 마우스 오버 시 색상 변경 (원하는 색상으로 조정) */
}

.product-name {
	font-size: 18px; /* 제품명 크기 */
	font-weight: bold; /* 굵게 */
	color: #000000; /* 색상 */
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

progress {
	width: 100%; /* 부모 요소의 너비에 맞춤 */
	height: 3px; /* 높이 설정 */
	appearance: none; /* 기본 스타일 제거 */
	background-color: #e0e0e0; /* 배경 색상 */
	margin-top: 5px; /* progress 위쪽 여백 추가 */
	margin-bottom: 13px; /* progress 아래쪽 여백 추가 (필요에 따라 조정) */
}

progress::-webkit-progress-bar {
	background-color: #e0e0e0; /* 배경 색상 (Webkit 브라우저 전용) */
	border-radius: 10px; /* 모서리 둥글게 */
}

progress::-webkit-progress-value {
	background-color: red; /* 진행 바 색상 (Webkit 브라우저 전용) */
	border-radius: 10px; /* 모서리 둥글게 */
}

progress::-moz-progress-bar {
	background-color: red; /* 진행 바 색상 (Firefox 전용) */
	border-radius: 10px; /* 모서리 둥글게 */
}

.progress-info {
	display: flex; /* Flexbox 사용 */
	justify-content: space-between; /* 공간을 균등하게 배분 */
	align-items: center; /* 수직 정렬 */
	margin-top: 5px; /* 위쪽 여백 */
	margin-bottom: 0px;
}

.progress-percentage {
	font-size: 15px; /* 폰트 크기 */
	font-weight: bold; /* 굵게 */
	color: red; /* 텍스트 색상 */
	width: 30%; /* 고정 너비 설정 */
}

.progress-amount {
	font-size: 13px; /* 폰트 크기 */
	color: #000000; /* 텍스트 색상 */
	width: 70%; /* 고정 너비 설정 */
}

.progress-time {
	font-size: 15px; /* 폰트 크기 */
	color: #000000; /* 텍스트 색상 */
	width: 30%; /* 고정 너비 설정 */
	text-align: right; /* 오른쪽 정렬 */
}

.dropdown1-array {
    display: flex; /* Flexbox 사용 */
    justify-content: space-between; /* 양쪽 끝에 배치 */
    margin-top: 20px; /* 위쪽 여백 추가 (필요에 따라 조정) */
    margin-bottom: 20px;
}

.dropdown1 select {
    padding: 5px; /* 패딩 */
    font-size: 18px; /* 글자 크기 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 2px; /* 모서리 둥글게 */
    background-color: white; /* 배경색 */
    cursor: pointer; /* 커서 변경 */
}


/* 선택된 옵션의 색상 변경 */
.dropdown1 select option:hover {
    background-color: #D0D0D0; /* 옵션에 마우스를 올렸을 때 배경 색상 */
}

.selected-option {
    color: red;
}

</style>

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
			<input type="button" class="upload-button" onclick=""> 
			<input type="button" class="login-button" onclick="location.href='../login/login.jsp';">


			<%
			} else {
			%>

			<input type="button" class="upload-button" onclick=""> 
			<input type="button" class="heart-button" onclick="location.href='../interestProject/interestProject.jsp'">
			<input type="button" class="bell-button" onclick="location.href='../alarm/alarm.jsp';"> 
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
        <label class="category-label"><img src="image/menubar.png">카테고리</label>
        <label class="category-label" style="cursor:pointer;" onclick="window.location.href='../home/home.jsp'">홈</label> <label class="category-label">인기</label>
        <label class="category-label">신규</label> <label class="category-label">스토어</label>

        <span class="search-span"> <input type="text"
            class="input_text" name="search" placeholder="검색어를 입력하세요."> <img
            alt="searchicon" src="image/searchicon.png" class="input_icon">
        </span>
    </header>
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
	            <div id="interest-project">
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
				                        <!-- 프로젝트 사진 -->
				                        <img src="<%= funding.getFunding_image() %>" alt="<%= funding.getFunding_title() %>"> 
				                        <!-- 창작자 명 -->
				                        <a class="creator-name"><%= user.getUser_name() %></a><br>
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
				   <%
				                    } else if ("ended".equals(selectedSort) && isEnded) {
				   %>
				                        <!-- 프로젝트 사진 -->
				                        <img src="<%= funding.getFunding_image() %>" alt="<%= funding.getFunding_title() %>"> 
				                        <!-- 창작자 명 -->
				                        <a class="creator-name"><%= user.getUser_name() %></a><br>
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
				   <%
				                    } else if ("all".equals(selectedSort)) { // 'all' 선택 시
				   %>
				                        <!-- 프로젝트 사진 -->
				                        <img src="<%= funding.getFunding_image() %>" alt="<%= funding.getFunding_title() %>"> 
				                        <!-- 창작자 명 -->
				                        <a class="creator-name"><%= user.getUser_name() %></a><br>
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
				   <%
				                    }
				                }				           
				   %>
				</div>
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
</body>
</html>
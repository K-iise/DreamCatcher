<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>


<%@ page import="control.*" %>
<%@ page import="entity.*" %>



<%@ page import="control.usersMgr"%>
<%@ page import="entity.usersBean"%>
<%@ page import="control.followMgr"%>
<%@ page import="entity.followBean"%>
<%@ page import="control.fundingMgr"%>
<%@ page import="entity.fundingBean"%>

<%
String user_id = (String) session.getAttribute("idKey");
String selectedId = request.getParameter("selectedid");
String selectuserId=selectedId;
String myId=user_id;
if(request.getParameter("userId")!=null){
selectuserId = request.getParameter("userId");
}

usersMgr uMgr = new usersMgr();
followBean fbean = new followBean();
followMgr fMgr = new followMgr();
buyRecordMgr brMgr=new buyRecordMgr();
alarmMgr aMgr=new alarmMgr();
createFundingMgr cfMgr=new createFundingMgr();

usersBean ubean = uMgr.oneUserList(selectuserId);
usersBean mybean = uMgr.oneUserList(myId);


if(ubean.getUser_image()==null||ubean.getUser_image().equals("")){
	
	ubean.setUser_image("image/guest.png");
	
}


if(mybean.getUser_image()==null||mybean.getUser_image().equals("")){
	
	mybean.setUser_image("image/guest.png");
	

}

int follower = fMgr.getFollowerCount(ubean.getUser_id());
int following = fMgr.getFollowingCount(ubean.getUser_id());

fundingMgr fdMgr = new fundingMgr();

Vector<fundingBean> fdvlist = fdMgr.fundingListForUserId(ubean.getUser_id());



int fdCount=fdMgr.fundingCount(ubean.getUser_id());

Vector<followBean> fgvlist=fMgr.followerList(ubean.getUser_id());
Vector<followBean> fsvlist=fMgr.followingList(ubean.getUser_id());

String followAction = request.getParameter("followAction");
String redirectTab = request.getParameter("redirectTab");

if ("follow".equals(followAction)) {
    followBean bean = new followBean();
    bean.setFollow_set_user_id(mybean.getUser_id());
    bean.setFollow_get_user_id(ubean.getUser_id());
    
    fMgr.followInsert(bean); // followInsert 호출
    response.sendRedirect("profile.jsp?userId="+selectuserId); // 성공 알림
}
else if("follow-delete".equals(followAction)){
	
	 followBean bean = new followBean();
	    bean.setFollow_set_user_id(mybean.getUser_id());
	    bean.setFollow_get_user_id(ubean.getUser_id());
	    
	    fMgr.followDelete(bean); // followInsert 호출
	    response.sendRedirect("profile.jsp?userId="+selectuserId);
	
}else if ("follower2".equals(followAction)) {
    String set_user_id = request.getParameter("set_user_id");
    String get_user_id = request.getParameter("get_user_id");
    
    followBean bean = new followBean();
    bean.setFollow_set_user_id(set_user_id);
    bean.setFollow_get_user_id(get_user_id);
    
    // 팔로우 작업 수행 (예: 데이터베이스에 추가)
    fMgr.followInsert(bean); // followInsert 호출
    response.sendRedirect("profile.jsp?userId="+selectuserId);
    
   
}else if ("follower2-delete".equals(followAction)) {
    String set_user_id = request.getParameter("set_user_id");
    String get_user_id = request.getParameter("get_user_id");
    
    followBean bean = new followBean();
    bean.setFollow_set_user_id(set_user_id);
    bean.setFollow_get_user_id(get_user_id);
    
    // 팔로우 작업 수행 (예: 데이터베이스에 추가)
    fMgr.followDelete(bean); // followInsert 호출;
    response.sendRedirect("profile.jsp?userId="+selectuserId);
    
   
}else if ("following2".equals(followAction)) {
    String set_user_id = request.getParameter("set_user_id");
    String get_user_id = request.getParameter("get_user_id");
    
    followBean bean = new followBean();
    bean.setFollow_set_user_id(set_user_id);
    bean.setFollow_get_user_id(get_user_id);
    
    // 팔로우 작업 수행 (예: 데이터베이스에 추가)
    fMgr.followInsert(bean); // followInsert 호출
    response.sendRedirect("profile.jsp?userId="+selectuserId);
    
   
}else if ("following2-delete".equals(followAction)) {
    String set_user_id = request.getParameter("set_user_id");
    String get_user_id = request.getParameter("get_user_id");
    
    followBean bean = new followBean();
    bean.setFollow_set_user_id(set_user_id);
    bean.setFollow_get_user_id(get_user_id);
    
    // 팔로우 작업 수행 (예: 데이터베이스에 추가)
    fMgr.followDelete(bean); // followInsert 호출;
    response.sendRedirect("profile.jsp?userId="+selectuserId);
    
   
}





%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 화면</title>
<style>
</style>
<link href="profile.css" rel="stylesheet">
<script>
		function highlight(selectedLabel, contentId) {
		    // 모든 프로필 라벨 색상 초기화
		    const labels = document.querySelectorAll('.profile-label');
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
        
        function copyToClipboard() {
            
            navigator.clipboard.writeText(request.getRequestURL().toString()).then(function() {
                alert("링크를 복사했습니다");
            }, function(err) {
                alert("복사 실패: " + err);
            });
        }
        
       
        


</script>
</head>
<body>
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
		</label> <label class="category-label" style="cursor:pointer;" onclick="window.location.href='../home/home.jsp'">홈</label> <label onclick="window.location.href='../popularTab/popularTab.jsp'" class="category-label" style="cursor: pointer;">인기</label>
		<label class="category-label">신규</label> <label class="category-label">스토어</label>

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
					<div class="depth1-item"  onclick="location.href='../categoryTab/categoryTab.jsp'">
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

	<!-- 프로필 정보 -->
	<div class="profile">

		<img src='<%=ubean.getUser_image() %>' alt="Profile Image">

		<div class="profile-info">
			<b><%=ubean.getUser_name()%></b>
			<div class="profile-detail">
				<div>
					<b>팔로워</b><br>
					<%=follower%>
				</div>
				<div>
					<b>팔로잉</b><br>
					<%=following%>
				</div>
				<div>
					<b>누적 후원자</b><br> 
					<%=brMgr.buyRecordTotalCount(ubean.getUser_id()) %>
				</div>
			</div>
		</div>
		<div class="profile-buttons">
			<!-- 새로운 Flexbox div 추가 -->
			<%
			if (mybean.getUser_id().equals(ubean.getUser_id())) {
			%>
			<input type="button" class="edit-button" onclick="location.href='../profileEdit/profileEdit.jsp';">
			<%
			} else {
			%>
			<input type="button" class="share-button" onclick="copyToClipboard()"> 
			
			<%if(fMgr.followCheck(mybean.getUser_id(), ubean.getUser_id())){ %>
			
			<form method="post" id="followdeleteForm">
				<input type="hidden" name="followAction" value="follow-delete">
				<input type="hidden" name="set_user_id" value="<%=mybean.getUser_id()%>">
				<input type="hidden" name="get_user_id" value="<%=ubean.getUser_id()%>">
				<input type="hidden" name="redirectTab" value="followers-content">
				<input type="button" class="follow-delete-button" onclick="document.getElementById('followdeleteForm').submit();">
			</form>
			<%}else{ %>
			<form method="post" id="followForm">
				<input type="hidden" name="followAction" value="follow">
				<input type="hidden" name="set_user_id" value="<%=mybean.getUser_id()%>">
				<input type="hidden" name="get_user_id" value="<%=ubean.getUser_id()%>">
				<input type="hidden" name="redirectTab" value="followers-content">
				<input type="button" class="follow-button" onclick="document.getElementById('followForm').submit();">
			</form>
			<%} %>
			<%
			}
			%>
		</div>
	</div>

	<!-- 프로필 카테고리 시작 -->
	<div>
    <label class="profile-label active" onclick="highlight(this, 'profile-content')">프로필</label>
    <label class="profile-label" onclick="highlight(this, 'review-content')">프로젝트 후기</label>
    <label class="profile-label" onclick="highlight(this, 'project-content')">올린 프로젝트</label>
    <label class="profile-label" onclick="highlight(this, 'followers-content')">팔로워</label>
    <label class="profile-label" onclick="highlight(this, 'following-content')">팔로잉</label>
    <hr id="highlight-hr" width="100%" noshade />
</div>

	<!-- 각 프로필 카테고리 마다 사용될 body. -->
	<div id="content">

		<div id="profile-content" class="tab-content"><%=ubean.getUser_info()%></div>
		<div id="review-content" class="tab-content" style="display: none;">프로젝트 후기 내용</div>
		<div id="project-content" class="tab-content" style="display: none;">
			<div style="margin-left: 20px; margin-top: 20px;"><%=fdCount %>개의 프로젝트가 있습니다.</div>
			<%if(fdCount!=0){ %>

			
			    <div id="projects">
			    <% for (int i = 0; i < fdCount; i++) { %>
			        <div id="upload-project">
			            <!-- 프로젝트 사진 -->
			            <a href="../fundingcheck/fundingcheck.jsp?fundingNum=<%=fdvlist.get(i).getFunding_num()%>">
			            <img src='<%= fdvlist.get(i).getFunding_image() %>'> 
			            </a>
			            <!-- 창작자 명 -->
			            <a class="creator-name" href="profile.jsp?userId=<%=fdvlist.get(i).getFunding_user_id() %>">
			                <%= uMgr.oneUserList(fdvlist.get(i).getFunding_user_id()).getUser_name() %>
			            </a><br>
			            <!-- 제품명 -->
			            <label class="product-name">
			                <%= fdvlist.get(i).getFunding_title() %>
			            </label><br>
			            <!-- 진행 정보 -->
			            <div class="progress-info">
			                <span class="progress-percentage">
			                    <%= (int)(((double)fdvlist.get(i).getFunding_nprice() / fdvlist.get(i).getFunding_tprice()) * 100) %> %
			                </span> 
			                <span class="progress-amount">
			                    <%= fdvlist.get(i).getFunding_nprice() %>원
			                </span> 
			                <span class="progress-time">
			                <%if(fdMgr.fundDate(fdvlist.get(i).getFunding_num())>=0){ %>
			                    <%= fdMgr.fundDate(fdvlist.get(i).getFunding_num()) %>일 남음
			                <%}else{ %>
			                	종료
			                <%} %>
			                </span>
			            </div>
			            <!-- 진행 바 -->
			            <progress id="progress" value="<%= (int)(((double)fdvlist.get(i).getFunding_nprice() / fdvlist.get(i).getFunding_tprice()) * 100) %>" min="0" max="100"></progress>
			        </div>
			        <% } %>
			    </div>

		<%} %>
		</div>


		<div id="followers-content" class="tab-content" style="display: none;">
			<div id="content-box">

				<% if(fgvlist != null && follower != 0) { %>
				    <% for(int i = 0; i < follower; i++) { 
				        usersBean user = uMgr.oneUserList(fgvlist.get(i).getFollow_set_user_id());
				        if(user != null) { %>
				            <div id="follower-box"> <!-- id 대신 class 사용 -->
				            <div id="follower-infos">
				                <img src='<%=user.getUser_image()%>' alt="Follower Image">
				                <div class="follower-info">
				                    <a href="profile.jsp?userId=<%=user.getUser_id() %>"><%=user.getUser_name() %></a> <label>팔로잉 <%=fMgr.getFollowingCount(user.getUser_id()) %>
				                     · 후원한 프로젝트 <%=brMgr.buyRecordCount(user.getUser_id()) %></label>
				                </div>
				                </div>
				               <%if(mybean.getUser_id().equals(user.getUser_id())){ %>
				               
				                	
                        		<%}else if(fMgr.followCheck(mybean.getUser_id(), user.getUser_id())){ %>
                        		<div>
								<form method="post" id="followerdeleteForm">
								    <input type="hidden" name="followAction" value="follower2-delete">
								    <input type="hidden" name="set_user_id" value="<%=mybean.getUser_id()%>">
								    <input type="hidden" name="get_user_id" value="<%=user.getUser_id()%>">
								     <input type="hidden" name="redirectTab" value="followers-content">
								    <input type="button" id="follower-deletebutton2" onclick="document.getElementById('followerdeleteForm').submit();">
								</form>
                        		</div>
				                <% } else { %>
				                <div>
								<form method="post" id="followerForm">
								    <input type="hidden" name="followAction" value="follower2">
								    <input type="hidden" name="set_user_id" value="<%=mybean.getUser_id()%>">
								    <input type="hidden" name="get_user_id" value="<%=user.getUser_id()%>">
								     <input type="hidden" name="redirectTab" value="followers-content">
								    <input type="button" id="follower-button2" onclick="document.getElementById('followerForm').submit();">
								</form>
                        		</div>
                        		<%} %>
				            </div>
				        <% } else { %>
				            <!-- 유저 정보가 없을 경우 처리 -->
				            <div>유저 정보를 찾을 수 없습니다.</div>
				        <% } %>
				    <% } %>
				<% } else { %>
				    팔로워가 없습니다.
				<% } %>
				
			</div>
		</div>
			
			
			
		<div id="following-content" class="tab-content" style="display: none;">
			<div id="content-box">
				<% if(fsvlist != null && following != 0) { %>
				    <% for(int i = 0; i < following; i++) { 
				        usersBean user = uMgr.oneUserList(fsvlist.get(i).getFollow_get_user_id());
				        if(user != null) { %>
				            <div id="follower-box"> <!-- id 대신 class 사용 -->
				            <div id="follower-infos">
				                <img src='<%=user.getUser_image()%>' alt="Follower Image">
				                <div class="follower-info">
				                     <a href="profile.jsp?userId=<%=user.getUser_id() %>"><%=user.getUser_name() %></a> <label>팔로잉 <%=fMgr.getFollowingCount(user.getUser_id()) %> · 후원한 프로젝트 <%=brMgr.buyRecordCount(user.getUser_id()) %></label>
				                </div>
				                </div>
				               <%if(mybean.getUser_id().equals(user.getUser_id())){ %>
				              
				                	
                        		<%}else if(fMgr.followCheck(mybean.getUser_id(), user.getUser_id())){ %>
                        		<div>
								<form method="post" id="followingdeleteForm">
								    <input type="hidden" name="followAction" value="following2-delete">
								    <input type="hidden" name="set_user_id" value="<%=mybean.getUser_id()%>">
								    <input type="hidden" name="get_user_id" value="<%=user.getUser_id()%>">
								     <input type="hidden" name="redirectTab" value="following-content"> 
								    <input type="button" id="follower-deletebutton2" onclick="document.getElementById('followingdeleteForm').submit();">
								</form>
                        		</div>
				                <% } else { %>
				                <div>
								<form method="post" id="followingForm">
								    <input type="hidden" name="followAction" value="following2">
								    <input type="hidden" name="set_user_id" value="<%=mybean.getUser_id()%>">
								    <input type="hidden" name="get_user_id" value="<%=user.getUser_id()%>">
								     <input type="hidden" name="redirectTab" value="following-content"> 
								    <input type="button" id="follower-button2" onclick="document.getElementById('followingForm').submit();">
								</form>
                        		</div>
                        		<%} %>
				            </div>
				        <% } else { %>
				            <!-- 유저 정보가 없을 경우 처리 -->
				            <div>유저 정보를 찾을 수 없습니다.</div>
				        <% } %>
				    <% } %>
				<% } else { %>
				    팔로잉이 없습니다.
				<% } %>
				
			</div>
		</div>

		

	</div>

	<script src="dropdown.js"></script>
	<script src="detailInfo.js"></script>
</body>
</html>

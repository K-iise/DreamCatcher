<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="control.*" %>
<%@ page import="entity.*" %>

<%@ page import="control.usersMgr"%>
<%@ page import="entity.usersBean"%>
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
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 편집 화면</title>
<style>
</style>
<link href="profileEdit.css" rel="stylesheet">
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

	<!-- 프로필 편집 -->
	<div class="profile-edit">
		<h1>설정</h1>
	</div>

	<!-- 프로필 카테고리 시작 -->
	<div style="margin-bottom: 30px;">
    <label class="profile-label active" onclick="highlight(this, 'profile-content')">프로필</label>
    <label class="profile-label" onclick="highlight(this, 'review-content')">알림</label>
    <hr id="highlight-hr" width="100%" noshade />
	</div>

	<!-- 각 프로필 카테고리 마다 사용될 body. -->
	<div id="content">

		<div id="profile-content" class="tab-content">
			
			<div class="Edit-Main">
				
				<!-- 프로필 편집 왼쪽 부분. -->
				<div class="left-section">
				
					<!-- 프로필 사진 편집. -->
					<div class="edit-box">
						<div class="edit-title">
							<b>프로필 사진</b>
							<button class="change-button">변경</button>
						</div>
						<button class="save-button">저장</button>
					</div>
					
					<!-- 사용자 이름 편집. -->
					<div class="edit-box">
						<div class="edit-title">
							<b>사용자 이름</b>
							<button class="change-button">변경</button>
						</div>
						<p class="user-name" style="margin: 0px;"></p>
						<input class="input_text"type="text" inputmode="text" placeholder="이름을 입력해주세요." 
						value="김윤기">
						<button class="save-button">저장</button>
					</div>
					
					<!-- 소개 편집 -->
					<div class="edit-box">
						<div class="edit-title">
							<b>소개</b>
							<button class="change-button">변경</button>
						</div>
						<p class="user-name" style="margin: 0px; color: rgb(158, 158, 158);">등록된 소개가 없습니다.</p>
						<textarea placeholder="자기소개를 입력해주세요." class="input_textarea"></textarea>
						<button class="save-button">저장</button>
					</div>
					
					<!-- 주소 편집 -->
					<div class="edit-box">
						<div class="edit-title">
							<b>등록된 주소</b>
							<button class="change-button">변경</button>
						</div>
						<p class="user-name" style="margin: 0px; color: rgb(158, 158, 158);">등록된 소개가 없습니다.</p>
						<textarea placeholder="자기소개를 입력해주세요." class="input_textarea"></textarea>
						<button class="save-button">저장</button>
					</div>
					
				</div>
				
				<!-- 프로필 편집 오른쪽 부분. -->
				<div class="right-section">
				
				</div>
			</div>
		
		</div>
		<div id="review-content" class="tab-content" style="display: none;">프로젝트 후기 내용</div>
		
	</div>
	<script src="profileEdit.js"></script>
</body>
</html>

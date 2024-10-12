<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Vector" %>
<%@page import="entity.*" %>
<%@page import="control.*" %>

<%
	alarmMgr amgr = new alarmMgr();
	usersMgr mgr = new usersMgr();
	createFundingMgr cfMgr=new createFundingMgr();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알람 화면</title>
<link href="alarm.css" rel="stylesheet" />
<script>
		// 카테고리 색상 변경.
        function highlight(selectedLabel, contentId) {
            // 모든 프로필 라벨 색상 초기화
            const labels = document.querySelectorAll('.alarm-label');
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
		
     	// 모달 열기
        function confirmDelete() {
            document.getElementById('deleteModal').style.display = 'block'; 
        }
     	// 모달 닫기
        function closeModal() {
            document.getElementById('deleteModal').style.display = 'none'; 
        }

        function deleteAlarm() {
            // 삭제 로직 추가 (예: DOM에서 요소 제거)
            alert("알림이 삭제되었습니다."); // 삭제 후 알림
            closeModal(); // 모달 닫기
        }
</script>
</head>
<body>
<%
    // 로그인한 사용자 ID를 세션에서 가져옴
    String user_id = (String) session.getAttribute("idKey");
    // amgr 객체를 통해 알람 리스트를 가져옴
    Vector<alarmBean> alarmList = amgr.alarmList(user_id);
    // 유저 이름을 위한 유저리스트 가져오기
	usersBean mybean = new usersBean();
	mybean=mgr.oneUserList(user_id);
    
    if (alarmList != null) {
        for (int i = 0; i < alarmList.size(); i++) {
            int alarmNum = alarmList.get(i).getAlarm_num(); // 알람 번호 가져오기
            amgr.alarmCheck(alarmNum); // alarmCheck 메서드 호출
        }
    }
    
    
    System.out.println("알람 개수: " + alarmList.size());
%>
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

	<!-- 관심 프로젝트 -->
	<div class="alarm">
		<h1>알림</h1>
	</div>

	<!-- 관심 카테고리 시작 -->
	<div>
    	<label class="alarm-label active" onclick="highlight(this, 'alarm-content')">전체</label> 
    	<label class="alarm-label" onclick="highlight(this, 'activity-content')">활동</label>
    	<label class="alarm-label" onclick="highlight(this, 'project-content')">프로젝트</label>
    	<hr id="highlight-hr" width="100%" noshade />
	</div>


	<!-- 각 관심 카테고리 마다 사용될 body. -->
	<div id="content">
	    <!-- 전체 알림 내용 -->
	    <div id="alarm-content" class="tab-content">
	        <% if (alarmList != null && !alarmList.isEmpty()) { %>
			    <% for(int i = 0; i < alarmList.size(); i++) { %>
			        <div id="alarmSample_<%= i %>" class="alarm-sample">
			            <img src="<%= alarmList.get(i).getAlarm_image() %>" class="alarm-image">    
			            <div class="alarm-text">
			                <label class="alarmname"><%= alarmList.get(i).getAlarm_con() %></label>
			            </div>
			        </div>
			    <% } %>
			<% } else { %>
			    <p>알림이 없습니다.</p>
			<% } %>
	    </div>
	
	    <!-- 활동 내용 -->
	    <div id="activity-content" class="tab-content" style="display: none;">
	        <p>여기에 활동 내역이 표시됩니다.</p>
	    </div>
	
	    <!-- 프로젝트 내용 -->
	    <div id="project-content" class="tab-content" style="display: none;">
	        <p>여기에 프로젝트 내용이 표시됩니다.</p>
	    </div>
	</div>	
	<script src="dropdown.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Vector" %>
<%@page import="entity.alarmBean" %>
<%@page import="control.alarmMgr" %>
<%@page import="entity.usersBean" %>
<%@page import="control.usersMgr" %>
<%
	alarmMgr amgr = new alarmMgr();
	usersMgr mgr = new usersMgr();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알람 화면</title>
<style>
/* 전체 화면 비율 맞추기 */
body {
	margin: 0; /* 기본 여백 제거 */
	padding: 0 15%; /* 왼쪽과 오른쪽에 15%의 여백 추가 */
}

/* 카테고리 스타일*/
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

.alarm-label {
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

.alarm {
	display: flex; /* Flexbox 사용 */
	margin-bottom: 20px;
	margin-top: 20px;
	align-items: center; /* 추가 */
}

/* 검색 바 css */
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

/* 상단바 1 css */
.title-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	
}


/* 상단바 아이콘 */
.title-header .upload-button {
	background: url("image/uploadproject.png") no-repeat;
	width: 140px;
	height: 40px;
	border: 0px;
	margin-right: 10px;
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

.title-header span{
	width: 40px;
	height: 40px;
	padding: 15px;
	border: 1px solid black; /* 테두리 두께, 스타일, 색상 모두 명시 */
	margin-left: 20px;
}

.title-header span img {
	width: 35px; /* 원하는 너비 설정 */
	height: 35px; /* 원하는 높이 설정 */
	vertical-align: top;
	margin-right: 5px;
}


/* 알람 정보 */
.alarm-sample {
	display: flex; /* Flexbox 사용 */
	align-items: center; /* 위쪽 정렬 */
	width: auto;
	height: auto; /* 높이를 자동으로 조정 */
	padding: 5px; /* 여백 추가 */
	border: 1px solid #dee2e6; /* 경계선 추가 */
	background-color: #f8f9fa; /* 배경색 설정 */
	margin-bottom: 10px; /* 아래쪽 여백 */
	
}

.alarm-sample:hover{
	background-color: #f0fbff;
}

/* 알람 사진 */
.alarm-image {
	width: 60px; /* 원하는 너비 설정 */
	height: 60px; /* 원하는 높이 설정 */
	margin-right: 20px; /* 이미지와 텍스트 사이의 간격 */
}

/* 알람 전체 텍스트 */
.alarm-text {
	display: flex;
	flex-direction: column; /* 제목과 내용을 세로로 나열 */
}

/* 알람 이름 */
.alarmname {
	font-size: 20px; /* 제품명 크기 */
	color: #000000; /* 색상 */
}



.delete-button:hover {
	background-color: #c82333; /* 호버 시 색상 변경 */
}


.modal-content {
    background-color: #fefefe;
    margin: 15% auto; /* Centralized */
    padding: 30px; /* Extra padding for better look */
    border: 1px solid #888;
    width: 25%; /* Adjust width */
    text-align: center;
    box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3); /* Add shadow for depth */
    border-radius: 10px; /* Round the edges */
}

/* Button style for confirm and cancel */
.modal-content button {
    width: 100px; /* Adjust width */
    padding: 10px;
    margin: 10px; /* Add margin between buttons */
    border: none;
    border-radius: 5px;
    font-size: 16px; /* Adjust font size */
}

.modal-content button:first-of-type {
    background-color: #dc3545; /* Red color for confirm */
    color: white;
}

.modal-content button:first-of-type:hover {
    background-color: #c82333; /* Darker red on hover */
}

.modal-content button:last-of-type {
    background-color: #6c757d; /* Gray color for cancel */
    color: white;
}

.modal-content button:last-of-type:hover {
    background-color: #5a6268; /* Darker gray on hover */
}

</style>

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
    Vector<usersBean> userList = mgr.userList();
    // 유저 이름 찾기
    String userName = "";
    for (usersBean user : userList) {
        if (user.getUser_id().equals(user_id)) {
            userName = user.getUser_name();
            break; // 사용자를 찾으면 루프 종료
        }
    }
    
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
			<input type="button" class="upload-button" onclick=""> 
			<input type="button" class="heart-button" onclick="location.href='../interestProject/interestProject.jsp'">
			<input type="button" class="bell-button" onclick="">
			<span onclick="">
				<img src="image/guest.png">
				<b><%=userName%></b>
			</span>
		</div>
	</header>

	<!-- 카테고리 시작 -->
	<header>
		<label class="category-label"><img src="image/menubar.png">카테고리</label>
		<label class="category-label">홈</label> <label class="category-label">인기</label>
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
	
</body>
</html>
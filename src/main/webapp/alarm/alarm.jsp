<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	align-items: flex-start; /* 위쪽 정렬 */
	width: auto;
	height: auto; /* 높이를 자동으로 조정 */
	padding: 15px; /* 여백 추가 */
	border: 1px solid #dee2e6; /* 경계선 추가 */
	background-color: #f8f9fa; /* 배경색 설정 */
	margin-bottom: 10px; /* 아래쪽 여백 */
}

.alarm-sample:hover{
	background-color: #f0fbff;
}

/* 알람 사진 */
.alarm-image {
	width: 120px; /* 원하는 너비 설정 */
	height: 120px; /* 원하는 높이 설정 */
	margin-right: 20px; /* 이미지와 텍스트 사이의 간격 */
}

/* 알람 전체 텍스트 */
.alarm-text {
	display: flex;
	flex-direction: column; /* 제목과 내용을 세로로 나열 */
}

/* 알람 이름 */
.alarmname {
	font-size: 19px; /* 제품명 크기 */
	color: #000000; /* 색상 */
	margin-bottom: 0px; /* 제목과 내용 사이의 간격 */
}

/* 알람 내용 */
.description {
	font-size: 16px; /* 설명 크기 */
	color: #6c757d; /* 색상 변경 (회색) */
	line-height: 1.5; /* 줄 높이 설정 */
	width: 1057px;
	overflow: hidden; /* 내용 넘침 방지 */
	text-overflow: ellipsis; /* 넘치는 텍스트는 ...로 표시 */
	display: -webkit-box; /* 웹킷 박스 모델 사용 */
	-webkit-line-clamp: 3; /* 최대 3줄로 제한 */
	-webkit-box-orient: vertical; /* 세로 방향으로 설정 */
}

/* 알람 날짜*/
.alarm-text small {
	font-size: 15px;
}

/* 삭제 링크 */
.delete-button {
	padding: 5px 10px; /* 링크 패딩 */
	background-color: #dc3545; /* 빨간색 배경 */
	color: white; /* 흰색 텍스트 */
	text-decoration: none; /* 기본 밑줄 제거 */
	border-radius: 5px; /* 둥근 모서리 */
	margin-left: 60px;
}

.delete-button:hover {
	background-color: #c82333; /* 호버 시 색상 변경 */
}


/* 삭제 확인 모달 */
.modal {
    display: none; /* Hide by default */
    position: fixed; /* Fixed in place */
    z-index: 1; /* On top of everything */
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* Darken the background */
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
	<!-- 상단바 1 -->
	<header class="title-header">
		<h1>Dream Catcher</h1>
		<div>
			<input type="button" class="upload-button" onclick=""> 
			<input type="button" class="heart-button" onclick="">
			<input type="button" class="bell-button" onclick="">
			<span onclick="">
				<img src="image/guest.png">
				<b>사용자 이름</b>
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
		<label class="alarm-label active"
			onclick="highlight(this, 'entire-content')">전체</label> <label
			class="alarm-label" onclick="highlight(this, 'activity-content')">활동</label>
		<label class="alarm-label"
			onclick="highlight(this, 'project-content')">프로젝트</label>
		<hr id="highlight-hr" width="100%" noshade />
	</div>


	<!-- 각 관심 카테고리 마다 사용될 body. -->
	<div id="content">
		
		<div id="entire-content" class="tab-content">
			<!-- 알림 정보 Sample -->
			<div id="alarm-content">
				<div id="alarmSample" class="alarm-sample">
					<img src="image/interest-project1.jpg" class="alarm-image">
					<div class="alarm-text">
						<label class="alarmname">좋아하신 <b>북다마스북커버</b> 프로젝트에 창작자의 새
							게시글이 올라왔습니다.
						</label>
						<p class="description">안녕하세요. 데이즈엔터(주) 롤앤토크 텀블벅 담당자입니다. 마지막 날,
							이것만큼은 꼭 확인 부탁드립니다! 현재 구성을 확인한 결과, 낱권으로 2권 혹은 3권 분량의 후원을 하실 때 구성별로
							따로 후원하신 분들이 확인되어 일단 확인된 분들에 한해 별도 메시지를 발송드렸습니다. 사정상 반드시 개별발송을
							원하시는 분이 아니라면, 배송비가 추가 중복 결제가 되니 여러권의..
							</p>
						<small >5 일전</small>
					</div>
					<a href="#" class="delete-button" onclick="confirmDelete()">삭제</a>
				</div>

			</div>
		</div>
		<div id="activity-content" class="tab-content" style="display: none;">
			활동내용</div>

		<div id="project-content" class="tab-content" style="display: none;">
			프로젝트 내용</div>
	</div>
	
	<!-- 삭제 확인 모달 -->
	<div id="deleteModal" class="modal">
		<div class="modal-content">
			<p style="font-size: 18px; font-weight: bold">알림을 삭제하시면 알림 페이지에서 확인하실 수 없습니다. <br>삭제하시겠습니까?</p>
			<button onclick="deleteAlarm()">확인</button>
			<button onclick="closeModal()">취소</button>
		</div>
	</div>


</body>
</html>

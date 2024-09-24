<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 화면</title>
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

.profile-label {
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

.profile {
	display: flex; /* Flexbox 사용 */
	margin-bottom: 20px;
	margin-top: 20px;
}

.profile img {
	width: 180px; /* 원하는 너비로 설정 */
	height: auto; /* 비율 유지 */
	border-radius: 50%; /* 둥글게 만들기 (선택사항) */
}

.profile-info {
	margin-top:25px;
	margin-left: 50px; /* 이미지와의 간격 */
	color: #333; /* 텍스트 색상 */
}

.profile b {
	font-size: 20px;
}

.profile-detail {
	display: flex; /* Flexbox 사용 */
	justify-content: space-between; /* 간격 균등 배치 */
	margin-top: 20px; /* 상단 여백 추가 */
	color: #555; /* 텍스트 색상 */
}

.profile-detail div {
	text-align: center; /* 중앙 정렬 */
	margin-right: 60px;
	font-size: 20px;
}
</style>

<script>
        function highlight(selectedLabel) {
            // 모든 프로필 라벨 색상 초기화
            const labels = document.querySelectorAll('.profile-label');
            labels.forEach(label => {
                label.classList.remove('active');
            });

            // 선택된 라벨 색상 변경
            selectedLabel.classList.add('active');

        }
    </script>
</head>
<body>
	<!-- 상단바 1 -->
	<header>
		<h1>Dream Catcher</h1>
	</header>

	<!-- 카테고리 시작 -->
	<header>
		<label class="category-label"><img src="menubar.png">카테고리</label>
		<label class="category-label">홈</label> <label class="category-label">인기</label>
		<label class="category-label">신규</label> <label class="category-label">스토어</label>
	</header>
	<!-- 카테고리 끝 -->
	<hr id="default-hr" width="100%" noshade />

	<!-- 프로필 정보 -->
	<div class="profile">
		<img src="test.jpg" alt="Profile Image">
		<div class="profile-info">
			<b>홍길동(프로필 이름)</b> <br>가입 날짜(5년전)
			<div class="profile-detail">
				<div>
					<b>팔로워</b><br> 100
				</div>
				<div>
					<b>팔로잉</b><br> 50
				</div>
				<div>
					<b>누적 후원자</b><br> 20
				</div>
			</div>
		</div>
	</div>

	<!-- 프로필 카테고리 시작 -->
	<div>
		<label class="profile-label active" onclick="highlight(this)">프로필</label>
		<label class="profile-label" onclick="highlight(this)">프로젝트 후기</label>
		<label class="profile-label" onclick="highlight(this)">올린 프로젝트</label>
		<label class="profile-label" onclick="highlight(this)">팔로워</label> <label
			class="profile-label" onclick="highlight(this)">팔로잉</label>
		<hr id="highlight-hr" width="100%" noshade />
	</div>

</body>
</html>

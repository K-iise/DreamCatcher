<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.usersMgr"%>
<%@ page import="entity.usersBean"%>
<%@ page import="control.followMgr"%>
<%@ page import="entity.followBean"%>
<%
usersBean ubean = new usersBean();
usersBean mybean = new usersBean();
usersMgr uMgr = new usersMgr();
followBean fbean = new followBean();
followMgr fMgr = new followMgr();

ubean.setUser_address("aaa");
ubean.setUser_id("aaaa");
ubean.setUser_info("안뇽하세요");
ubean.setUser_master(0);
ubean.setUser_name("aaa");
ubean.setUser_phone("111-1111-1111");
ubean.setUser_pw("1234");
ubean.setUser_resnum("111111-1111111");

mybean.setUser_address("aaa");
mybean.setUser_id("aaa");
mybean.setUser_info("안뇽하세요");
mybean.setUser_master(0);
mybean.setUser_name("닉네이미이이이이이이이이이ㅣ이이이잉ㅁ");
mybean.setUser_phone("111-1111-1111");
mybean.setUser_pw("1234");
mybean.setUser_resnum("111111-1111111");

int follower = fMgr.getFollowerCount(ubean.getUser_id());
int following = fMgr.getFollowingCount(ubean.getUser_id());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈 화면</title>
<style>
body {
	margin: 0; /* 기본 여백 제거 */
	padding: 0 15%; /* 왼쪽과 오른쪽에 15%의 여백 추가 */
}

/* 카테고리 css */
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

.active {
	color: black; /* 활성화된 텍스트 색상 */
}

hr {
	border: none; /* 기본 경계 제거 */
	height: 1px; /* 높이 설정 */
	background-color: #dee2e6; /* 기본 색상 */
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

.title-header div {
	display: flex;
	align-items: center; /* 내부 요소 수직 가운데 정렬 */
}

/* 상단바 아이콘 */
.title-header .upload-button {
	background: url("image/uploadproject.png") no-repeat;
	width: 140px;
	height: 40px;
	border: 0px;
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

.MainTop {
	display: flex;
	justify-content: space-between; /* 양쪽에 균등하게 배치 */
	align-items: flex-start; /* 상단에 맞춰 정렬 */
	margin-bottom: 20px; /* 아래 콘텐츠와의 간격 */
}

.left-section {
	flex: 4; /* 왼쪽 영역이 3배 공간 차지 */
	display: flex;
	flex-direction: column; /* 배너와 추가 콘텐츠를 세로로 정렬 */
}

.right-section {
	flex: 2; /* 오른쪽 영역이 1배 공간 차지 */
	background-color: #f9f9f9; /* 배경색 */
	margin-left: 20px;
	border-radius: 5px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

/* 슬라이더 컨테이너 */
.banner {
	position: relative;
	height: 300px;
	margin-bottom: 20px;
	overflow: hidden;
}


/* 슬라이더 이미지들을 가로로 나열 */
.slides {
    display: flex;
    transition: transform 0.5s ease-in-out;
    width: 100%; /* 전체 너비 */
}

/* 각 슬라이드의 너비 */
.slide {
    flex: 0 0 100%; /* 각 슬라이드가 전체 너비를 차지 */
    height: 100%;
    object-fit: fill;
}

.slide img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

/* 좌우 버튼 스타일 */
.prev, .next {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: rgba(0, 0, 0, 0.5);
	color: white;
	border: none;
	padding: 10px;
	cursor: pointer;
	z-index: 1;
}

.prev {
	left: 0;
}

.next {
	right: 0;
}

/* 추가 콘텐츠 스타일 */
.additional-content {
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 5px;
}

/* 오른쪽 인기 프로젝트 랭킹 스타일 */
.right-section h2 {
	font-size: 24px;
	margin-bottom: 10px;
}

.right-section ul {
	list-style: none;
	padding: 0;
}

.right-section li {
	margin-bottom: 10px;
	font-size: 18px;
}
</style>

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
        
        let currentIndex = 0;

        function showSlide(index) {
            const slides = document.querySelector('.slides');
            const totalSlides = document.querySelectorAll('.slide').length;

            // 인덱스 범위 조정
            currentIndex = (index + totalSlides) % totalSlides;

            // 슬라이드 이동
            slides.style.transform = `translateX(${-currentIndex * 100}%)`;
        }

        function nextSlide() {
            showSlide(currentIndex + 1);
        }

        function prevSlide() {
            showSlide(currentIndex - 1);
        }

        // 자동 슬라이드 기능 (3초마다 자동으로 다음 슬라이드로 이동)
        setInterval(nextSlide, 3000);

        // 페이지 로드 시 첫 슬라이드 표시
        window.onload = () => {
            showSlide(currentIndex);
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
			<input type="button" class="upload-button" onclick=""> <input
				type="button" class="login-button" onclick="">
			<%
			} else {
			%>

			<input type="button" class="upload-button" onclick=""> <input
				type="button" class="heart-button" onclick=""> <input
				type="button" class="bell-button" onclick=""> <span
				onclick=""> <img src="image/guest.png"> <b><%=mybean.getUser_name()%></b>
			</span>
		</div>

		<%
		}
		%>
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

	<!--  Main 화면 위쪽 영역 -->
	<div class="MainTop">
		<!-- 왼쪽 영역 -->
		<div class="left-section">
			<!-- 배너 영역 -->
			<div class="banner">
				<div class="slides">
					<div class="slide">
						<img src="image/banner_image1.png" alt="배너 이미지 1">
					</div>
					<div class="slide">
						<img src="image/banner_image2.png" alt="배너 이미지 2">
					</div>
					<div class="slide">
						<img src="image/banner_image3.png" alt="배너 이미지 3">
					</div>
				</div>
				<button class="prev" onclick="prevSlide()">&#10094;</button>
				<button class="next" onclick="nextSlide()">&#10095;</button>
			</div>

			<!-- 배너 아래 추가 콘텐츠 -->
			<div class="additional-content">
				<h2>주목할 만한 프로젝트</h2>
				<p>여기에 다른 내용을 추가할 수 있습니다.</p>
			</div>
		</div>

		<!-- 오른쪽 영역 -->
		<div class="right-section">
			<h2>인기 프로젝트</h2>
			<ul>
				<li>1등: <span>어디서든 누를 수 있는 키보드 키링 (5434% 달성)</span></li>
				<li>2등: <span>소년 소녀 빈티지 스쿨 3D 컬렉션 (434% 달성)</span></li>
				<li>3등: <span>티키틱 마지막 이야기 (2145% 달성)</span></li>
				<!-- 나머지 랭킹 추가 -->
			</ul>
		</div>
	</div>
	<!-- 배너 -->



</body>
</html>

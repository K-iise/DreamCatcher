<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String username = "TEST123";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<style type="text/css">
body {
	text-align: center; /* 중앙 정렬 추가 */
	display: flex; /* 플렉스 박스 사용 */
	flex-direction: column; /* 세로 방향으로 정렬 */
	justify-content: center; /* 세로 방향 중앙 정렬 */
}

header {
	font-size: 28px;
}

input {
	width: 100%; /* 부모 요소의 50% */
	padding: 20px; /* 안쪽 여백 */
	border: 1px solid #ccc; /* 테두리 */
	border-radius: 5px; /* 모서리를 둥글게 */
	box-sizing: border-box; /* 패딩과 테두리가 포함된 크기 계산 */
	font-size: 22px; /* 글자 크기 */
	transition: border-color 0.3s; /* 테두리 색상 변화 애니메이션 */
	margin: 10px auto; /* 위 아래 여백 및 가로 중앙 정렬 */
}

input:focus {
	border-color: #007BFF; /* 포커스 시 테두리 색상 변경 */
	outline: none; /* 기본 아웃라인 제거 */
}

input::placeholder {
	color: #aaa; /* 플레이스홀더 색상 */
	font-style: italic; /* 이탤릭체 */
}

.button {
	width: 100%; /* 부모 요소의 50% */
	padding: 15px; /* 안쪽 여백 */
	border: none; /* 테두리 없음 */
	border-radius: 5px; /* 모서리를 둥글게 */
	background-color: #FE4848; /* 배경색 */
	color: white; /* 글자 색상 */
	font-size: 30px; /* 글자 크기 */
	cursor: pointer; /* 커서 모양 변경 */
	transition: background-color 0.3s; /* 배경색 변화 애니메이션 */
	margin: 10px auto; /* 위 아래 여백 및 가로 중앙 정렬 */
}

.button:hover {
	background-color: rgba(0, 0, 0, 0.5); /* 마우스 오버 시 색상 변화 */
}

.link {
	margin-top: 10px;
	font-size: 20px;
	color: rgba(0, 0, 0, 0.5); /* 링크 색상 */
	text-decoration: none; /* 밑줄 제거 */
}

.link:hover {
	text-decoration: underline; /* 마우스 오버 시 밑줄 추가 */
}

.separator {
	color: rgba(0, 0, 0, 0.5); /* | 기호 색상 설정 */
	font-size: 16px; /* 기호의 폰트 크기 설정 */
	margin: 0 5px; /* 기호 주변 여백 설정 */
}

.findbox {
	border: 1px solid #ccc; /* 테두리 색상 및 두께 */
	width: 50%; /* 부모 요소의 70% */
	border-radius: 5px; /* 모서리를 둥글게 */
	padding: 20px; /* 안쪽 여백 추가 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 효과 (선택사항) */
	margin: 10px auto; /* 위 아래 여백 및 가로 중앙 정렬 */
}

label {
	font-size: 28px; /* 텍스트 크기 조정 */
	margin: 5px 0 5px; /* 위 아래 여백 조정 */
	display: block; /* 블록 요소로 변경하여 새 줄에서 시작 */
}
</style>
</head>
<body>
	<header>
		<h1>비밀번호 재설정</h1>
	</header>
	
	<label>아이디 <span style="color: blue;"><%=username %></span> 님 새 비밀번호를 등록해주세요.</label>

	<div class="findbox">
		<div style="text-align: left; width: 100%;">

			<label for="password">새 비밀번호</label> 
			<input type="text" id="password" placeholder="새 비밀번호를 입력해주세요"><br> 
			
			<label for="national_id_number">비밀번호 확인</label> 
			<input type="password" id="chkpassword" placeholder="비밀번호를 다시 입력해주세요."><br> 
			<input type="button" class="button" value="변경하기" onclick="location.href='/DreamCatcher/login/login.html'">
		</div>
	</div>

	<hr width="50%" color="#dee2e6" noshade/>

	<div>
		<a href="/DreamCatcher/login/login.html" class="link">로그인</a> <span
			class="separator">|</span> <a href="/DreamCatcher/signup/signup.html"
			class="link">회원가입</a>
	</div>

</body>
</html>
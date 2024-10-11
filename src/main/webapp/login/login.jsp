<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="login" class="entity.usersBean" scope="session"/>
<%
	String id = (String)session.getAttribute("idKey");
    String url = request.getParameter("url");
%>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>로그인 화면</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow-x: auto; /* 가로 스크롤바가 필요할 때 생기도록 설정 */
            overflow-y: auto; /* 세로 스크롤바는 제거 */
            box-sizing: border-box;
        }

        body {
            min-width: 1200px; /* 화면이 1200px 이하로 줄어들면 가로 스크롤바가 생김 */
        }

        div {
            width: 100%;
        }

        div.left {
            width: 60%;
            height: 100vh; /* 전체 높이를 사용 */
            float: left;
            box-sizing: border-box;
            text-align: center; /* 중앙 정렬 추가 */
            display: flex; /* 플렉스 박스 사용 */
            flex-direction: column; /* 세로 방향으로 정렬 */
            justify-content: center; /* 세로 방향 중앙 정렬 */
        }

        div.right {
            width: 40%;
            height: 100vh; /* 전체 높이를 사용 */
            float: right;
            box-sizing: border-box;
        }

        div.right img {
            height: 100%; /* 전체 높이를 사용 */
            width: 100%; /* 전체 폭을 사용 */
            object-fit: cover; /* 비율을 유지하며 채우기 */
        }

        header {
            font-size: 28px;
        }

        input {
            width: 50%; /* 부모 요소의 50% */
            padding: 20px; /* 안쪽 여백 */
            border: 1px solid #ccc; /* 테두리 */
            border-radius: 5px; /* 모서리를 둥글게 */
            box-sizing: border-box; /* 패딩과 테두리가 포함된 크기 계산 */
            font-size: 22px; /* 글자 크기 */
            margin: 10px auto; /* 위 아래 여백 및 가로 중앙 정렬 */
        }

        .button {
            width: 50%; /* 부모 요소의 50% */
            padding: 15px; /* 안쪽 여백 */
            border: none; /* 테두리 없음 */
            border-radius: 5px; /* 모서리를 둥글게 */
            background-color: #FE4848; /* 배경색 */
            color: white; /* 글자 색상 */
            font-size: 22px; /* 글자 크기 */
            cursor: pointer; /* 커서 모양 변경 */
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

        /* 화면 크기 줄일 때 고정된 너비를 유지하고 스크롤바가 나타나게 설정 */
        @media (max-width: 1200px) {
            body {
                min-width: 1200px; /* 1200px 이하로 줄어들면 스크롤바가 생기도록 고정 */
                overflow-x: scroll; /* 가로 스크롤바 활성화 */
            }
        }
    </style>
</head>
<body>	
    <div>
        <div class="left">
            <header>
                <h1>Dream Catcher</h1>
            </header>
            <form method="post" action="loginProc.jsp">
                <input type="text" name="user_id" placeholder="아이디를 입력하세요">
                <input type="password" name="user_pw" placeholder="비밀번호를 입력하세요">
                <input type="hidden" name="url" value="<%=url%>">
                <input type="submit" class="button" value="로그인">
                <hr width="50%" color="#dee2e6" noshade/>
                <div>
                    <a href="/DreamCatcher/findpassword/findpassword.jsp" class="link">비밀번호 찾기</a>
                    <span class="separator">|</span>
                    <a href="/DreamCatcher/signup/signup.html" class="link">회원가입</a>
                </div>
            </form>
        </div>       
        <div class="right">
            <img src="login.jpg" alt="로그인 이미지">
        </div>
    </div>
</body>
</html>

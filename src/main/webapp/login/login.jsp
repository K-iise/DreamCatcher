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
    <link href="login.css" rel="stylesheet" />
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

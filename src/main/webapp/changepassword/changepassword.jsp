<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="updatepw" class="entity.usersBean"/>
<%
	String username = (String) session.getAttribute("user_id");
	String resnum = (String) session.getAttribute("user_resnum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link href="changepassword.css" rel="stylesheet" />
</head>
<body>
    <header>
        <h1>비밀번호 재설정</h1>
    </header>
    
    <label>아이디 <span style="color: blue;"><%=username %></span> 님 새 비밀번호를 등록해주세요.</label>

    <div class="findbox">
        <div style="text-align: left; width: 100%;">
            <form action="changepasswordProc.jsp" method="post">
                <label for="password">새 비밀번호</label> 
                <input type="password" id="password" name="password" placeholder="새 비밀번호를 입력해주세요" required><br>
                
                <label for="chkpassword">비밀번호 확인</label> 
                <input type="password" id="chkpassword" name="chkpassword" placeholder="비밀번호를 다시 입력해주세요" required><br>
                
                <input type="hidden" name="user_id" value="<%=username %>">
                <input type="hidden" name="user_resnum" value="<%=resnum %>">
                
                <input type="submit" class="button" value="변경하기">
            </form>
        </div>
    </div>

    <hr width="50%" color="#dee2e6" noshade/>

    <div>
        <a href="/DreamCatcher/login/login.jsp" class="link">로그인</a>
        <span class="separator">|</span>
        <a href="/DreamCatcher/signup/signup.html" class="link">회원가입</a>
    </div>

</body>
</html>

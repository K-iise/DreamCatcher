<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="findpw" class="entity.usersBean"/>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>비밀번호 찾기 화면</title>
	<link href="findpassword.css" rel="stylesheet" />
</head>
<body>
    <div>
        <div class="right">
            <header>
                <h1>비밀번호 찾기</h1>
            </header>
            
            <div class="findbox">
                <div style="text-align: left; width: 100%;">

                    <form action="findpasswordProc.jsp" method="post">
                        <label for="user_id">아이디</label>
                        <input type="text" id="user_id" name="user_id" placeholder="아이디를 입력해주세요"><br>

                        <label for="national_id_number">주민등록번호</label>
                        <div style="display: flex; gap: 10px;">
                            <input type="text" id="national_id_number_front" name="national_id_number_front" placeholder="앞자리 6자리" maxlength="6" style="flex: 1;">
                            <span></span>
                            <input type="password" id="national_id_number_back" name="national_id_number_back" placeholder="뒷자리 7자리" maxlength="7" style="flex: 1;">
                        </div>
                        
                        <input type="submit" class="button" value="비밀번호 재설정">
                    </form>
                </div>
            </div>

            <hr width="50%" color="#dee2e6" noshade/>

            <div>
                <a href="/DreamCatcher/login/login.jsp" class="link">로그인</a>
                <span class="separator">|</span>
                <a href="/DreamCatcher/signup/signup.html" class="link">회원가입</a>
            </div>

        </div>
        <div class="left">
            <img src="findpassword.jpg" alt="로그인 이미지">
        </div>
    </div>
</body>
</html>

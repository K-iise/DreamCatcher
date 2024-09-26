<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="findpw" class="entity.usersBean"/>
<!DOCTYPE html>
<html lang="ko" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>비밀번호 찾기 화면</title>
    <style>
        div {
            width: 100%;
        }
        div.right {
            width: 60%;
            height: 100vh;
            float: right;
            box-sizing: border-box;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        div.left {
            width: 40%;
            height: 100vh;
            float: left;
            box-sizing: border-box;
        }
        div.left img {
            height: 100%;
            width: 100%;
            object-fit: cover;
        }
        header {
            font-size: 28px;
        }
        input {
            width: 100%;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 22px;
            transition: border-color 0.3s;
            margin: 10px auto;
        }
        input:focus {
            border-color: #007BFF;
            outline: none;
        }
        input::placeholder {
            color: #aaa;
            font-style: italic;
        }
        .button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 5px;
            background-color: #FE4848;
            color: white;
            font-size: 30px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin: 10px auto;
        }
        .button:hover {
            background-color: rgba(0, 0, 0, 0.5);
        }
        .link {
            margin-top: 10px;
            font-size: 20px;
            color: rgba(0, 0, 0, 0.5);
            text-decoration: none;
        }
        .link:hover {
            text-decoration: underline;
        }
        .separator {
            color: rgba(0, 0, 0, 0.5);
            font-size: 16px;
            margin: 0 5px;
        }
        .findbox {
            border: 1px solid #ccc;
            width: 80%;
            border-radius: 5px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin: 10px auto;
        }
        label {
            font-size: 18px;
            margin: 5px 0 5px;
            display: block;
        }
    </style>
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
                <a href="/DreamCatcher/login/login.html" class="link">로그인</a>
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

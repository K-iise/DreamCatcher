<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%

request.setCharacterEncoding("UTF-8");
String user_id = (String) session.getAttribute("idKey");

usersMgr uMgr = new usersMgr();
usersBean mybean = new usersBean();
mybean=uMgr.oneUserList(user_id);
alarmMgr aMgr=new alarmMgr();
fundingMgr fdMgr=new fundingMgr();
fundingBean fdbean=new fundingBean();
createFundingMgr cfMgr=new createFundingMgr();
createFundingBean cfbean=cfMgr.createFundingList(mybean.getUser_id());

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로젝트 창작자 정보</title>
<style>
    /* 전체 페이지의 기본 스타일 설정 */
    body, html {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        height: 100%;
        overflow-x: hidden;
        box-sizing: border-box;
    }

    *, *::before, *::after {
        box-sizing: inherit;
    }

    /* 상단바 디자인 */
    .header {
        background-color: #fff;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: flex-start;
        padding: 20px 15%;
        border-bottom: 1px solid #dee2e6;
        position: relative;
    }

    /* 뒤로가기 버튼이 있는 줄 */
    .back-row {
        display: flex;
        align-items: center;
        justify-content: flex-start;
        width: 100%;
        margin-bottom: 30px; /* 로고와 공간 추가 */
    }

    /* 뒤로가기 버튼 */
    .back-button {
        width: 30px;
        height: 30px;
        background-color: transparent;
        cursor: pointer;
        font-size: 24px; /* 화살표 크기 조정 */
        color: black;
        border: none;
    }

    /* 로고 영역 */
    .logo {
        margin-bottom: 25px; /* 아래 메뉴와 간격 추가 */
        display: flex;
        align-items: center;
    }

    .logo h1 {
        margin: 0;
        font-size: 30px;
        font-weight: 700;
    }

    /* 메뉴바 수정 */
    .menu-bar {
        display: flex;
        align-items: center;
        justify-content: flex-start; /* 메뉴를 좌측 정렬 */
        gap: 20px; /* 메뉴 사이 간격 */
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .menu-bar .category-label {
        font-size: 25px; /* 글자 크기 동일하게 */
        font-weight: 700;
        margin-right: 20px;
        cursor: pointer;
        white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 설정 */
    }

    .menu-bar .category-label:hover {
        color: red; /* 마우스 올리면 빨간색 */
    }

    .menu-bar .category-label + .category-label {
        margin-left: 20px;
    }

    /* 추가한 요소들 */
    .user-controls {
        position: absolute;
        right: 15%;
        top: 20px;
        display: flex;
        align-items: center;
    }

    .user-controls .upload-button {
        background: url("image/uploadproject.png") no-repeat;
        width: 140px;
        height: 40px;
        border-width: 0;
        margin-right: 10px;
    }

    .user-controls .heart-button {
        background: url("image/hearticon.png") no-repeat;
        width: 40px;
        height: 40px;
        border: 0px;
        margin-left: 20px;
    }

    .user-controls .bell-button {
        background: url("image/bellicon.png") no-repeat;
        width: 40px;
        height: 40px;
        border: 0px;
        margin-left: 20px;
    }

    .user-controls span {
        display: inline-block;
        width: 150px;
        padding: 15px;
        align-items: center;
        border: 1px solid black;
        margin-left: 20px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .user-controls span img {
        width: 35px;
        height: 35px;
        vertical-align: middle;
        margin-right: 5px;
    }
    
    /* 나머지 스타일은 기존 코드 유지 */
    .container {
        padding: 20px;
        margin: 0 auto;
        width: calc(100% - 40px);
        max-width: 1200px; /* 페이지의 최대 너비 설정 */
    }

    .section {
        border-bottom: 1px solid #ccc;
        padding: 30px 0;
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: space-between;
    }

    .text-info {
        flex-basis: 50%;
        min-width: 300px; /* 최소 너비 설정 */
    }

    .input-group-inline {
        display: flex;
        flex-grow: 1;
        justify-content: flex-start; /* 왼쪽 정렬 */
        align-items: center;
        flex-wrap: wrap; /* 작은 화면에서 자동 줄바꿈 */
    }

    label {
        margin-right: 10px;
        font-weight: bold;
        display: block;
        text-align: left;
        width: 100%;
        margin-bottom: 8px;
    }

    select, input[type="text"], textarea {
        padding: 8px 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
        width: 100%; /* 입력 필드 전체 너비 사용 */
        max-width: 600px; /* 최대 너비 설정 */
        height: 50px; /* 높이 통일 */
    }

    input[type="text"], textarea {
        font-size: 18px;
    }

    textarea {
        height: 150px;
        font-size: 16px;
    }

    .input-group-full {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
    }

    .upload-controls {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        width: 100%;
        max-width: 400px;
    }

    .upload-box {
        width: 150px;
        height: 150px;
        background-color: #f5f5f5;
        border: 1px dashed #ccc;
        border-radius: 50%; /* 원형으로 변경 */
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 10px;
    }

    .preview-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%; /* 이미지도 원형으로 변경 */
    }

    .upload-button {
        padding: 8px 16px;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 4px;
        cursor: pointer;
        margin-bottom: 10px;
        width: auto;
    }

    .upload-info {
        font-size: 14px;
        color: #888;
    }

    .url-input {
        display: flex;
        align-items: center;
        flex-grow: 1;
    }

    .url-prefix {
        margin-right: 8px;
    }
    
    .auth-box {
        width: 550px;
        height: 100px;
        background-color: #fafafa;
        border: 1px solid #ccc;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 20px;
    }

    .auth-button {
        padding: 10px 20px;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 4px;
        cursor: pointer;
    }

    .auth-info {
        display: flex;
        align-items: center;
        font-size: 16px;
    }

    .auth-info .icon {
        margin-right: 8px;
        font-size: 20px;
        color: #f65a5b;
    }

    .auth-complete {
        color: #f65a5b;
        font-size: 16px;
        font-weight: bold;
    }

    .form-box {
        border: 1px solid #ccc;
        padding: 30px;
        border-radius: 8px;
        background-color: #fff;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        width: 100%;
        max-width: 550px;
        float: right;
    }

    .form-box .input-group-inline {
        margin-bottom: 20px;
    }

    /* 계좌 종류 토글 버튼 */
    .account-type-toggle {
        display: flex;
        gap: 10px;
        justify-content: flex-start; /* 버튼도 왼쪽 정렬 */
    }

    .account-type-toggle label {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 6px 60px; /* 세로 줄이고 가로로 더 늘리기 */
        border: 1px solid #ccc;
        border-radius: 4px;
        cursor: pointer;
        background-color: #fff;
        color: #333;
        transition: all 0.3s;
        white-space: nowrap; /* 텍스트가 줄바꿈되지 않도록 설정 */
    }

    .account-type-toggle input[type="radio"] {
        display: none;
    }

    .account-type-toggle input[type="radio"]:checked + label {
        border-color: #f65a5b;
        color: #f65a5b;
        background-color: #fff;
    }

    .account-type-toggle span {
        text-align: center;
        width: 100%;
    }


	.user-controls .bell-button2 {
		background: url("image/bellicon2.png") no-repeat;
		width: 40px;
		height: 40px;
		border: 0px;
		margin-left: 20px;
	}
	
	.dropdown {
	    position: relative; /* 부모 요소가 dropdown-content를 기준으로 잡을 수 있도록 설정 */
	    display: inline-block; /* dropdown 요소가 인라인 블록으로 정렬되도록 설정 */
	}
	
	.dropbtn {
	    background-color: transparent;
	    border: none;
	    cursor: pointer;
	}
	
	.dropdown-content {
	    display: none; /* 기본적으로 숨김 */
	    position: absolute; /* 부모 요소에 대해 절대 위치 */
	    background-color: #f9f9f9;
	    min-width: 160px; /* 드롭다운의 최소 너비 설정 */
	    min-height: 160px;
	    box-shadow: rgba(0,0,0,0.2);
	    z-index: 1000; /* 다른 요소보다 위에 표시되도록 설정 */
	    right: 0;
	    margin-right: 15%;
	}
	
	.dropdown-content a {
	    color: black;
	    padding: 12px 16px;
	    text-decoration: none;
	    display: block; /* 세로로 나열되도록 설정 */
	    width: 100%;
	}
</style>
<script>
    // 폼 제출을 위한 JavaScript 함수
    function submitForm(pageURL) {
        var form = document.getElementById("projectForm");  // 'projectForm' ID를 가진 폼을 가져옵니다.
        form.action = pageURL;  // action 속성을 동적으로 변경합니다.
        form.submit();  // 폼을 제출합니다.
    }
</script>
</head>
<body>
    <div class="header">
        <!-- 뒤로가기 버튼이 있는 줄 -->
        <div class="back-row">
            <button class="back-button" onclick="history.back();">←</button>
        </div>

        <!-- 프로젝트 기획 로고 -->
        <div class="logo">
            <h1>프로젝트 기획</h1>
        </div>

        <!-- 사용자 컨트롤 -->
        <div class="user-controls">
            <input type="button" class="heart-button" onclick="location.href='../interestProject/interestProject.jsp'">
			<%if(aMgr.alarmOnOff(mybean.getUser_id())){ %>
			<input type="button" class="bell-button2" onclick="location.href='../alarm/alarm.jsp';">
			<%}else{ %>
			<input type="button" class="bell-button" onclick="location.href='../alarm/alarm.jsp';"> 
			<%} %>

			<span class="dropbtn" onclick="toggleDropdown()">
				<img src='<%=mybean.getUser_image() %>' alt="User Icon">
			    <b><%= mybean.getUser_name() %></b>
			</span>
        </div>
        
    <div class="dropdown-content">
		<a href="../profile/profile.jsp?selectedid=<%=user_id%>">프로필</a>
	    <a href="../interestProject/interestProject.jsp">관심프로젝트</a>
	    <a href="../alarm/alarm.jsp">알림</a>
	    <a href="../logout/logout.jsp">로그아웃</a>
    </div>

        <!-- 메뉴들 -->
        <nav class="menu-bar">
            <label class="category-label" onclick="submitForm('projectBasicinfo.jsp')">기본 정보</label>
            <label class="category-label" onclick="submitForm('projectFundingschedule.jsp')">펀딩 계획</label>
            <label class="category-label" onclick="submitForm('projectExplanation.jsp')">프로젝트 계획</label>
            <label class="category-label" onclick="submitForm('projectCreatorinfo.jsp')">창작자 정보</label>
        </nav>
    </div>
	<form id="projectForm" action="" method="post">
    <div class="container">
        <!-- 창작자 이름 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>창작자 이름</h2>
                <p>창작자 개인이나 팀을 대표할 수 있는 이름을 써주세요.</p>
            </div>
            <div class="input-group-inline">
                <input type="text">
            </div>
        </div>

        <!-- 프로필 이미지 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>프로필 이미지</h2>
                <p>창작자 개인이나 팀의 사진을 올려주세요.</p>              
            </div>
            <div class="upload-controls">
                <div class="upload-box">
                    <span class="upload-placeholder">이미지 미리보기</span>
                </div>
                <label for="file-upload" class="upload-button">이미지 파일 업로드</label>
                <input type="file" id="file-upload" class="upload-input" style="display:none;">
                <div class="upload-info">파일 형식은 jpg, png 또는 gif로, 사이즈는 가로 150px, 세로 150px 이상으로 올려주세요.</div>
            </div>
        </div>
        
        <!-- 창작자 소개 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>창작자 소개</h2>
                <p>2~3문장으로 창작자님의 이력과 간단한 소개를 써주세요.</p>
            </div>
            <div class="input-group-inline">
                <textarea></textarea>
            </div>
        </div>
        
         <!-- 본인 인증 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>본인 인증</h2>
                <p>창작자 본인 명의의 휴대폰 번호로 인증해주세요.</p>
            </div>
            <div class="auth-box" id="authBox">
                <button class="auth-button" id="authButton">인증하기</button>
            </div>
        </div>
    
    <!-- 입금 계좌 섹션 -->
    <div class="section">
        <div class="text-info">
            <h2>입금 계좌</h2>
            <p>후원금을 전달받을 계좌를 등록해주세요.<br>법인사업자는 법인계좌로만 청산받을 수 있습니다.</p>
        </div>
        
        <!-- 계좌 입력 박스 -->
        <div class="form-box">
            <!-- 계좌 종류 토글 버튼 -->
            <div class="input-group-inline">
                <label for="accountType">계좌 종류</label>
                <div class="account-type-toggle">
                    <input type="radio" id="personal" name="accountType" value="personal" checked>
                    <label for="personal"><span>개인</span></label>
                    <input type="radio" id="business" name="accountType" value="business">
                    <label for="business"><span>사업자</span></label>
                </div>
            </div>

            <!-- 거래 은행 드롭다운 -->
            <div class="input-group-inline">
                <label for="bank">거래 은행</label>
                <select id="bank" name="bank">
                    <option value="">은행을 선택해주세요</option>
                    <option value="kookmin">국민은행</option>
                    <option value="shinhan">신한은행</option>
                    <option value="woori">우리은행</option>
                    <option value="hana">하나은행</option>
                    <!-- Add other banks as needed -->
                </select>
            </div>

            <!-- 예금주명 입력 -->
            <div class="input-group-inline">
                <label for="accountHolder">예금주명</label>
                <input type="text" id="accountHolder" name="accountHolder" placeholder="예금주명을 입력해주세요">
            </div>

            <!-- 계좌번호 입력 -->
            <div class="input-group-inline">
                <label for="accountNumber">계좌번호</label>
                <input type="text" id="accountNumber" name="accountNumber" placeholder="계좌번호를 입력해주세요" maxlength="16">
            </div>
        </div>
    </div>
    </div>
</form>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var uploadInput = document.querySelector('.upload-input');
            var uploadBox = document.querySelector('.upload-box');
            var uploadPlaceholder = document.querySelector('.upload-placeholder');

            uploadInput.addEventListener('change', function() {
                var file = this.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        var imgElement = document.createElement('img');
                        imgElement.src = e.target.result;
                        imgElement.className = 'preview-image';
                        uploadBox.innerHTML = '';
                        uploadBox.appendChild(imgElement);
                    };
                    reader.readAsDataURL(file);
                }
            });

            var uploadButton = document.querySelector('.upload-button');
            uploadButton.addEventListener('click', function() {
                uploadInput.click();
            });

            // 인증하기 버튼 클릭 이벤트
            var authButton = document.getElementById('authButton');
            authButton.addEventListener('click', function() {
                completeAuth();
            });
        });

        function completeAuth() {
            var authBox = document.getElementById('authBox');
            authBox.innerHTML = `
                <div class="auth-info">
                    <span class="icon">👤</span>
                    <div>
                        김유준<br>
                        001002 / 010-1234-5678
                    </div>
                </div>
                <div class="auth-complete">
                    ✔ 인증 완료
                </div>
            `;
        }
    </script>
    <script src="dropdown.js"></script>
</body>
</html>

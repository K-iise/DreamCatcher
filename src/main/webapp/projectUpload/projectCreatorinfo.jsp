<%@page import="java.nio.file.Paths"%>
<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%

request.setCharacterEncoding("UTF-8");
String user_id = (String) session.getAttribute("idKey");
System.out.println("-----------------------------------------");

usersMgr uMgr = new usersMgr();
usersBean mybean = new usersBean();
mybean=uMgr.oneUserList(user_id);
alarmMgr aMgr=new alarmMgr();
fundingMgr fdMgr=new fundingMgr();
fundingBean fdbean=new fundingBean();
createFundingMgr cfMgr=new createFundingMgr();
createFundingBean cfbean=cfMgr.createFundingList(mybean.getUser_id());


String action = request.getParameter("Action");
System.out.println("action: " + action); // 디버깅 로그
String nextPage = request.getParameter("nextPage");
System.out.println("Next page: " + nextPage); // 디버깅 로그

if ("submit".equals(action)) {
    String name = request.getParameter("name");
    String info = request.getParameter("info");
    Part fileupload = request.getPart("file-upload");
 
    System.out.println("name: " + name);
    System.out.println("info: " + info);
    System.out.println("fileupload: " + fileupload);
    

    // 데이터 설정 및 저장 로직
	mybean.setUser_name(name);
	mybean.setUser_info(info);
    
	if (fileupload != null && fileupload.getSize() > 0) {
        String fileName = extractFileName(fileupload);

        // 저장할 실제 서버 경로 설정
        String uploadPath = getServletContext().getRealPath("/userimage");
        File uploadDir = new File(uploadPath);

        // 디렉터리가 없으면 생성
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // 저장할 경로 및 파일 이름 생성
        String filePath = uploadPath + File.separator + fileName;
        
        System.out.println("Upload Path: " + uploadPath);  // 경로 출력
        System.out.println("File Path: " + filePath);  // 파일 경로 출력
        
        // 파일 저장
        fileupload.write(filePath);

        // 파일 경로를 데이터베이스에 저장 
        String relativePath = request.getContextPath() + "/userimage/" + fileName;
        
        mybean.setUser_image(relativePath);
    }


    // 데이터베이스에 저장
    uMgr.userUpdate(mybean);  // 데이터 저장

    // 저장이 성공하면 전송된 페이지로 이동
    if (nextPage != null && !nextPage.isEmpty()) {
        response.sendRedirect(nextPage);
    } else {
    	request.getRequestDispatcher("projectBasicinfo.jsp").forward(request, response);  // 기본 페이지로 이동
    }
}

%>
<%!
private String extractFileName(Part part) {
    String contentDisposition = part.getHeader("content-disposition");
    String[] items = contentDisposition.split(";");
    for (String item : items) {
        if (item.trim().startsWith("filename")) {
            return item.substring(item.indexOf("=") + 2, item.length() - 1);
        }
    }
    return "";
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로젝트 창작자 정보</title>
<style>

    /* 전체 페이지의 기본 스타일 설정 */
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

        /* 상단바 디자인 - 기본정보 페이지의 스타일을 그대로 적용 */
        .header {
            background-color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            padding: 20px 15%;
            position: relative;
            height: 210px; /* 헤더의 높이를 고정 값으로 설정 */
            border-bottom: 1px solid #dee2e6;  /* 동일한 구분선 */
            margin: 0; /* 추가적인 여백 없애기 */
        }

        .back-row {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            width: 100%;
            margin-bottom: 30px;
        }

        .back-button {
            width: 30px;
            height: 30px;
            background-color: transparent;
            cursor: pointer;
            font-size: 24px;
            color: black;
            border: none;
        }

        .logo {
            margin-bottom: 25px;
            display: flex;
            align-items: center;
        }

        .logo h1 {
            margin: 0;
            font-size: 30px;
            font-weight: 700;
        }

        /* 메뉴바 디자인 */
        .menu-bar {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            gap: 20px;
            padding-bottom: 0;  
            margin-bottom: 0;  
        }

        .menu-bar .category-label {
            font-size: 25px;
            font-weight: 700;
            margin-right: 20px;
            cursor: pointer;
            white-space: nowrap;
        }

        .menu-bar .category-label:hover {
            color: red;
        }

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

        .user-controls .bell-button2 {
            background: url("image/bellicon2.png") no-repeat;
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

        /* 기본 컨테이너 스타일 */
        .container {
            padding: 20px;
            margin: 0 auto;
            width: calc(100% - 40px);
            max-width: 1200px;
        }

        .section {
            border-bottom: 1px solid #ccc;
            padding: 30px 0;
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            margin: 0; /* 상단과 하단의 여백을 없앱니다 */
        }

        .text-info {
            flex-basis: 50%;
            min-width: 300px;
        }

        .input-group-inline {
            display: flex;
            flex-grow: 1;
            justify-content: flex-start;
            align-items: center;
            flex-wrap: wrap;
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
            width: 100%;
            max-width: 600px;
            height: 50px;
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
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
        }

        .upload-placeholder {
		    width: 150px; /* 적당한 크기로 설정 */
		    height: 150px;
		    border-radius: 50%;
		    background-size: cover;
		    background-position: center;
		    background-repeat: no-repeat;
		}
		
        .preview-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
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
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 550px;
            float: right;
        }

        .form-box .input-group-inline {
            margin-bottom: 20px;
        }

        .account-type-toggle {
            display: flex;
            gap: 10px;
            justify-content: flex-start;
        }

        .account-type-toggle label {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 6px 60px;
            border: 1px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
            background-color: #fff;
            color: #333;
            transition: all 0.3s;
            white-space: nowrap;
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

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropbtn {
            background-color: transparent;
            border: none;
            cursor: pointer;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            min-height: 160px;
            box-shadow: rgba(0, 0, 0, 0.2);
            z-index: 1000;
            right: 0;
            margin-right: 15%;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            width: 100%;
        }
        
    .next-button {
	position: fixed;
	bottom: 20px;
	right: 20px;
	padding: 15px 25px;
	background-color: red;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	z-index: 100;
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


    <script>
        // 폼 제출을 위한 JavaScript 함수

 function submitForm(actionUrl) {
        // 숨겨진 input에 actionUrl을 설정
        var form = document.getElementById("projectForm");
        var actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "nextPage";
        actionInput.value = actionUrl;  // 이동할 페이지 경로

        form.appendChild(actionInput);  // 폼에 추가
        form.submit();  // 폼 제출
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
	<form id="projectForm" method="post" enctype="multipart/form-data">
    <input type="hidden" name="Action" value="submit" >
    <div class="container">
        <!-- 창작자 이름 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>창작자 이름</h2>
                <p>창작자 개인이나 팀을 대표할 수 있는 이름을 써주세요.</p>
            </div>
            <div class="input-group-inline">
                <input type="text" name="name" id="name" value=<%=mybean.getUser_name() %>>
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
                <%
		            String imagePath = mybean.getUser_image();  // 이미지 경로를 서버로부터 가져옴
		            if (imagePath != null && !imagePath.isEmpty()) {
		                // 이미지가 있을 경우
		        %>
		         	<span class="upload-placeholder" style="background-image: url('<%=imagePath %>');"></span>
		        <%
		            } else {
		                // 이미지가 없을 경우 빈칸
		        %>
		            <span class="upload-placeholder">이미지 미리보기</span>
		        <%
		            }
		        %>
                    
                </div>
                <label for="file-upload" class="upload-button">이미지 파일 업로드</label>
                <input type="file" id="file-upload" name="file-upload" class="upload-input" style="display:none;">
                <div class="upload-info">파일 형식은 jpg, png 또는 gif로, 사이즈는 가로 150px, 세로 150px 이상으로 올려주세요.</div>
            </div>
        </div>
        
        <!-- 창작자 소개 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>창작자 소개</h2>
                <p>2~3문장으로 창작자님의 이력과 간단한 소개를 써주세요.</p>
            </div>
            <div class="input-group-inline" >
                <textarea name="info" id="info"><%=mybean.getUser_info() %></textarea>
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
    <button type="submit" class="next-button">확인</button>
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

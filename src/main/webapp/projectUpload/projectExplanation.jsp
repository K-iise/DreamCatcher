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
    <title>프로젝트 계획</title>

    <!-- Quill.js CSS -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

    <style>
        /* 전체 페이지의 기본 스타일 설정 */
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            height: 100%;
            overflow: auto;
            box-sizing: border-box;
        }

        *, *::before, *::after {
            box-sizing: inherit;
        }

        /* 상단바 디자인 */
        .header {
            background-color: #fff;
            display: flex;
            flex-direction: column; /* 세로 정렬 */
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

        .menu-bar {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            width: 100%;
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
            max-width: 1200px;
        }

        .section {
            border-bottom: 1px solid #ccc;
            padding: 30px 0;
            display: flex;
            flex-wrap: wrap;
            align-items: flex-start;
            justify-content: space-between;
        }

        .text-info {
            flex-basis: 30%;
        }

        .editor-container {
            flex-basis: 70%;
            margin-bottom: 40px;
        }

        .editor {
            height: 500px; /* 에디터의 세로 크기를 동일하게 설정 */
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
        <!-- 프로젝트 계획 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>프로젝트 계획</h2>
            </div>
            <!-- 첫 번째 글쓰기 기능을 추가한 에디터 섹션 -->
            <div class="editor-container">
                <h2>프로젝트 소개</h2>
                <p>무엇을 만들기 위한 프로젝트인지 설명해 주세요.</p>
                <div id="editor0" class="editor"></div> <!-- 첫 번째 Quill.js 에디터 -->
            </div>
        </div>
        
        <!-- 두 번째 글쓰기 기능을 추가한 에디터 섹션 -->
        <div class="section">
            <div class="text-info">
            </div>
            <div class="editor-container">
                <h2>프로젝트 예산</h2>
                <p>펀딩 목표 금액을 제작에 어떻게 사용할 것인지 구체적으로 알려주세요. ‘인건비’, ‘배송비’, ‘인쇄비’, ‘대관료’ 등 세부 항목별로 작성해야 합니다.</p>
                <div id="editor1" class="editor"></div> <!-- 두 번째 Quill.js 에디터 -->
            </div>
        </div>
        
        <!-- 세 번째 글쓰기 기능을 추가한 에디터 섹션 -->
        <div class="section">
            <div class="text-info">
            </div>
            <div class="editor-container">
                <h2>프로젝트 일정</h2>
                <p>작업 일정을 구체적인 날짜와 함께 작성하세요. 후원자가 일정을 보면서 어떤 작업이 진행될지 알 수 있어야 합니다. 펀딩 종료 이후의 제작 일정을 반드시 포함하세요.</p>
                <div id="editor2" class="editor"></div> <!-- 세 번째 Quill.js 에디터 -->
            </div>
        </div>
        
        <!-- 네 번째 글쓰기 기능을 추가한 에디터 섹션 -->
        <div class="section">
            <div class="text-info">
            </div>
            <div class="editor-container">
                <h2>선물 설명</h2>
                <p>후원자가 후원 금액별로 받을 수 있는 선물을 상세하게 알려주세요. 표로 정리하거나 예시 이미지를 포함하는 것도 방법입니다.</p>
                <div id="editor3" class="editor"></div> <!-- 네 번째 Quill.js 에디터 -->
            </div>
        </div>
    </div>
</form>
    <!-- Quill.js Script -->
    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>

    <!-- Quill.js 이미지 업로드 기능 추가 -->
    <script>
        function imageHandler() {
            var input = document.createElement('input');
            input.setAttribute('type', 'file');
            input.setAttribute('accept', 'image/*');
            input.click();

            input.onchange = function () {
                var file = input.files[0];
                var reader = new FileReader();
                reader.onload = function (e) {
                    var base64String = e.target.result;
                    var range = quill.getSelection();
                    quill.insertEmbed(range.index, 'image', base64String);
                };
                reader.readAsDataURL(file);
            };
        }

        var toolbarOptions = [
            ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
            ['blockquote', 'code-block'],

            [{ 'header': 1 }, { 'header': 2 }],               // custom button values
            [{ 'list': 'ordered'}, { 'list': 'bullet' }],
            [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
            [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
            [{ 'direction': 'rtl' }],                         // text direction

            [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
            [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

            [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
            [{ 'font': [] }],
            [{ 'align': [] }],

            ['clean'],                                         // remove formatting button
            ['link', 'image']                                  // link and image, image includes handler
        ];

        var quills = [];

        for (var i = 0; i < 4; i++) {
            quills[i] = new Quill(`#editor${i}`, {
                theme: 'snow', // Quill.js의 기본 테마 설정
                modules: {
                    toolbar: {
                        container: toolbarOptions,
                        handlers: {
                            image: imageHandler // 이미지 핸들러 정의
                        }
                    }
                }
            });
        }

        // 초기 텍스트를 외부에서 선언
        var initialContent = [
            `막연하다면 아래의 질문에 대한 답에 내용에 포함되도록 작성해보세요.<br><br>
Q. 무엇을 만들기 위한 프로젝트인가요?<br>
Q. 프로젝트를 간단히 소개한다면?<br>
Q. 이 프로젝트가 왜 의미있나요?<br>
Q. 이 프로젝트를 시작하게 된 배경이 무엇인가요?`,
            
            `설정하신 목표 금액을 어디에 사용 예정이신지 구체적인 지출 항목으로 적어 주세요.
- 예산은 '제작비'가 아닌 구체적인 '항목'으로 적어 주세요.
- 이번 프로젝트의 실행에 필요한 비용으로만 작성해 주세요.
- 기부, 다음 프로젝트에 사용하기 등은 이번 프로젝트의 예산으로 볼 수 없어요.
- 만약 전체 제작 비용 중 일부만 모금하시는 경우라면, 나머지 제작 비용은 어떻게 마련 예정인지 추가로 작성해 주세요.<br>
(예시)<br>
목표 금액은 아래의 지출 항목으로 사용할 예정입니다.
 - 인건비
 - 배송비
 - 발주비
 - 디자인 의뢰비
 - 수수료`,
            
            `설정하신 목표 금액을 어디에 사용 예정이신지 구체적인 지출 항목으로 적어 주세요.<br>        
(예시)
목표 금액은 아래의 지출 항목으로 사용할 예정입니다.
 - 0월0일: 현재 제품 시안 및 1차 샘플 제작
 - 0월0일: 펀딩 시작일
 - 0월0일: 샘플 작업 보완
 - 0월0일: 펀딩 종료일
 - 0월0일: 2차 샘플 제작
 - 0월0일: 제품 디테일 보완
 - 0월0일: 제품 발주 시작
  - 0월0일: 후가공 처리 및 포장 작업
 - 0월0일: 선물 예상 전달일`,
            
            ``
        ];

        // 초기 텍스트 적용
        for (var i = 0; i < quills.length; i++) {
            quills[i].root.innerHTML = initialContent[i];
        }
    </script>
    <script src="dropdown.js"></script>
</body>
</html>

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
System.out.println("-----------------------------------------");

usersMgr uMgr = new usersMgr();
usersBean mybean = new usersBean();
mybean=uMgr.oneUserList(user_id);
alarmMgr aMgr=new alarmMgr();
fundingMgr fdMgr=new fundingMgr();
fundingBean fdbean=new fundingBean();
createFundingMgr cfMgr=new createFundingMgr();
createFundingBean cfbean=cfMgr.createFundingList(mybean.getUser_id());


String selectedProject=fdMgr.getCategory(cfbean.getCreatefunding_category());

String action = request.getParameter("Action");
System.out.println("action: " + action); // 디버깅 로그
String nextPage = request.getParameter("nextPage");
System.out.println("Next page: " + nextPage); // 디버깅 로그

if ("submit".equals(action)) {
    String editor0 = request.getParameter("editor0");
    if (editor0 != null) {
        editor0 = editor0.replaceAll("\\r?\\n", "").trim();
    }
    String editor1 = request.getParameter("editor1");
    if (editor1 != null) {
        editor1 = editor1.replaceAll("\\r?\\n", "").trim();
    }
    String editor2 = request.getParameter("editor2");
    if (editor2 != null) {
        editor2 = editor2.replaceAll("\\r?\\n", "").trim();
    }
    String editor3 = request.getParameter("editor3");
    if (editor3 != null) {
        editor3 = editor3.replaceAll("\\r?\\n", "").trim();
    }

    
    System.out.println("editor0: " + editor0.replace("\n",""));
    System.out.println("editor1: " + editor1.replace("\n",""));
    System.out.println("editor2: " + editor2.replace("\n",""));
    System.out.println("editor3: " + editor3.replace("\n",""));


    // 데이터 설정 및 저장 로직
	cfbean.setCreatefunding_con_0(editor0.replace("\n",""));
	cfbean.setCreatefunding_con_1(editor1.replace("\n",""));
	cfbean.setCreatefunding_con_2(editor2.replace("\n",""));
	cfbean.setCreatefunding_con_3(editor3.replace("\n",""));

    // 데이터베이스에 저장
    cfMgr.createFundingUpdate(cfbean);  // 데이터 저장

    // 저장이 성공하면 전송된 페이지로 이동
    if (nextPage != null && !nextPage.isEmpty()) {
        response.sendRedirect(nextPage);
    } else {
    	request.getRequestDispatcher("projectBasicinfo.jsp").forward(request, response);  // 기본 페이지로 이동
    }
}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 계획</title>

    <!-- TinyMCE 최신 버전 CDN -->
    <script src="https://cdn.tiny.cloud/1/dck0qzskpsmvviydjvl1mlker1t6lfq7y6zhyjyjvqe68b24/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

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
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            padding: 20px 15%;
            border-bottom: 1px solid #dee2e6; /* 구분선 동일하게 설정 */
            position: relative;
            height: 210px;
        }

        /* 뒤로가기 버튼이 있는 줄 */
        .back-row {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            width: 100%;
            margin-bottom: 30px;
        }

        /* 뒤로가기 버튼 */
        .back-button {
            width: 30px;
            height: 30px;
            background-color: transparent;
            cursor: pointer;
            font-size: 24px;
            color: black;
            border: none;
        }

        /* 로고 영역 */
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

        .menu-bar {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            width: 100%;
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

.user-controls {
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
            height: 500px;
        }

        .dropdown {
            position: relative;
            display: inline-block;
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

    <!-- TinyMCE 설정 -->
<script>


// HTML 특수 문자를 처리하는 함수
function escapeHtml(unsafe) {
    return unsafe
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}


tinymce.init({
    selector: 'textarea', // 에디터를 적용할 textarea 선택자
    height: 500,
    plugins: 'image link code textcolor',
    toolbar: 'undo redo | styleselect | bold italic | fontselect fontsizeselect | alignleft aligncenter alignright alignjustify | outdent indent | link image',
    menubar: false,
    
    force_br_newlines: true,   // 엔터 시 <br> 삽입
    forced_root_block: 'p',    // <p> 태그 사용

    // 유효한 HTML 태그 설정
    valid_elements: 'p[style],br,a[href|target=_blank],b,strong,i,em,ul,ol,li,div,img[src|alt|width|height],span[style],h1,h2,h3,h4,h5,h6,code,pre',


    paste_as_text: true,  // 붙여넣기를 텍스트로 처리
    
    images_upload_url: false,
    automatic_uploads: false,
    paste_data_images: true,
    file_picker_types: 'image',
    file_picker_callback: function(callback, value, meta) {
        var input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('accept', 'image/*');

        input.onchange = function() {
            var file = this.files[0];
            var reader = new FileReader();

            reader.onload = function() {
                var id = 'blobid' + (new Date()).getTime();
                var blobCache = tinymce.activeEditor.editorUpload.blobCache;
                var base64 = reader.result.split(',')[1];
                var blobInfo = blobCache.create(id, file, base64);
                blobCache.add(blobInfo);

                callback(blobInfo.blobUri(), { title: file.name });
            };

            reader.readAsDataURL(file);
        };

        input.click();
    },

    setup: function(editor) {
        editor.on('init', function() {
            // JSP 값 안전하게 JavaScript로 변환 (HTML 특수 문자 처리하지 않음)
            var editor0Content = '<%= (cfbean.getCreatefunding_con_0() != null) ? cfbean.getCreatefunding_con_0().trim() : "" %>';
            var editor1Content = '<%= (cfbean.getCreatefunding_con_1() != null) ? cfbean.getCreatefunding_con_1().trim() : "" %>';
            var editor2Content = '<%= (cfbean.getCreatefunding_con_2() != null) ? cfbean.getCreatefunding_con_2().trim() : "" %>';
            var editor3Content = '<%= (cfbean.getCreatefunding_con_3() != null) ? cfbean.getCreatefunding_con_3().trim(): "" %>';


            // JSP에서 받은 값이 존재하는 경우 해당 값으로 설정
            if (editor0Content) {
                tinymce.get('editor0').setContent(editor0Content);
            } else {
                tinymce.get('editor0').setContent("막연하다면 아래의 질문에 대한 답에 내용에 포함되도록 작성해보세요.<br><br>Q. 무엇을 만들기 위한 프로젝트인가요?<br>Q. 프로젝트를 간단히 소개한다면?<br>Q. 이 프로젝트가 왜 의미있나요?<br>Q. 이 프로젝트를 시작하게 된 배경이 무엇인가요?");
            }

            if (editor1Content) {
                tinymce.get('editor1').setContent(editor1Content);
            } else {
                tinymce.get('editor1').setContent("설정하신 목표 금액을 어디에 사용 예정이신지 구체적인 지출 항목으로 적어 주세요.<br>(예시)<br>목표 금액은 아래의 지출 항목으로 사용할 예정입니다.<br>- 인건비<br>- 배송비<br>- 발주비<br>- 디자인 의뢰비<br>- 수수료");
            }

            if (editor2Content) {
                tinymce.get('editor2').setContent(editor2Content);
            } else {
                tinymce.get('editor2').setContent("목표 금액을 어디에 사용 예정이신지 구체적인 지출 항목으로 적어 주세요.<br>(예시)<br>목표 금액은 아래의 지출 항목으로 사용할 예정입니다.<br>- 0월 0일: 제품 시안 및 샘플 제작<br>- 0월 0일: 펀딩 시작일<br>- 0월 0일: 펀딩 종료일<br>- 0월 0일: 선물 발송 예정일");
            }

            if (editor3Content) {
                tinymce.get('editor3').setContent(editor3Content);
            } else {
                tinymce.get('editor3').setContent("");
            }
        });
    }
});

</script>

    <script>
    
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
            <% if (aMgr.alarmOnOff(mybean.getUser_id())) { %>
            <input type="button" class="bell-button2" onclick="location.href='../alarm/alarm.jsp';">
            <% } else { %>
            <input type="button" class="bell-button" onclick="location.href='../alarm/alarm.jsp';">
            <% } %>

            <span class="dropbtn" onclick="toggleDropdown()">
                <img src='<%=mybean.getUser_image() %>' alt="User Icon">
                <b><%= mybean.getUser_name() %></b>
            </span>
        </div>

        <div class="dropdown-content">
            <a href="../profile/profile.jsp?selectedid=<%= user_id %>">프로필</a>
            <a href="../interestProject/interestProject.jsp">관심 프로젝트</a>
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
    <input type="hidden" name="Action" value="submit" >
        <div class="container">
            <!-- 프로젝트 계획 섹션 -->
            <div class="section">
                <div class="text-info">
                    <h2>프로젝트 계획</h2>
                </div>
                <div class="editor-container">
                    <h2>프로젝트 소개</h2>
                    <p>무엇을 만들기 위한 프로젝트인지 설명해 주세요.</p>
                    <textarea class="editor" name="editor0" id="editor0"></textarea>
                </div>
            </div>

            <div class="section">
                <div class="text-info"></div>
                <div class="editor-container">
                    <h2>프로젝트 예산</h2>
                    <p>펀딩 목표 금액을 제작에 어떻게 사용할 것인지 구체적으로 알려주세요.</p>
                    <textarea class="editor" name="editor1" id="editor1"></textarea>
                </div>
            </div>

            <!-- 프로젝트 일정 섹션 -->
            <div class="section">
                <div class="text-info"></div>
                <div class="editor-container">
                    <h2>프로젝트 일정</h2>
                    <p>작업 일정을 구체적인 날짜와 함께 작성하세요.</p>
                    <textarea class="editor" name="editor2" id="editor2"></textarea>
                </div>
            </div>

            <!-- 선물 설명 섹션 -->
            <div class="section">
                <div class="text-info"></div>
                <div class="editor-container">
                    <h2>선물 설명</h2>
                    <p>후원자가 후원 금액별로 받을 수 있는 선물을 상세하게 알려주세요.</p>
                    <textarea class="editor" name="editor3" id="editor3"></textarea>
                </div>
            </div>
            
            <button type="submit" class="next-button">확인</button>
        </div>
    </form>

    <script src="dropdown.js"></script>
</body>
</html>

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
// cfbean.getCreatefunding_term()이 문자열로 되어 있다고 가정
String fundingTerm = cfbean.getCreatefunding_term();

// 문자열을 Date로 변환
java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date date = null;

try {
    date = inputFormat.parse(fundingTerm); // "yyyy-MM-dd HH:mm:ss.S" 형식으로 파싱
} catch (java.text.ParseException e) {
    e.printStackTrace();
}

// 변환된 Date를 "yyyy-MM-dd" 형식으로 출력
String formattedDate = (date != null) ? outputFormat.format(date) : "";


String action = request.getParameter("Action");
System.out.println("action: " + action); // 디버깅 로그
String nextPage = request.getParameter("nextPage");
System.out.println("Next page: " + nextPage); // 디버깅 로그

if ("submit".equals(action)) {
    // 목표 금액과 프로젝트 제목, 요약 가져오기
    int tprice = 0;
	try {
	    tprice = Integer.parseInt(request.getParameter("tprice"));  // 목표 금액을 int로 변환
	} catch (NumberFormatException e) {
	    // 변환 실패 시 예외 처리
	    System.out.println("목표 금액 변환 오류: " + e.getMessage());
	    // 예외 처리를 통해 적절한 처리 방법을 추가할 수 있음 (예: 기본값 설정, 에러 메시지 반환 등)
	}
    String endDate = request.getParameter("end-date");  // 종료일
    
    // 폼 값 출력 (디버깅용)
    System.out.println("목표 금액: " + tprice);
    System.out.println("종료일: " + endDate);
    
    // cfbean 설정 및 저장 로

    cfbean.setCreatefunding_term(endDate);  // 종료일 설정
    cfbean.setCreatefunding_tprice(tprice);  // 목표 금액 설정
    
    // 이미지 파일 업로드 처리 (서버에 저장)

    // 데이터베이스에 저장
    cfMgr.createFundingUpdate(cfbean);  // 데이터 저장
    
    // 저장 성공 후 페이지 이동
    if (nextPage != null && !nextPage.isEmpty()) {
        response.sendRedirect(nextPage);  // 저장 성공하면 다른 페이지로 이동
    } else {
        request.getRequestDispatcher("projectfundingschedule.jsp").forward(request, response);  // 실패 시 현재 페이지로 이동
    }
}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 펀딩 계획</title>

    <!-- Flatpickr CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

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
            padding: 20px 15%; /* 페이지 중앙에 맞춤 */
            border-bottom: 1px solid #dee2e6;
            position: relative;
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

        /* 사용자 컨트롤 */
        .user-controls {
            position: absolute;
            right: 15%; /* 기본 정보와 동일한 위치 */
            top: 20px;
            display: flex;
            align-items: center;
        }

        .user-controls .heart-button {
            background: url("image/hearticon.png") no-repeat;
            background-size: contain; /* 아이콘 크기 설정 */
            width: 40px;
            height: 40px;
            border: 0px;
            margin-left: 20px;
        }

        .user-controls .bell-button {
            background: url("image/bellicon.png") no-repeat;
            background-size: contain; /* 아이콘 크기 설정 */
            width: 40px;
            height: 40px;
            border: 0px;
            margin-left: 20px;
        }

        .user-controls .bell-button2 {
            background: url("image/bellicon2.png") no-repeat;
            background-size: contain; /* 아이콘 크기 설정 */
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
            width: calc(100% - 40px); /* 기본 정보와 동일하게 중앙 정렬 */
            max-width: 1200px;
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
        }

        .input-group-inline {
            display: flex;
            flex-grow: 1;
            justify-content: space-evenly;
            align-items: center;
        }

        label {
            margin-right: 10px;
        }

        select, input[type="text"], textarea {
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        input[type="text"], textarea {
            width: 100%;
        }

        input[type="text"] {
            height: 60px;
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

        /* 펀딩 일정 섹션 스타일 */
        .funding-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            width: 100%;
        }

        .funding-info {
            flex: 1;
            padding-right: 20px;
        }

        .funding-schedule {
            flex: 1;
            display: flex;
            flex-direction: column;
            max-width: 100%;
        }

        .schedule-row {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            height: 50px;
            width: 100%;
        }

        /* 일정 레이블들의 너비를 동일하게 설정하고 텍스트를 왼쪽 정렬 */
        .schedule-row label {
            width: 120px;
            font-weight: bold;
            text-align: left;
            padding-right: 10px;
        }

        .schedule-row .input-wrapper {
            display: flex;
            align-items: center;
            flex-grow: 1;
            position: relative;
        }

        /* 달력 아이콘 */
        .calendar-icon {
            position: absolute;
            right: 10px;
            font-size: 20px;
            cursor: pointer;
            color: #aaa;
        }

        .schedule-row input, .schedule-row select {
            width: 100%;
            height: 40px;
            padding: 8px 40px 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .schedule-start {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }

        .schedule-start .input-wrapper {
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
            box-shadow: rgba(0,0,0,0.2);
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
	<form id="projectForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="Action" value="submit" >
    <div class="container">
        
        <!-- 프로젝트 목표 금액 섹션 -->
        <div class="section">
            <div class="text-info">
                <h2>목표 금액</h2>
                <p>프로젝트를 완수하기 위해 필요한 금액을 설정해주세요.</p>
            </div>
            <div class="input-group-inline">
                <input name="tprice" type="text" placeholder="금액을 입력해주세요" value='<%=cfbean.getCreatefunding_tprice() %>'>
            </div>
        </div>
        
        <!-- 펀딩 일정 섹션 -->
        <div class="section funding-section">
            <!-- 좌측 정보 -->
            <div class="funding-info">
                <h2>펀딩 일정</h2>
                <p>설정한 일시가 되면 펀딩이 자동 시작됩니다. 펀딩 시작</p>
                <p>전까지 날짜를 변경할 수 있고, 즉시 펀딩을 시작할 수도</p>
                <p>있습니다.</p>
            </div>
            


            <!-- 우측 일정 설정 -->
            <div class="funding-schedule">

                    <div class="schedule-row">
                        <label for="funding-max">펀딩 기간</label>
                        <div class="input-wrapper">
                            <p>최대 60일</p>
                        </div>
                    </div>

                <div class="schedule-row">
                    <label for="end-date">종료일</label>
                    <div class="input-wrapper">
                        <input type="text" name="end-date" id="end-date" placeholder="종료 날짜 선택" value="<%= formattedDate %>" readonly>
                        <span class="calendar-icon" onclick="openCalendar('#end-date')">&#128197;</span>
                    </div>

                    <div class="schedule-row">
                        <label for="payment-end">결제 종료</label>
                        <div class="input-wrapper">
                            <p>종료일 다음 날부터 7일</p>
                        </div>
                    </div>

                    <div class="schedule-row">
                        <label for="settlement-date">정산일</label>
                        <div class="input-wrapper">
                            <p>결제 종료 후 7영업일</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <button type="submit" class="next-button">확인</button>
        </div>
    </form>

    <!-- Flatpickr JS -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <!-- Flatpickr 설정 -->
    <script>
        // Flatpickr 달력 열기
        function openCalendar(id) {
            if (id === '#start-date') {
                flatpickr(id, {
                    dateFormat: "Y-m-d", // 날짜 형식
                    minDate: new Date().fp_incr(1), // 현재 날짜의 다음 날부터 선택 가능
                    onChange: function(selectedDates, dateStr, instance) {
                        document.querySelector(id).value = dateStr;

                        // 종료일 설정 시 시작일 기준으로 최대 60일까지 선택 가능하도록 설정
                        flatpickr("#end-date", {
                            dateFormat: "Y-m-d",
                            minDate: dateStr,
                            maxDate: new Date(selectedDates[0]).fp_incr(60)
                        });
                    }
                }).open();
            } else {
                flatpickr(id, {
                    dateFormat: "Y-m-d"
                }).open();
            }
        }

        // 시작 시간에 09:00부터 18:00까지 30분 간격으로 옵션 추가
        const startTimeSelect = document.getElementById('start-time');
        for (let hour = 9; hour <= 18; hour++) {
            for (let minutes = 0; minutes < 60; minutes += 30) {
                const formattedHour = String(hour).padStart(2, '0');
                const formattedMinutes = String(minutes).padStart(2, '0');
                const option = document.createElement('option');
                option.value = `${formattedHour}:${formattedMinutes}`;
                option.textContent = `${formattedHour}:${formattedMinutes}`;
                startTimeSelect.appendChild(option);
            }
        }
    </script>

    <script src="dropdown.js"></script>
</body>
</html>

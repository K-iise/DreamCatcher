<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%
request.setCharacterEncoding("UTF-8");
String user_id = (String) session.getAttribute("idKey");

System.out.println("-----------------------------------------");

usersMgr uMgr = new usersMgr();
usersBean mybean = new usersBean();
mybean = uMgr.oneUserList(user_id);
alarmMgr aMgr = new alarmMgr();
fundingMgr fdMgr = new fundingMgr();
fundingBean fdbean = new fundingBean();
createFundingMgr cfMgr = new createFundingMgr();
createFundingBean cfbean = cfMgr.createFundingList(mybean.getUser_id());
createpriceMgr cpMgr=new createpriceMgr();
createpriceBean cpbean=new createpriceBean();
cpbean.setCreateprice_funding_user_id(mybean.getUser_id());
Vector<createpriceBean> cpvlist= cpMgr.priceList(mybean.getUser_id());
// cfbean.getCreatefunding_term()이 문자열로 되어 있다고 가정
String fundingTerm = cfbean.getCreatefunding_term();

// 문자열을 Date로 변환
java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date date = null;

// fundingTerm이 null인 경우 현재 날짜로 설정
if (fundingTerm == null || fundingTerm.isEmpty()) {
	date = new java.util.Date(); // 기본값을 현재 날짜로 설정
} else {
	try {
		date = inputFormat.parse(fundingTerm); // "yyyy-MM-dd HH:mm:ss.S" 형식으로 파싱
	} catch (java.text.ParseException e) {
		e.printStackTrace();
	}
}

if (date == null) {
	date = new java.util.Date(); // 기본값을 현재 날짜로 설정
}
// 변환된 Date를 "yyyy-MM-dd" 형식으로 출력
String formattedDate = (date != null) ? outputFormat.format(date) : "";

String action = request.getParameter("Action");
System.out.println("action: " + action); // 디버깅 로그
String nextPage = request.getParameter("nextPage");
System.out.println("Next page: " + nextPage); // 디버깅 로그


// 디버깅 로그
 if ("delete".equals(action)) {
        int pricenumToDelete = 0;
        try {
            pricenumToDelete = Integer.parseInt(request.getParameter("pricenum"));
        } catch (NumberFormatException e) {
            System.out.println("pricenum 변환 오류: " + e.getMessage());
        }

        if (pricenumToDelete > 0) {
            cpMgr.createpriceDelete(pricenumToDelete);  // 해당 아이템 삭제
            System.out.println("아이템 삭제 완료: " + pricenumToDelete);
        }

        // 비동기 응답
        response.setContentType("text/plain");
        response.getWriter().write("success");
        return;
    }
 else if ("submit".equals(action)) {


	    // 삭제 후 리다이렉트 (목록 페이지로 다시 돌아가기)
	    
	
	// 목표 금액과 프로젝트 제목, 요약 가져오기
	int tprice = 0;
	try {
		tprice = Integer.parseInt(request.getParameter("tprice")); // 목표 금액을 int로 변환
	} catch (NumberFormatException e) {
		// 변환 실패 시 예외 처리
		System.out.println("목표 금액 변환 오류: " + e.getMessage());
		// 예외 처리를 통해 적절한 처리 방법을 추가할 수 있음 (예: 기본값 설정, 에러 메시지 반환 등)
	}
	String endDate = request.getParameter("end-date"); // 종료일

	// 폼 값 출력 (디버깅용)
	System.out.println("목표 금액: " + tprice);
	System.out.println("종료일: " + endDate);

	// cfbean 설정 및 저장 로

	cfbean.setCreatefunding_term(endDate); // 종료일 설정
	cfbean.setCreatefunding_tprice(tprice); // 목표 금액 설정

	// 이미지 파일 업로드 처리 (서버에 저장)

	// 데이터베이스에 저장
	cfMgr.createFundingUpdate(cfbean); // 데이터 저장
	if("projectFundingschedule.jsp".equals(nextPage)){
	String itemname = request.getParameter("item-name");
	int itemprice = 0;
	try {
		itemprice = Integer.parseInt(request.getParameter("item-price")); // 목표 금액을 int로 변환
	} catch (NumberFormatException e) {
		// 변환 실패 시 예외 처리
		System.out.println("목표 금액 변환 오류: " + e.getMessage());
		// 예외 처리를 통해 적절한 처리 방법을 추가할 수 있음 (예: 기본값 설정, 에러 메시지 반환 등)
	}
	int itemquantity = 0;
	try {
		itemquantity = Integer.parseInt(request.getParameter("item-quantity")); // 목표 금액을 int로 변환
	} catch (NumberFormatException e) {
		// 변환 실패 시 예외 처리
		System.out.println("목표 금액 변환 오류: " + e.getMessage());
		// 예외 처리를 통해 적절한 처리 방법을 추가할 수 있음 (예: 기본값 설정, 에러 메시지 반환 등)
	}
	cpbean.setCreateprice_comp(itemname);
	cpbean.setCreateprice(itemprice);
	cpbean.setCreateprice_count(itemquantity);
	
	cpMgr.createpriceInsert(cpbean);
	}

	// 저장 성공 후 페이지 이동
	if (nextPage != null && !nextPage.isEmpty()) {
		response.sendRedirect(nextPage); // 저장 성공하면 다른 페이지로 이동
	} else {
		response.sendRedirect("projectFundingschedule.jsp"); // 실패 시 현재 페이지로 이동
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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<link href="projectFundingschedule.css" rel="stylesheet"/>
<script>
	// 폼 제출을 위한 JavaScript 함수
	// 폼 제출을 위한 JavaScript 함수
	function submitForm(actionUrl) {
		// 숨겨진 input에 actionUrl을 설정
		var form = document.getElementById("projectForm");
		var actionInput = document.createElement("input");
		actionInput.type = "hidden";
		actionInput.name = "nextPage";
		actionInput.value = actionUrl; // 이동할 페이지 경로

		form.appendChild(actionInput); // 폼에 추가
		form.submit(); // 폼 제출
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
			<input type="button" class="heart-button"
				onclick="location.href='../interestProject/interestProject.jsp'">
			<%
			if (aMgr.alarmOnOff(mybean.getUser_id())) {
			%>
			<input type="button" class="bell-button2"
				onclick="location.href='../alarm/alarm.jsp';">
			<%
			} else {
			%>
			<input type="button" class="bell-button"
				onclick="location.href='../alarm/alarm.jsp';">
			<%
			}
			%>

			<span class="dropbtn" onclick="toggleDropdown()"> <img
				src='<%=mybean.getUser_image()%>' alt="User Icon"> <b><%=mybean.getUser_name()%></b>
			</span>
		</div>

		<div class="dropdown-content">
			<a href="../profile/profile.jsp?selectedid=<%=user_id%>">프로필</a> <a
				href="../interestProject/interestProject.jsp">관심프로젝트</a> <a
				href="../alarm/alarm.jsp">알림</a>
				<%if(mybean.getUser_master()==1){ %>
	    <a href="../manager/managerUI.jsp">게시글 관리</a>
	    <%} %>
	     <a href="../logout/logout.jsp">로그아웃</a>
		</div>

		<!-- 메뉴들 -->
		<nav class="menu-bar">
			<label class="category-label"
				onclick="submitForm('projectBasicinfo.jsp')">기본 정보</label> <label
				class="category-label"
				onclick="submitForm('projectFundingschedule.jsp')">펀딩 계획</label> <label
				class="category-label"
				onclick="submitForm('projectExplanation.jsp')">프로젝트 계획</label> <label
				class="category-label"
				onclick="submitForm('projectCreatorinfo.jsp')">창작자 정보</label>
		</nav>
	</div>
	<form id="projectForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="Action" value="submit">
		<div class="container">

			<!-- 프로젝트 목표 금액 섹션 -->
			<div class="section">
				<div class="text-info">
					<h2>목표 금액</h2>
					<p>프로젝트를 완수하기 위해 필요한 금액을 설정해주세요.</p>
				</div>
				<div class="input-group-inline">
					<input name="tprice" type="text" placeholder="금액을 입력해주세요"
						value='<%=cfbean.getCreatefunding_tprice()%>'>
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
							<input type="text" name="end-date" id="end-date"
								placeholder="종료 날짜 선택" value="<%=formattedDate%>" readonly>
							<span class="calendar-icon" onclick="openCalendar('#end-date')">&#128197;</span>
						</div>
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
		
<!-- 새로운 아이템 추가 섹션 -->
<div class="section">
    <div class="container-flex">
        <!-- 왼쪽 아이템 목록 -->
        <div class="left-section">
            <div class="text-info">
                <h2>내가 만든 아이템</h2>
            </div>
            <div id="item-list" class="item-list">
            <%for(int i=0;i<cpvlist.size();i++){ %>
	            <div class="item-box" id="item-<%= cpvlist.get(i).getCreateprice_num() %>">
	                <div class="item-info">
						<span class="item-name">설명: <%=cpvlist.get(i).getCreateprice_comp() %></span>
						<span class="item-price">가격: <%=cpvlist.get(i).getCreateprice() %></span>
						<span class="item-quantity">수량: <%=cpvlist.get(i).getCreateprice_count() %></span>
						<input type="hidden" name="pricenum" value=<%=cpvlist.get(i).getCreateprice_num() %>>
					</div>
					<button class="delete-button" onclick="deleteItem(<%= cpvlist.get(i).getCreateprice_num() %>)">삭제</button>
				</div>
			<%} %>
			<script>
			
			function deleteItem(pricenum) {
			    if (confirm("정말 이 아이템을 삭제하시겠습니까?")) {
			        var xhr = new XMLHttpRequest();
			        xhr.open("POST", "projectFundingschedule.jsp", true);
			        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			        
			        // 삭제 요청 완료 후 처리
			        xhr.onreadystatechange = function() {
			            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
			                alert("아이템이 삭제되었습니다.");
			                // 삭제 후 해당 아이템 박스를 화면에서 제거
			                var itemBox = document.getElementById("item-" + pricenum);
			                itemBox.parentNode.removeChild(itemBox);
			            }
			        };
			        
			        // 서버로 삭제 요청 전송
			        xhr.send("Action=delete&pricenum=" + pricenum);
			    }
			}
			</script>
			
			</script>
            </div>
        </div>

        <!-- 오른쪽 아이템 입력 폼 -->
        <div class="right-section">
            <div class="item-form">
                <h2>아이템 만들기</h2>
                <label for="item-name">아이템 이름</label>
                <input type="text" id="item-name" name="item-name" placeholder="아이템 이름을 입력해주세요" maxlength="50">

                <label for="item-price">아이템 가격</label>
                <input type="text" id="item-price" name="item-price" placeholder="가격을 입력해주세요">

                <label for="item-quantity">아이템 수량</label>
                <input type="text" id="item-quantity" name="item-quantity" placeholder="수량을 입력해주세요">

                <div class="button-group">
                    
                    <button type="button" onclick="submitForm('projectFundingschedule.jsp')">추가</button>
                </div>
            </div>
        </div>
        
        
    </div>
</div>

			<button class="next-button"
				onclick="submitForm('projectExplanation.jsp')">확인</button>
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
					dateFormat : "Y-m-d", // 날짜 형식
					minDate : new Date().fp_incr(1), // 현재 날짜의 다음 날부터 선택 가능
					onChange : function(selectedDates, dateStr, instance) {
						document.querySelector(id).value = dateStr;

						// 종료일 설정 시 시작일 기준으로 최대 60일까지 선택 가능하도록 설정
						flatpickr("#end-date", {
							dateFormat : "Y-m-d",
							minDate : dateStr,
							maxDate : new Date(selectedDates[0]).fp_incr(60)
						});
					}
				}).open();
			} else {
				flatpickr(id, {
					dateFormat : "Y-m-d"
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

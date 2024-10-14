<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>	
<%@ page import="java.text.NumberFormat"%>
<%
	fundingMgr fMgr = new fundingMgr();
	priceMgr pMgr = new priceMgr();
	usersMgr uMgr = new usersMgr();
	usersBean myBean = new usersBean();
	buyRecordBean buyBean = new buyRecordBean();
	buyRecordMgr bMgr = new buyRecordMgr();
	OrderMgr orderMgr = new OrderMgr();
    String merchantUid = orderMgr.generateOrderId(); // 새로운 주문 번호 생성
	
	// 이전 화면에서 전달받은 price_num 값 (이 값은 POST 방식으로 받아올 수 있습니다.)
	int priceNum = Integer.parseInt(request.getParameter("price_num"));
	int quantity = Integer.parseInt(request.getParameter("quantity")); // 수량 가져오기
	int amount = Integer.parseInt(request.getParameter("amount"));
	// funding_num 가져오기
    int fundingNum = fMgr.getFundingNumByPriceNum(priceNum);
	 // price 구성 요소 가져오기
    priceBean price = pMgr.getPrice(fundingNum);
    String user_id = (String) session.getAttribute("idKey");
    myBean=uMgr.oneUserList(user_id);
    // funding_title 가져오기
    String fundingTitle = null;
    if (fundingNum != -1) { // 유효한 funding_num인 경우에만 조회
        fundingTitle = fMgr.getFundingTitleByFundingNum(fundingNum);
    }
 	// funding_image 가져오기
    String fundingImage = fMgr.getFundingImageByFundingNum(fundingNum);
    String fundingNprice = null;
    if (fundingNum != -1) { // 유효한 funding_num인 경우에만 조회
        fundingNprice = fMgr.getFundingTotalPriceByFundingNum(fundingNum);
    }
	 // 달성률 가져오기
    int fundingPercent = 0;
    if (fundingNum != -1) {
        fundingPercent = fMgr.getFundingPercent(fundingNum);
    }    
 	// fundingNum을 사용하여 남은 날짜 계산
    int remainingDays = 0;
    if (fundingNum != -1) {
        remainingDays = fMgr.fundDate(fundingNum); // 남은 날짜를 가져옵니다.
    }
	 // funding의 카테고리 정보 가져오기
    String categoryFunding = null; // 초기값 설정
    if (fundingNum != -1) {
        categoryFunding = fMgr.getCategoryForFunding(fundingNum); // 카테고리 이름 가져오기
    }
    
	 // 총 후원 금액 계산
 	int totalDonation = amount * quantity; // 총 후원 금액
 	
 	// 숫자에 쉼표 추가 포맷팅
 	NumberFormat formatter = NumberFormat.getInstance();
 	String formattedTotalDonation = formatter.format(totalDonation); // 쉼표가 추가된 총 후원 금액
 	String formattedPriceValue = formatter.format(amount);       // 쉼표가 추가된 가격 정보
 	
 	priceBean priceC = pMgr.getPriceByNum(priceNum); // priceNum을 사용하여 priceBean 가져옴
    String priceComp = priceC.getPrice_comp(); // 해당 price_num에 맞는 price_comp 가져오기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 후원하기</title>
<link href="projectdonate.css" rel="stylesheet" />
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
   // 객체 초기화
   var IMP = window.IMP;
   IMP.init("imp46127837");

   var selectedTicketPrice = 0; // 선택된 응원권 가격
   
   function requestPay() {
	// 체크박스 요소 가져오기
	    var check1 = document.getElementById("check1").checked;
	    var checkBtn = document.getElementById("check_btn").checked;

	    // 체크박스 체크 여부 확인
	    if (!check1 || !checkBtn) {
	        alert("유의사항과 동의여부 체크해주시기 바랍니다");
	        return; // 체크되지 않았을 경우 함수 종료
	    }
      var recipientName = document.getElementById("recipient-name").value; // 입력된 이름 값 가져오기
      var address = document.getElementById("address").value;
      
  	 // 할인된 총 후원 금액 계산
      var totalDonation = <%= totalDonation %> - selectedTicketPrice; // 할인된 금액
      IMP.request_pay(
         {
            // 파라미터 값 설정
            pg: "html5_inicis.INIBillTst",
            pay_method: "card",
            merchant_uid: "<%= merchantUid %>", // 상점 고유 주문번호
            name: "<%=fundingTitle%>",
            amount: totalDonation,
            buyer_email: "",
            buyer_name: recipientName, // 입력된 이름 값 사용
            buyer_tel: "<%= myBean.getUser_phone() %>",
            buyer_addr: address,
            buyer_postcode: "123-456",
         },
         function (rsp) {
            // callback
            if (rsp.success) {
            	// 결제가 성공하면 buyRecordInsert를 호출하여 buy_record 테이블에 값 추가
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "buyRecordInsert.jsp", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        // 데이터베이스에 값이 추가되었으면 funding_nprice를 증가시킴
                        var increaseXhr = new XMLHttpRequest();
                        increaseXhr.open("POST", "increaseFundingNprice.jsp", true);
                        increaseXhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        increaseXhr.onreadystatechange = function () {
                            if (increaseXhr.readyState === 4 && increaseXhr.status === 200) {
                                // fundingcheck.jsp로 이동
                                window.location.href = "../fundingcheck/fundingcheck.jsp?fundingNum=<%= fundingNum %>";
                            }
                        };
                        // fundingNum과 totalDonation을 전달
                        
                        increaseXhr.send("fundingNum=" + <%= fundingNum %> + "&amount=" + totalDonation);
                    }
                };
                // priceNum과 userId를 전달
                var userId = "<%= user_id %>";
                xhr.send("priceNum=" + <%= priceNum %> + "&userId=" + userId + "&quantity=" + <%= quantity %>);
             } else {
                // 결제가 실패하면 실패 메시지 표시
                alert("결제에 실패하였습니다: " + rsp.error_msg);
             }
         }
      );
   }
</script>
</head>
<body>
	<!-- 상단 부분 -->
	<div id="header">
		<a>Dream Catcher</a>
		<p>프로젝트 후원하기</p>
	</div>

	<hr id="default-hr" width="100%" noshade />

	<div class="Main">
		<div class="left-section">

			<!-- 제품 정보 상단. -->
			<div id="project-title">
				<!-- 프로젝트 대표 이미지 -->
				<img alt="project-image" src="<%= fundingImage %>">
				<div id="title-info">
					<!-- 카테고리 정보 -->
					<a id="text-category"><%= categoryFunding%> </a>
					<!-- 프로젝트 제목 -->
					<p id="text-title"><%= fundingTitle%></p>
					<div id="product-price">
						<!-- 총 펀딩 금액 -->
						<b id="totalprice"><%= fundingNprice %>원 </b>
						<!-- 현재 펀딩 퍼센트 -->
						<p id="recent-percent"><%=fundingPercent %>%</p>
						<!-- 펀닝 남은 일짜. -->
						<p id="remain-day">· <%= remainingDays %>일 남음</p>
					</div>
				</div>
			</div>
			

			<!-- 선물 정보 -->
			<div id="gift-info">
				<b id="gift-title">선물 정보</b>

				<div id="gift-box">
					<div id="box-title">
						<b>선물 구성</b> <b>선물 금액</b>
					</div>

					<div id="box-content">
						<div id="product-content">
							 <div id="product-content"> 
								 <%= priceComp %>
						    </div>
						</div>

						<div id="expection-content">
							<b style="color: rgba(0, 0, 0, 0.5); margin-right: 10px;">예상전달일</b>
							<b style="color: #FF0000;">2025.01.16</b>
						</div>

						<p id="box-price"><%= formattedTotalDonation %>원</p>
					</div>
				</div>
			</div>
			
			<!-- 배송지 정보 -->
			<div id="delivery-info">
				<b id="delivery-title">배송지</b>
				<div id="delivery-box">
					<button id="delivery-button">+ 배송지 추가</button>
					
					<div id="deliver-detail">
						<div id="deliver-profile">
							<b id="deliver-name">김윤기</b>
							<p id="deliver-address">[38540] 경북 경산시 감못둑길 20 (갑제동) 2005</p>
						</div>
						<button id="change-button">변경</button>
					</div>
				</div>
			</div>

			<!-- 쿠폰 정보 -->
			<div id="coupon-info">
				<b id="coupon-title">프로젝트 응원권</b>

				<div id="coupon-box">
					<b>응원권 선택</b>
					<p id="coupon-hold">사용 가능 0개 / 보유 0개</p>
					<button id="coupon-button">응원권 사용</button>
				</div>
			</div>

			<!-- 결제 정보 -->
			<div id="payment-info">
				<b id="payment-title">결제 수단</b>

				<div id="payment-box">
					<label id="payment-label"> <input type="radio" name="contact" value="email"
						checked /> <span>카드 결제</span>
					</label> 
					
					<label id="payment-label"> <input type="radio" name="contact" value="phone" />
						<span>계좌 이체</span>
					</label>
				</div>
			</div>

		</div>

		<div class="right-section">
			<div id="total-box">
			    <b style="color: #FF0000">최종 후원 금액</b> <b id="total-donation-display"><%= totalDonation %>원</b>
			</div>

			<p id="project-explan">
				프로젝트 성공 시, 결제는 <b id="payment-day" style="color: red">2024.10.12</b> 에
				진행됩니다. 프로젝트가 무산되거나 중단된 경우, 예약된 결제는 자동으로 취소됩니다.
			</p>

			<div id="check_wrap">
				<input type="checkbox" id="check1"> <label id = "explan-label" for="check1"><span>개인정보
						제 3자 제공 동의</span></label>
			</div>

			<div id="check_wrap">
				<input type="checkbox" id="check_btn" /> <label id = "explan-label"for="check_btn"><span>후원
						유의사항 확인</span></label>
			</div>

			<p id="notification">
			<li>후원은 구매가 아닌 창의적인 계획에 자금을 지원하는 일입니다.</li> 드림 캐처에서의 후원은 아직 실현되지 않은
			프로젝트가 실현될 수 있도록 제작비를 후원하는 과정으로, 기존의 상품 또는 용역을 거래의 대상으로 하는 매매와는 차이가
			있습니다. 따라서 전자상거래법상 청약철회 등의 규정이 적용되지 않습니다.
			<li>프로젝트는 계획과 달리 진행될 수 있습니다.</li> 예상을 뛰어넘는 멋진 결과가 나올 수 있지만 진행 과정에서
			계획이 지연, 변경되거나 무산될 수도 있습니다. 본 프로젝트를 완수할 책임과 권리는 창작자에게 있습니다.
			</p>

			<button id="donate-button" onclick="requestPay()">후원하기</button>
		</div>
	</div>
	
	
	<!-- 배송지 추가 모달 -->
<div id="delivery-modal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>배송지 추가</h2>
        <div id="delivery-form">
            <label id ="receiver"for="recipient-name">받는 사람</label>
            <input type="text" id="recipient-name" value="<%= myBean.getUser_name()%>">

            <label id = "address-name" for="address">주소</label>
            <input type="text" id="address" value="<%= myBean.getUser_address()%>">

            <button id = "address-add">추가</button>
        </div>
    </div>
</div>

<!-- 응원권 선택 모달 -->
<div id="support-ticket-modal" class="modal">
    <div class="modal-content">
        <span class="close-support-modal">&times;</span>
        <h2>응원권 선택</h2>
        <div id="support-ticket-form">
        
        	<!-- 응원권 예시 1 -->
			<div class="ticket-box" onclick="selectTicket(1000)">
			    <label class ="usable-label">사용 가능</label>
			    <b class = "ticket-price">1,000원</b>
			    <label class ="coupon-label">창작자 팔로우 시 1000원 할인</label>
			</div>
			
			<!-- 응원권 예시 2 -->
			<div class="ticket-box" onclick="selectTicket(2000)">
			    <label class ="usable-label">사용 가능</label>
			    <b class = "ticket-price">2,000원</b>
			    <label class ="coupon-label">창작자 팔로우 시 2000원 할인</label>
			</div>
			
			<!-- 응원권 예시 2 -->
			<div class="ticket-box" onclick="selectTicket(0)">
			    <b class = "ticket-price">응원권 취소</b>
			    <label class ="coupon-label">취소</label>
			</div>
        	
        	<script>
			    var selectedTicketPrice = 0; // 선택된 응원권 가격
			
			    function selectTicket(price) {
			        selectedTicketPrice = price; // 선택된 응원권 가격 저장
			        updateTotalDonation(); // 총 후원 금액 업데이트
			    }
			
			    function updateTotalDonation() {
			        var totalDonation = <%= totalDonation %>; // 초기 총 후원 금액
			        var discountedTotalDonation = totalDonation - selectedTicketPrice; // 할인된 총 후원 금액
			
			        // 쉼표 추가 포맷팅
			        var formatter = new Intl.NumberFormat();
			        var formattedDiscountedTotalDonation = formatter.format(discountedTotalDonation); // 포맷팅된 총 후원 금액
			
			        document.getElementById("total-donation-display").innerText = formattedDiscountedTotalDonation + "원"; // 화면에 표시
			    }
			</script>
        	
            <button id="support-confirm" class="btn-primary-support">확인</button>
        </div>
    </div>
</div>

<script src="delivery-modal.js"></script>
<script src="coupon-modal.js"></script>
</body>
</html>
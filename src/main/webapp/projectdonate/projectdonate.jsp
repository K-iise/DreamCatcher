<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>	
<%
	fundingMgr fMgr = new fundingMgr();
	priceMgr pMgr = new priceMgr();
	// 이전 화면에서 전달받은 price_num 값 (이 값은 POST 방식으로 받아올 수 있습니다.)
	int priceNum = Integer.parseInt(request.getParameter("price_num"));
	// funding_num 가져오기
    int fundingNum = fMgr.getFundingNumByPriceNum(priceNum);
	 // price 구성 요소 가져오기
    priceBean price = pMgr.getPrice(fundingNum);
	
    // funding_title 가져오기
    String fundingTitle = null;
    if (fundingNum != -1) { // 유효한 funding_num인 경우에만 조회
        fundingTitle = fMgr.getFundingTitleByFundingNum(fundingNum);
    }
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
    // 가격 정보가 있을 경우, 가격을 가져옵니다.
    int priceValue = 0;
    if (price != null) {
        priceValue = price.getPrice(); // 가격 정보를 가져옵니다.
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 후원하기</title>
<link href="projectdonate.css" rel="stylesheet" />
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
				<img alt="project-image" src="image/example.jpg">
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
								 <%= price.getPrice_comp() %>
						    </div>
						</div>

						<div id="expection-content">
							<b style="color: rgba(0, 0, 0, 0.5); margin-right: 10px;">예상전달일</b>
							<b style="color: #FF0000;">2025.01.16</b>
						</div>

						<p id="box-price">29,000원</p>
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
				<b style="color: #FF0000">최종 후원 금액</b> <b>29,000원</b>
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

			<button id="donate-button">후원하기</button>
		</div>
	</div>
	
	
	<!-- 배송지 추가 모달 -->
<div id="delivery-modal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>배송지 추가</h2>
        <div id="delivery-form">
            <label id ="receiver"for="recipient-name">받는 사람</label>
            <input type="text" id="recipient-name" placeholder="받는 분의 성함을 입력해주세요.">

            <label id = "address-name" for="address">주소</label>
            <input type="text" id="address" placeholder="받는 분의 주소를 입력해주세요.">

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
        	<div class="ticket-box">
        		<label class ="usable-label">사용 가능</label>
        		<b class = "ticket-price">1,000원</b>
        		<label class ="coupon-label">창작자 팔로우 시 1000원 할인</label>
        	</div>
        	
        	<!-- 응원권 예시 2 -->
        	<div class="ticket-box">
        		<label class ="usable-label">사용 가능</label>
        		<b class = "ticket-price">2,000원</b>
        		<label class ="coupon-label">창작자 팔로우 시 2000원 할인</label>
        	</div>
        	
            <button id="support-confirm" class="btn-primary-support">확인</button>
        </div>
    </div>
</div>

<script src="delivery-modal.js"></script>
<script src="coupon-modal.js"></script>
</body>
</html>
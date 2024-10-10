// 모달 가져오기
var supportTicketModal = document.getElementById('support-ticket-modal');

// 모달을 여는 버튼 가져오기
var couponButton = document.getElementById("coupon-button");

// 모달을 닫는 버튼 가져오기
var supportCloseBtn = document.getElementsByClassName("close-support-modal")[0];

// "응원권 사용" 버튼 클릭 시 모달 열기
couponButton.onclick = function() {
    supportTicketModal.style.display = "block";
}

// 닫기 버튼 클릭 시 모달 닫기
supportCloseBtn.onclick = function() {
    supportTicketModal.style.display = "none";
}

// 모달 외부 클릭 시 모달 닫기
window.onclick = function(event) {
    if (event.target == supportTicketModal) {
        supportTicketModal.style.display = "none";
    }
}

// 모든 티켓 박스 가져오기 (클래스를 사용하여 여러 옵션)
var ticketBoxes = document.querySelectorAll(".ticket-box");
var selectedBox = null; // 선택된 티켓 박스를 저장하는 변수

// 각 티켓 박스에 클릭 이벤트 추가
ticketBoxes.forEach(function(box) {
    box.addEventListener('click', function() {
        // 이전에 선택된 박스에서 선택된 클래스 제거
        if (selectedBox) {
            selectedBox.classList.remove('selected-ticket');
        }

        // 클릭한 박스에 선택된 클래스 추가
        box.classList.add('selected-ticket');

        // 선택된 박스 참조 업데이트
        selectedBox = box;
		
		//console.log('Selected Box:', selectedBox); // 선택된 박스를 로그로 출력

    });
});

// 확인 버튼과 coupon-hold 요소 가져오기
var supportConfirmButton = document.getElementById("support-confirm");
var couponHoldElement = document.getElementById("coupon-hold");

// 확인 버튼 클릭 시 coupon-hold 텍스트 업데이트
supportConfirmButton.onclick = function() {
    if (selectedBox) {
		console.log('Selected Box:', selectedBox); // 선택된 박스를 로그로 출력
		
		
        // 선택된 티켓 박스에서 가격과 할인 정보 가져오기
        var ticketPrice = selectedBox.querySelector(".ticket-price").textContent;
        var couponLabel = selectedBox.querySelector(".coupon-label").textContent;
		
		// 각 요소가 제대로 선택되었는지 확인
		console.log("Ticket Price Element:", ticketPrice);
		console.log("Coupon Label Element:", couponLabel);
		
		// 'coupon-hold' 텍스트를 선택된 응원권의 가격과 라벨로 업데이트
		couponHoldElement.innerHTML = couponLabel + "<br>" + ticketPrice + " 할인";

		// 업데이트 후 모달 닫기
		supportTicketModal.style.display = "none";
		} 
		else {
		    console.error("Could not find ticket price or coupon label elements.");
		}
    
};

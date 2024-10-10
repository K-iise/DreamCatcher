// 모달 관련 변수
const modal = document.getElementById("delivery-modal");
const btn = document.getElementById("delivery-button");
const btn2 = document.getElementById("change-button");
const span = document.getElementsByClassName("close")[0];

// 배송지 정보 관련 변수
const recipientInput = document.getElementById("recipient-name");
const addressInput = document.getElementById("address");
const deliveryDetail = document.getElementById("deliver-detail");
const deliverName = document.getElementById("deliver-name");
const deliverAddress = document.getElementById("deliver-address");

// 버튼 클릭 시 모달 열기
btn.onclick = function() {
	modal.style.display = "block";
}

// 변경 버튼 클릭 시 모달 열기
btn2.onclick = function() {
	modal.style.display = "block";
	recipientInput.value = deliverName.innerText; // 현재 이름으로 입력 필드 채우기
	addressInput.value = deliverAddress.innerText; // 현재 주소로 입력 필드 채우기
}

// 닫기 버튼 클릭 시 모달 닫기
span.onclick = function() {
	modal.style.display = "none";
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
	if (event.target == modal) {
		modal.style.display = "none";
	}
}

// 배송지 추가 버튼 클릭 시 처리
document.getElementById("address-add").onclick = function() {
	const recipientName = recipientInput.value.trim();
	const address = addressInput.value.trim();

	if (recipientName && address) {
		// 배송지 정보 업데이트
		deliverName.innerText = recipientName;
		deliverAddress.innerText = address;

		// 모달 닫기
		modal.style.display = "none";

		// 배송지 추가 버튼 숨기기, 배송지 정보 보여주기
		document.getElementById("delivery-button").style.display = "none";
		deliveryDetail.style.display = "flex";
	} else {
		// 입력 값이 없으면 버튼 보이기, 배송지 정보 숨기기
		document.getElementById("delivery-button").style.display = "flex";
		deliveryDetail.style.display = "none";
	}
}

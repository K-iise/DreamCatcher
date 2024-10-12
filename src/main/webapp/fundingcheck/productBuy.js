document.addEventListener('DOMContentLoaded', function() {
    const donateInfoList = document.querySelectorAll('.donate-information');

    donateInfoList.forEach(function(donateInfo) {
        donateInfo.addEventListener('click', function() {
            // donate-information의 ul 내용과 제목, 금액 가져오기
            const productPrice = donateInfo.querySelector('b').textContent; // 금액
			
			console.log(productPrice);
			
			const productTitle = donateInfo.querySelector('.product-information').childNodes[0].textContent; // 상품 제목
            const productUl = donateInfo.querySelector('.product-ul').innerHTML; // 상품 목록

            // product-buy에 있는 정보 업데이트
            const productBuy = document.querySelector('.product-buy');
			
            const buyInfoTitle = productBuy.querySelector('.product-title b');
            const buyInfoUl = productBuy.querySelector('.product-ul');
			
			const buyPrice = productBuy.querySelector('.product-bottom p');
			const buttonPrice = productBuy.querySelector('.button-price');
			
			
            // 제목 변경
            buyInfoTitle.textContent = productTitle;

            // ul 내용 변경
            buyInfoUl.innerHTML = productUl;
			
			// 금액 변경
			buyPrice.textContent = productPrice;
			
			// 버튼 금액 변경
			buttonPrice.textContent = productPrice;
            // product-buy를 flex로 표시
            productBuy.style.display = 'flex';
        });
    });
});

document.addEventListener('DOMContentLoaded', function() {
    const deleteButton = document.querySelector('#delete-button');
    const productBuy = document.querySelector('.product-buy');

    deleteButton.addEventListener('click', function() {
        // product-buy 요소를 숨김
        productBuy.style.display = 'none';
    });
});

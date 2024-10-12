document.addEventListener('DOMContentLoaded', function() {
    const donateInfoList = document.querySelectorAll('.donate-information');
    const productBuy = document.querySelector('.product-buy');
    let unitPrice = 0; // 전역 변수를 사용하여 동적으로 업데이트

    donateInfoList.forEach(function(donateInfo) {
        donateInfo.addEventListener('click', function() {
            // donate-information의 금액 가져오기
            unitPrice = parseInt(donateInfo.querySelector('b').textContent.replace(/[^0-9]/g, '')); // 새로운 금액 가져오기
            const productTitle = donateInfo.querySelector('.product-information').childNodes[0].textContent; // 상품 제목
            const productUl = donateInfo.querySelector('.product-ul').innerHTML; // 상품 목록

            // product-buy에 있는 정보 업데이트
            const buyInfoTitle = productBuy.querySelector('.product-title b');
            const buyInfoUl = productBuy.querySelector('.product-ul');
            const buyPrice = productBuy.querySelector('.product-bottom p');
            const buttonPrice = productBuy.querySelector('.button-price');

            // 제목 변경
            buyInfoTitle.textContent = productTitle;

            // ul 내용 변경
            buyInfoUl.innerHTML = productUl;

            // 금액 업데이트 (기본 수량 1로 설정)
            currentValue = 1;
            input.value = currentValue;
            updatePrice();  // 클릭 시마다 가격을 새로 갱신

            // product-buy를 flex로 표시
            productBuy.style.display = 'flex';
        });
    });

    const decreaseButton = document.getElementById('decrease');
    const increaseButton = document.getElementById('increase');
    const input = document.querySelector('.stepper-input');
    const priceDisplay = document.querySelector('.product-bottom p');  // <p> 가격
    const buttonPriceDisplay = document.querySelector('.button-price');  // <label> 가격

    let currentValue = parseInt(input.value);

    // 가격 업데이트 함수
    function updatePrice() {
        const totalPrice = unitPrice * currentValue;
        priceDisplay.textContent = `${totalPrice.toLocaleString()}원`;  // 가격 표시 갱신
        buttonPriceDisplay.textContent = `${totalPrice.toLocaleString()}원`;  // 버튼 가격 갱신
    }

    // 초기 가격 설정
    updatePrice();

    decreaseButton.addEventListener('click', () => {
        if (currentValue > 1) {
            currentValue--;
            input.value = currentValue;
            increaseButton.disabled = false;
            updatePrice();  // 가격 갱신
        }
        if (currentValue === 1) {
            decreaseButton.disabled = true;
        }
    });

    increaseButton.addEventListener('click', () => {
        currentValue++;
        input.value = currentValue;
        decreaseButton.disabled = false;
        updatePrice();  // 가격 갱신
    });
});

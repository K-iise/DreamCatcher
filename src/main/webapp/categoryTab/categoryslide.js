document.addEventListener('DOMContentLoaded', function() {
    let scrollAmount = 0;
    const scrollStep = 150; // 스크롤할 양 (아이템 너비에 맞추기)
    const container = document.querySelector('.swiper-wrapper');

    window.scrollLeftItems = function() {
        // 현재 스크롤 위치가 0보다 작을 경우에만 스크롤
        if (scrollAmount < 0) {
            scrollAmount += scrollStep;
            container.style.transform = `translateX(${scrollAmount}px)`;
        }
    };

    window.scrollRightItems = function() {
        // 현재 스크롤 위치가 최대 너비보다 작을 경우에만 스크롤
        const maxScroll = -(container.scrollWidth - container.clientWidth);
        if (scrollAmount > maxScroll) {
            scrollAmount -= scrollStep;
            container.style.transform = `translateX(${scrollAmount}px)`;
        }
    };
});
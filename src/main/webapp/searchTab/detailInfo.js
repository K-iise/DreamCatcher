document.addEventListener('DOMContentLoaded', function () {
    const categoryLabel = document.querySelector('.category-label'); // 첫 번째 카테고리 라벨을 선택
    const depth1Wrapper = document.querySelector('.depth1-wrapper');

    let isHovering = false;

    // 마우스가 categoryLabel에 들어갔을 때
    categoryLabel.addEventListener('mouseenter', function () {
        depth1Wrapper.style.display = 'flex'; // 상세 카테고리 보이기
        isHovering = true;
    });

    // 마우스가 depth1Wrapper에 들어갔을 때
    depth1Wrapper.addEventListener('mouseenter', function () {
        isHovering = true;
    });

    // 마우스가 categoryLabel에서 나갔을 때
    categoryLabel.addEventListener('mouseleave', function () {
        if (!isHovering) {
            depth1Wrapper.style.display = 'none'; // 상세 카테고리 숨기기
        }
    });

    // 마우스가 depth1Wrapper에서 나갔을 때
    depth1Wrapper.addEventListener('mouseleave', function () {
        isHovering = false;
        depth1Wrapper.style.display = 'none'; // 상세 카테고리 숨기기
    });
});

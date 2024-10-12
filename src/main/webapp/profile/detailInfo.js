//JavaScript 코드를 문서의 끝에 추가
document.addEventListener('DOMContentLoaded', function () {
    const categoryLabel = document.getElementById('category-label');
    const depth1Wrapper = document.querySelector('.depth1-wrapper');
    
    let isHovering = false; // 카테고리와 상세 카테고리 영역에 마우스가 있는지 여부

    // 카테고리 라벨에 마우스 오버 이벤트 추가
    categoryLabel.addEventListener('mouseenter', function () {
        depth1Wrapper.style.display = 'flex'; // 상세 카테고리 보이기
        isHovering = true;
    });

    // 상세 카테고리 영역에 마우스 오버 이벤트 추가
    depth1Wrapper.addEventListener('mouseenter', function () {
        isHovering = true; // 상세 카테고리 영역에 마우스가 있음
    });

    // 마우스가 카테고리 라벨이나 상세 카테고리에서 벗어났을 때
    categoryLabel.addEventListener('mouseleave', function () {
        if (!isHovering) {
            depth1Wrapper.style.display = 'none'; // 상세 카테고리 숨기기
        }
    });

    depth1Wrapper.addEventListener('mouseleave', function () {
        isHovering = false; // 마우스가 상세 카테고리 영역에서 벗어났음
        depth1Wrapper.style.display = 'none'; // 상세 카테고리 숨기기
    });
});
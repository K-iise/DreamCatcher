document.addEventListener('DOMContentLoaded', function() {
    let scrollAmount = 0;
    const scrollStep = 150; // 스크롤할 양 (아이템 너비에 맞추기)
    const container = document.querySelector('.swiper-wrapper');

    window.scrollLeftItems = function() {
        // 스크롤 위치가 0보다 크면 멈추기
        if (scrollAmount < 0) {
            scrollAmount += scrollStep;
            container.style.transform = `translateX(${scrollAmount}px)`;
        } else {
            // 스크롤 위치가 0이상이면 0으로 조정
            scrollAmount = 0;
            container.style.transform = `translateX(${scrollAmount}px)`;
        }
    };

    window.scrollRightItems = function() {
        // 최대 스크롤 위치 계산
        const maxScroll = -(container.scrollWidth - container.clientWidth);
        
        // 현재 스크롤 위치가 최대 스크롤보다 작을 경우에만 스크롤
        if (scrollAmount > maxScroll) {
            scrollAmount -= scrollStep;
            container.style.transform = `translateX(${scrollAmount}px)`;
        } else {
            // 스크롤 위치가 최대 범위를 넘어가지 않도록 조정
            scrollAmount = maxScroll;
            container.style.transform = `translateX(${scrollAmount}px)`;
        }
    };
});

function filterProjects() {
    const dropdown = document.getElementById("add-sort");
    const selectedValue = dropdown.value;
    const projects = document.querySelectorAll(".funding-project");

    projects.forEach(project => {
        const percentage = parseFloat(project.getAttribute("data-percentage"));
        
        if (selectedValue === "added") {
            project.style.display = "block"; // 전체보기
        } else if (selectedValue === "less_than_75" && percentage <= 75) {
            project.style.display = "block"; // 75% 이하
        } else if (selectedValue === "between_75_and_100" && percentage > 75 && percentage < 100) {
            project.style.display = "block"; // 75% ~ 100%
        } else if (selectedValue === "more_than_100" && percentage >= 100) {
            project.style.display = "block"; // 100% 이상
        } else {
            project.style.display = "none"; // 필터에 맞지 않으면 숨김
        }
    });
}
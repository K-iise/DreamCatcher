// 카테고리 색상 변경.
function highlight(selectedLabel, contentId) {
    // 모든 프로필 라벨 색상 초기화
    const labels = document.querySelectorAll('.funding-label');
    labels.forEach(label => {
        label.classList.remove('active');
    });

    // 선택된 라벨 색상 변경
    selectedLabel.classList.add('active');

    // 모든 콘텐츠 숨기기
    const contents = document.querySelectorAll('.tab-content');
    contents.forEach(content => {
        content.style.display = 'none';
    });

    // 선택된 콘텐츠만 보이기
    document.getElementById(contentId).style.display = 'block';
}
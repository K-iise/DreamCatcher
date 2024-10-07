function toggleDropdown() {
    var dropdownContent = document.querySelector('.dropdown-content');
    // 드롭다운의 display 속성을 토글
    if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
    } else {
        dropdownContent.style.display = "block";
    }
}

// 클릭 외부 영역을 클릭 시 드롭다운을 닫기 위한 추가 코드
window.onclick = function(event) {
    if (!event.target.matches('.dropbtn') && !event.target.closest('.dropdown')) {
        var dropdowns = document.getElementsByClassName("dropdown-content");
        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.style.display === 'block') {
                openDropdown.style.display = 'none';
            }
        }
    }
}
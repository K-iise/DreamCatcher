function toggleCommentDropdown(event) {
    // 드롭다운의 display 속성을 토글
    var dropdownContent = document.querySelector('.dropdown-comment');

    // display 속성을 확인하기 전에 초기 상태를 정의해줍니다.
    if (dropdownContent.style.display === "" || dropdownContent.style.display === "none") {
        dropdownContent.style.display = "block";
    } else {
        dropdownContent.style.display = "none";
    }

    // 클릭한 요소가 드롭다운을 닫지 않도록 event.stopPropagation() 사용
    event.stopPropagation();
}

// 클릭 외부 영역을 클릭 시 드롭다운을 닫기 위한 추가 코드
window.onclick = function(event) {
    if (!event.target.matches('.dropbtn') && !event.target.closest('.dropdown-comment')) {
        var dropdowns = document.getElementsByClassName("dropdown-comment");
        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.style.display === 'block') {
                openDropdown.style.display = 'none';
            }
        }
    }
}

function editComment() {
    alert("수정 기능");
}

function deleteComment() {
    alert("삭제 기능");
}

function replyToComment() {
    alert("답변 기능");
}

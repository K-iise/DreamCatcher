function toggleCommentDropdown(event) {
    // 클릭한 버튼의 위치를 기준으로 드롭다운을 표시
    var dropdown = event.target.closest('#comment-option').querySelector('.dropdown-comment'); 
    var allDropdowns = document.querySelectorAll('.dropdown-comment');

    // 모든 드롭다운 숨기기
    allDropdowns.forEach(function(dd) {
        if (dd !== dropdown) {
            dd.style.display = 'none';
        }
    });

    // 드롭다운 토글: 현재 클릭한 드롭다운의 표시 상태 변경
    dropdown.style.display = (dropdown.style.display === 'block') ? 'none' : 'block';
}

// 클릭 외부 영역을 클릭 시 드롭다운을 닫기 위한 추가 코드
window.onclick = function(event) {
    // 드롭다운 버튼과 드롭다운 영역 외부 클릭 시 드롭다운 닫기
    if (!event.target.matches('.dropbtn') && !event.target.closest('#comment-option')) {
        var dropdowns = document.querySelectorAll(".dropdown-comment");
        dropdowns.forEach(dd => {
            dd.style.display = 'none';
        });
    }
}

function editComment() {
    alert("수정 기능");
}

function deleteComment(commentNum, fundingNum) {
    if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
        var form = document.createElement("form");
        form.method = "post";
        form.action = "commentDelete.jsp"; // 삭제 요청을 처리할 JSP 파일

        // 댓글 번호와 fundingNum을 hidden 필드로 추가
        var input1 = document.createElement("input");
        input1.type = "hidden";
        input1.name = "comment_num";
        input1.value = commentNum;
        form.appendChild(input1);

        var input2 = document.createElement("input");
        input2.type = "hidden";
        input2.name = "fundingNum";
        input2.value = fundingNum;
        form.appendChild(input2);

        document.body.appendChild(form); // 폼을 문서에 추가
        form.submit(); // 폼 제출
    }
}

function replyToComment() {
    alert("답변 기능");
}

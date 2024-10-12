// 수정 버튼
function editComment(event) {
    console.log(event); // 이벤트 객체 확인
    const commentDiv = event.target.closest('#comments'); // 클릭한 댓글의 div 찾기

    if (commentDiv) {
        const commentText = commentDiv.querySelector('#comment-text'); // 댓글 텍스트
        const inputTextarea = commentDiv.querySelector('.input_textarea'); // 텍스트 영역
        const saveButton = commentDiv.querySelector('.save-button'); // 저장 버튼

        // 댓글 텍스트와 입력 영역의 가시성 전환
        if (commentText) {
            if (commentText.style.display !== 'none') {
                commentText.style.display = 'none'; // 댓글 텍스트 숨기기
                if (inputTextarea) inputTextarea.style.display = 'block'; // 텍스트 영역 보이기
                if (saveButton) saveButton.style.display = 'block'; // 저장 버튼 보이기
            }
        } else {
            console.error('댓글 텍스트가 없습니다.'); // 오류 메시지 출력
        }
    } else {
        console.error('댓글 프로필을 찾을 수 없습니다.'); // 오류 메시지 출력
    }
}

// 저장 버튼 이벤트
function saveComment(event) {
    const commentDiv = event.target.closest('#comments'); // 클릭한 댓글의 div 찾기
	console.log(commentDiv); // 이벤트 객체 확인
    if (commentDiv) {
        const commentText = commentDiv.querySelector('#comment-text'); // 댓글 텍스트
        const inputTextarea = commentDiv.querySelector('.input_textarea'); // 텍스트 영역
        const saveButton = commentDiv.querySelector('.save-button'); // 저장 버튼

        // 댓글 텍스트 업데이트
        if (inputTextarea) {
            commentText.textContent = inputTextarea.value; // 텍스트 영역의 값을 댓글 텍스트로 설정
        }

        // 댓글 텍스트와 입력 영역의 가시성 전환
        if (commentText) {
            commentText.style.display = 'block'; // 댓글 텍스트 보이기
        }
        if (inputTextarea) {
            inputTextarea.style.display = 'none'; // 텍스트 영역 숨기기
        }
        if (saveButton) {
            saveButton.style.display = 'none'; // 저장 버튼 숨기기
        }
    } else {
        console.error('댓글 프로필을 찾을 수 없습니다.'); // 오류 메시지 출력
    }
}
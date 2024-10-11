function replyToComment(event) {
    console.log(event); // 이벤트 객체 확인
    const commentDiv = event.target.closest('.comment-engratf'); // 클릭한 댓글의 div 찾기
    
    if (commentDiv) {
        const commentReply = commentDiv.querySelector('.comment-reply'); // 답변 div 찾기
        
        if (commentReply) {
            // 답변 div의 스타일을 설정
            if (commentReply.style.display === 'none' || commentReply.style.display === '') {
                commentReply.style.display = 'flex'; // 'flex'로 설정
                
                const inputTextarea = commentReply.querySelector('.input_textarea'); // 텍스트 영역
                const saveButton = commentReply.querySelector('.save-button'); // 저장 버튼
                const commentText = commentReply.querySelector('#comment-text'); // 댓글 텍스트
                
                commentText.style.display = 'none'; // 댓글 텍스트 숨기기
                inputTextarea.style.display = 'block'; // 텍스트 영역 보이기
                saveButton.style.display = 'block'; // 저장 버튼 보이기
            } else {
                commentReply.style.display = 'none'; // 답변 div를 숨길 경우 추가
                const inputTextarea = commentReply.querySelector('.input_textarea'); // 텍스트 영역
                const saveButton = commentReply.querySelector('.save-button'); // 저장 버튼
                const commentText = commentReply.querySelector('#comment-text'); // 댓글 텍스트
                
                commentText.style.display = 'block'; // 댓글 텍스트 보이기
                inputTextarea.style.display = 'none'; // 텍스트 영역 숨기기
                saveButton.style.display = 'none'; // 저장 버튼 숨기기
            }
        } else {
            console.error('답변 div가 없습니다.'); // 오류 메시지 출력
        }
    } else {
        console.error('답변 프로필을 찾을 수 없습니다.'); // 오류 메시지 출력
    }
}


// 저장 버튼 이벤트
function saveReply(event) {
    const commentDiv = event.target.closest('.comment-engratf'); // 클릭한 댓글의 div 찾기
	
    if (commentDiv) {
		
		const commentReply = commentDiv.querySelector('.comment-reply'); // 답변 div 찾기

	
        const commentText = commentReply.querySelector('#comment-text'); // 댓글 텍스트
        const inputTextarea = commentReply.querySelector('.input_textarea'); // 텍스트 영역
        const saveButton = commentReply.querySelector('.save-button'); // 저장 버튼

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

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

function saveComment(event) {
    const commentDiv = event.target.closest('#comments'); // 클릭한 댓글의 div 찾기
    if (commentDiv) {
        const commentText = commentDiv.querySelector('#comment-text'); // 댓글 텍스트
        const inputTextarea = commentDiv.querySelector('.input_textarea'); // 텍스트 영역
        const commentNumInput = commentDiv.querySelector('.comment_num'); // 댓글 번호
        const saveButton = commentDiv.querySelector('.save-button'); // 저장 버튼

        // 댓글 텍스트 업데이트
        if (inputTextarea && commentNumInput) {
            const commentNum = commentNumInput.value; // 댓글 번호
            const updatedComment = inputTextarea.value; // 수정된 댓글 내용

            // fundingNum 값을 가져옴
            const fundingNum = commentDiv.querySelector('input[name="fundingNum"]').value;

            // 서버에 수정 요청
            const form = document.createElement("form");
            form.method = "post";
            form.action = "commentUpdate.jsp"; // 댓글 업데이트 요청을 처리할 JSP 파일

            // 댓글 번호와 수정된 내용을 hidden 필드로 추가
            const inputCommentNum = document.createElement("input");
            inputCommentNum.type = "hidden";
            inputCommentNum.name = "comment_num";
            inputCommentNum.value = commentNum;
            form.appendChild(inputCommentNum);

            const inputCommentCon = document.createElement("input");
            inputCommentCon.type = "hidden";
            inputCommentCon.name = "comment_con";
            inputCommentCon.value = updatedComment;
            form.appendChild(inputCommentCon);

            // fundingNum을 hidden 필드로 추가
            const inputFundingNum = document.createElement("input");
            inputFundingNum.type = "hidden";
            inputFundingNum.name = "fundingNum"; // 이름은 JSP에서 사용한 것과 일치해야 함
            inputFundingNum.value = fundingNum;
            form.appendChild(inputFundingNum);

            document.body.appendChild(form); // 폼을 문서에 추가
            form.submit(); // 폼 제출

            // UI 업데이트
            commentText.textContent = updatedComment; // 댓글 텍스트를 수정된 내용으로 업데이트
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
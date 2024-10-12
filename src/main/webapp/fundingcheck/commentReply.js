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


function saveReply(event) {
    const commentDiv = event.target.closest('.comment-engratf'); // 클릭한 댓글의 div 찾기

    if (commentDiv) {
        const commentReply = commentDiv.querySelector('.comment-reply'); // 답변 div 찾기
        const inputTextarea = commentReply.querySelector('.input_textarea'); // 텍스트 영역
        const commentNumInput = commentDiv.querySelector('.comment_num'); // 댓글 번호
        const fundingNumInput = document.querySelector('input[name="fundingNum"]'); // fundingNum 가져오기

        // 댓글 번호, 답변 내용, fundingNum 값을 가져오기
        if (inputTextarea && commentNumInput && fundingNumInput) {
            const commentNum = commentNumInput.value; // 댓글 번호
            const answerContent = inputTextarea.value; // 답변 내용
            const fundingNum = fundingNumInput.value; // fundingNum 값

            // 서버에 답변 요청을 위한 폼 생성
            const form = document.createElement("form");
            form.method = "post";
            form.action = "commentAnsInsert.jsp"; // 답변 저장 요청을 처리할 JSP 파일

            // 댓글 번호와 답변 내용, fundingNum을 hidden 필드로 추가
            const inputCommentNum = document.createElement("input");
            inputCommentNum.type = "hidden";
            inputCommentNum.name = "comment_num"; // JSP에서 사용할 이름
            inputCommentNum.value = commentNum;
            form.appendChild(inputCommentNum);

            const inputAnswer = document.createElement("input");
            inputAnswer.type = "hidden";
            inputAnswer.name = "comment_ans"; // JSP에서 사용할 이름
            inputAnswer.value = answerContent;
            form.appendChild(inputAnswer);

            const inputFundingNum = document.createElement("input");
            inputFundingNum.type = "hidden";
            inputFundingNum.name = "fundingNum"; // JSP에서 사용할 이름
            inputFundingNum.value = fundingNum;
            form.appendChild(inputFundingNum);

            document.body.appendChild(form); // 폼을 문서에 추가
            form.submit(); // 폼 제출

            // UI 업데이트
            const commentText = commentReply.querySelector('#comment-text'); // 댓글 텍스트
            commentText.textContent = answerContent; // 댓글 텍스트를 수정된 내용으로 업데이트
            commentText.style.display = 'block'; // 댓글 텍스트 보이기
            inputTextarea.style.display = 'none'; // 텍스트 영역 숨기기
            const saveButton = commentReply.querySelector('.save-button'); // 저장 버튼
            saveButton.style.display = 'none'; // 저장 버튼 숨기기
        }
    } else {
        console.error('댓글 프로필을 찾을 수 없습니다.'); // 오류 메시지 출력
    }
}

function deleteReply(commentNum, fundingNum) {
    if (confirm('정말 답변을 삭제하시겠습니까?')) {
        // 서버에 답변 삭제 요청을 위한 폼 생성
        const form = document.createElement("form");
        form.method = "post";
        form.action = "commentAnsDelete.jsp"; // 답변 삭제 요청을 처리할 JSP 파일

        // 댓글 번호와 fundingNum을 hidden 필드로 추가
        const inputCommentNum = document.createElement("input");
        inputCommentNum.type = "hidden";
        inputCommentNum.name = "comment_num"; // JSP에서 사용할 이름
        inputCommentNum.value = commentNum;
        form.appendChild(inputCommentNum);

        const inputFundingNum = document.createElement("input");
        inputFundingNum.type = "hidden";
        inputFundingNum.name = "fundingNum"; // JSP에서 사용할 이름
        inputFundingNum.value = fundingNum;
        form.appendChild(inputFundingNum);

        document.body.appendChild(form); // 폼을 문서에 추가
        form.submit(); // 폼 제출
    }
}
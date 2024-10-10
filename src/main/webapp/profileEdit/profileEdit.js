document.addEventListener('DOMContentLoaded', function() {
    // 사용자 이름 편집 상자 관련 요소들 선택
    const userNameChangeButton = document.querySelector('.edit-box:nth-child(2) .change-button');
    const userNameInputText = document.querySelector('.edit-box:nth-child(2) .input_text');
    const userNameSaveButton = document.querySelector('.edit-box:nth-child(2) .save-button');
    const userNameDisplay = document.querySelector('.edit-box:nth-child(2) .user-name');

    // 사용자 이름 변경 버튼 클릭 시 이벤트 처리
    userNameChangeButton.addEventListener('click', function() {
        if (userNameChangeButton.textContent === '변경') {
            userNameChangeButton.textContent = '취소';
            userNameInputText.style.display = 'flex';
            userNameSaveButton.style.display = 'flex';
            userNameDisplay.style.display = 'none'; // 사용자 이름 텍스트 숨기기
        } else {
            userNameChangeButton.textContent = '변경';
            userNameInputText.style.display = 'none';
            userNameSaveButton.style.display = 'none';
            userNameDisplay.style.display = 'block'; // 이전 사용자 이름 텍스트 보이기
        }
    });

    // 사용자 이름 저장 버튼 클릭 시 이벤트 처리
    userNameSaveButton.addEventListener('click', function() {
        const newValue = userNameInputText.value.trim(); // 입력값 가져오기 (trim()으로 앞뒤 공백 제거)

        if (newValue !== '') {
            userNameDisplay.textContent = newValue; // 사용자 이름 표시 업데이트
        }

        userNameInputText.style.display = 'none'; // 입력 필드 숨기기
        userNameSaveButton.style.display = 'none'; // 저장 버튼 숨기기
        userNameChangeButton.textContent = '변경'; // 변경 버튼 텍스트 원래대로 되돌리기
        userNameDisplay.style.display = 'block'; // 사용자 이름 텍스트 보이기
    });


    // 프로필 사진 편집 상자 관련 요소들 선택
    const profilePhotoChangeButton = document.querySelector('.edit-box:nth-child(1) .change-button');
    const profilePhotoSaveButton = document.querySelector('.edit-box:nth-child(1) .save-button');

    // 프로필 사진 변경 버튼 클릭 시 이벤트 처리
    profilePhotoChangeButton.addEventListener('click', function() {
        // 여기에 프로필 사진 변경 관련 동작을 추가할 수 있습니다.
        // 현재 문제에서는 사용자 이름 부분에 집중하여 코드를 작성하였습니다.
    });
    
    // 소개 글 편집 상자 관련 요소들 선택
    const introduceChangeButton = document.querySelector('.edit-box:nth-child(3) .change-button');
    const introduceUserNameDisplay = document.querySelector('.edit-box:nth-child(3) .user-name');
    const introduceInputTextarea = document.querySelector('.edit-box:nth-child(3) .input_textarea');
    const introduceSaveButton = document.querySelector('.edit-box:nth-child(3) .save-button');
    
    introduceChangeButton.addEventListener('click', function() {
        if (introduceChangeButton.textContent === '변경') {
        	introduceChangeButton.textContent = '취소';
            introduceInputTextarea.style.display = 'flex';
            introduceSaveButton.style.display = 'flex';
            introduceUserNameDisplay.style.display = 'none'; // 소개 텍스트 숨기기
        } else {
        	introduceChangeButton.textContent = '변경';
            introduceInputTextarea.style.display = 'none';
            introduceSaveButton.style.display = 'none';
            introduceUserNameDisplay.style.display = 'block'; // 소개 텍스트 숨기기

        }
	});
    
});
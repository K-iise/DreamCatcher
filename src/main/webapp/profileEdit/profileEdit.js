document.addEventListener('DOMContentLoaded', function() {

	// 프로필 사진 편집 상자 관련 요소들 선택
	const profilePhotoChangeButton = document.querySelector('.edit-box:nth-child(1) .change-button');
	const profilePhotoInfo = document.querySelector('.edit-box:nth-child(1) .image-info');
	const profilePhotoInput = document.getElementById('profilePhotoInput');
	const profileImage = document.getElementById('profileImage');
	const profilePhotoSaveButton = document.querySelector('.edit-box:nth-child(1) .save-button');

	// 프로필 사진 변경 버튼 클릭 시 이벤트 처리
	profilePhotoChangeButton.addEventListener('click', function() {
		if (profilePhotoChangeButton.textContent === '변경') {
			profilePhotoChangeButton.textContent = '취소';
			profilePhotoInfo.style.display = 'flex';
			profilePhotoSaveButton.style.display = 'flex';
		}
		else {
			profilePhotoChangeButton.textContent = '변경';
			profilePhotoInfo.style.display = 'none';
			profilePhotoSaveButton.style.display = 'none';
		}
	});

	// 파일 선택 시 미리보기 이미지 업데이트
	profilePhotoInput.addEventListener('change', function() {
		const file = profilePhotoInput.files[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				profileImage.src = e.target.result; // 미리보기 이미지 업데이트
			}
			reader.readAsDataURL(file);
		}
	});

	// 저장 버튼 클릭 시 이미지 업로드 처리 (여기서는 간단한 예시로, 실제로는 서버에 업로드하는 코드를 추가해야 함)
	profilePhotoSaveButton.addEventListener('click', function() {
		// 이미지 업로드 처리
		alert("프로필 사진이 저장되었습니다!"); // 실제 업로드 로직은 필요에 따라 추가
	});




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

	introduceSaveButton.addEventListener('click', function() {

		const newValue = introduceInputTextarea.value;

		if (newValue !== '') {
			introduceUserNameDisplay.textContent = newValue; // 사용자 이름 표시 업데이트

			introduceUserNameDisplay.style.color = 'black';

			introduceChangeButton.textContent = '변경';
			introduceInputTextarea.style.display = 'none';
			introduceSaveButton.style.display = 'none';
			introduceUserNameDisplay.style.display = 'block'; // 소개 텍스트 보이기
		}

		else {
			introduceUserNameDisplay.textContent = "등록된 소개가 없습니다.";

			introduceUserNameDisplay.style.color = 'rgb(158, 158, 158)';
			introduceChangeButton.textContent = '변경';
			introduceInputTextarea.style.display = 'none';
			introduceSaveButton.style.display = 'none';
			introduceUserNameDisplay.style.display = 'block'; // 소개 텍스트 보이기
		}
	});

	// 사용자 이름 편집 상자 관련 요소들 선택
	const userPhoneNumberChangeButton = document.querySelector('.edit-box:nth-child(4) .change-button');
	const userPhonNumberInputText = document.querySelector('.edit-box:nth-child(4) .input_text');
	const userPhoneNumberSaveButton = document.querySelector('.edit-box:nth-child(4) .save-button');
	const userPhoneNumberDisplay = document.querySelector('.edit-box:nth-child(4) .user-name');

	// 사용자 이름 변경 버튼 클릭 시 이벤트 처리
	userPhoneNumberChangeButton.addEventListener('click', function() {
		if (userPhoneNumberChangeButton.textContent === '변경') {
			userPhoneNumberChangeButton.textContent = '취소';
			userPhonNumberInputText.style.display = 'flex';
			userPhoneNumberSaveButton.style.display = 'flex';
			userPhoneNumberDisplay.style.display = 'none'; // 사용자 이름 텍스트 숨기기
		} else {
			userPhoneNumberChangeButton.textContent = '변경';
			userPhonNumberInputText.style.display = 'none';
			userPhoneNumberSaveButton.style.display = 'none';
			userPhoneNumberDisplay.style.display = 'block'; // 이전 사용자 이름 텍스트 보이기
		}
	});

	// 사용자 이름 저장 버튼 클릭 시 이벤트 처리
	userPhoneNumberSaveButton.addEventListener('click', function() {
		const newValue = userPhonNumberInputText.value.trim(); // 입력값 가져오기 (trim()으로 앞뒤 공백 제거)

		if (newValue !== '') {
			userPhoneNumberDisplay.textContent = newValue; // 사용자 이름 표시 업데이트

			userPhoneNumberDisplay.style.color = 'black';

			userPhonNumberInputText.style.display = 'none'; // 입력 필드 숨기기
			userPhoneNumberSaveButton.style.display = 'none'; // 저장 버튼 숨기기
			userPhoneNumberChangeButton.textContent = '변경'; // 변경 버튼 텍스트 원래대로 되돌리기
			userPhoneNumberDisplay.style.display = 'block'; // 사용자 이름 텍스트 보이기
		}

		else {

			userPhoneNumberDisplay.textContent = "등록된 연락처가 없습니다."

			userPhoneNumberDisplay.style.color = 'rgb(158, 158, 158)';

			userPhonNumberInputText.style.display = 'none'; // 입력 필드 숨기기
			userPhoneNumberSaveButton.style.display = 'none'; // 저장 버튼 숨기기
			userPhoneNumberChangeButton.textContent = '변경'; // 변경 버튼 텍스트 원래대로 되돌리기
			userPhoneNumberDisplay.style.display = 'block'; // 사용자 이름 텍스트 보이기
		}

	});




});
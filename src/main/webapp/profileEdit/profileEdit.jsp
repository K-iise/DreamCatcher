<%@page import="java.nio.file.Paths"%>
<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>


<%
request.setCharacterEncoding("UTF-8");
String user_id = (String) session.getAttribute("idKey");
String selectedId = request.getParameter("selectedid");
String selectuserId = selectedId;
String myId = user_id;
if (request.getParameter("userId") != null) {
	selectuserId = request.getParameter("userId");
}

usersMgr uMgr = new usersMgr();
buyRecordMgr brMgr = new buyRecordMgr();
alarmMgr aMgr = new alarmMgr();
createFundingMgr cfMgr = new createFundingMgr();

usersBean ubean = uMgr.oneUserList(selectuserId);
usersBean mybean = uMgr.oneUserList(myId);

if (ubean.getUser_image() == null || ubean.getUser_image().equals("")) {

	ubean.setUser_image("image/guest.png");

}

if (mybean.getUser_image() == null || mybean.getUser_image().equals("")) {

	mybean.setUser_image("image/guest.png");

}

String action = request.getParameter("Action");
System.out.println("action: " + action); // 디버깅 로그
String Data = request.getParameter("Data");
System.out.println("Data: " + Data); // 디버깅 로그

if ("submit".equals(action)) {
	if("name".equals(Data)){
		
		String name = request.getParameter("name");
		System.out.println("name: " + name);
		mybean.setUser_name(name);
		
	}else if ("info".equals(Data)){
		
		String info = request.getParameter("info");
		System.out.println("info: " + info);
		mybean.setUser_info(info);
		
	}else if ("phone".equals(Data)){
		
		String phone = request.getParameter("phone");
		System.out.println("phone: " + phone);
		mybean.setUser_phone(phone);
		
	}else if ("address".equals(Data)){
		
		String address = request.getParameter("address");
		System.out.println("address: " + address);
		mybean.setUser_address(address);
		
	}else if ("profilePhotoInput".equals(Data)){
		
	    Part profilePhotoInput = request.getPart("profilePhotoInput");
	    System.out.println("profilePhotoInput: " + profilePhotoInput);
	
		if (profilePhotoInput != null && profilePhotoInput.getSize() > 0) {
	        String fileName = extractFileName(profilePhotoInput);

	        // 저장할 실제 서버 경로 설정
	        String uploadPath = getServletContext().getRealPath("/userimage");
	        File uploadDir = new File(uploadPath);

	        // 디렉터리가 없으면 생성
	        if (!uploadDir.exists()) {
	            uploadDir.mkdir();
	        }

	        // 저장할 경로 및 파일 이름 생성
	        String filePath = uploadPath + File.separator + fileName;

	        System.out.println("Upload Path: " + uploadPath);  // 경로 출력
	        System.out.println("File Path: " + filePath);  // 파일 경로 출력

	        // 파일 저장
	        profilePhotoInput.write(filePath);

	        // 파일 경로를 데이터베이스에 저장 
	        String relativePath = request.getContextPath() + "/userimage/" + fileName;

	        mybean.setUser_image(relativePath);
	    }
		
	}

    // 데이터베이스에 저장
    uMgr.userUpdate(mybean);  // 데이터 저장

    // 저장이 성공하면 전송된 페이지로 이동

    response.sendRedirect("profileEdit.jsp");
    
}

%>
<%!
private String extractFileName(Part part) {
    String contentDisposition = part.getHeader("content-disposition");
    String[] items = contentDisposition.split(";");
    for (String item : items) {
        if (item.trim().startsWith("filename")) {
            return item.substring(item.indexOf("=") + 2, item.length() - 1);
        }
    }
    return "";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 편집 화면</title>
<style>
</style>
<link href="profileEdit.css" rel="stylesheet">
<script>
        function copyToClipboard() {
            
            navigator.clipboard.writeText(request.getRequestURL().toString()).then(function() {
                alert("링크를 복사했습니다");
            }, function(err) {
                alert("복사 실패: " + err);
            });
        }
        
</script>
<script>
        // 폼 제출을 위한 JavaScript 함수

 function submitForm(Data) {
        // 숨겨진 input에 actionUrl을 설정
        var form = document.getElementById("projectForm");
        var actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "Data";
        actionInput.value = Data;  // 이동할 페이지 경로

        form.appendChild(actionInput);  // 폼에 추가
        form.submit();  // 폼 제출
    }
    
</script>
</head>
<body>
	<header class="title-header">
		<h1>Dream Catcher</h1>
		<div>
			<%
			if (mybean.getUser_id() == null || mybean.getUser_id().equals("")) {
			%>
			<input type="button" class="upload-button"
				onclick="alert('로그인 해주세요');"> <input type="button"
				class="login-button" onclick="location.href='../login/login.jsp';">

			<%
			} else {
			%>

			<%
			if (cfMgr.createFundingCheck(mybean.getUser_id())) {
			%>
			<input type="button" class="upload-button"
				onclick="location.href='../projectUpload/projectBasicinfo.jsp'">
			<%
			} else {
			%>
			<input type="button" class="upload-button"
				onclick="location.href='../projectUpload/projectPlan.jsp'">
			<%
			}
			%>
			<input type="button" class="heart-button"
				onclick="location.href='../interestProject/interestProject.jsp'">
			<%
			if (aMgr.alarmOnOff(mybean.getUser_id())) {
			%>
			<input type="button" class="bell-button2"
				onclick="location.href='../alarm/alarm.jsp';">
			<%
			} else {
			%>
			<input type="button" class="bell-button"
				onclick="location.href='../alarm/alarm.jsp';">
			<%
			}
			%>
			<span class="dropbtn" onclick="toggleDropdown()"> <img
				src='<%=mybean.getUser_image()%>' alt="User Icon"> <b><%=mybean.getUser_name()%></b>
			</span>
		</div>

		<%
		}
		%>
	</header>

	<div class="dropdown-content">
		<a href="../profile/profile.jsp?selectedid=<%=user_id%>">프로필</a> <a
			href="../interestProject/interestProject.jsp">관심프로젝트</a> <a
			href="../alarm/alarm.jsp">알림</a>
			<%if(mybean.getUser_master()==1){ %>
	    <a href="../manager/managerUI.jsp">게시글 관리</a>
	    <%} %>
	     <a href="../logout/logout.jsp">로그아웃</a>
	</div>

	<!-- 카테고리 시작 -->
	<header>
		<label class="category-label" id="category-label"> <img src="image/menubar.png">카테고리
		</label> <label class="category-label" style="cursor:pointer;" onclick="window.location.href='../home/home.jsp'">홈</label> <label onclick="window.location.href='../popularTab/popularTab.jsp'" class="category-label" style="cursor: pointer;">인기</label>
		<label class="category-label">신규</label> <label class="category-label">스토어</label>

		<form method="GET" action="../searchTab/searchTab.jsp">
		    <span class="search-span">
		        <input type="text" class="input_text" name="search" placeholder="검색어를 입력하세요." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
		        <button type="submit"><img alt="searchicon" src="image/searchicon.png" class="input_icon"></button>
		    </span>
		</form>

	</header>
	<!-- 카테고리 끝 -->

	<!-- 상세 카테고리 창 -->
	<div class="cat-container">
			<div class="depth1-wrapper">
				<div class="depth1-group">
					<div class="depth1-item"  onclick="location.href='../categoryTab/categoryTab.jsp'">
						<div class="depth1-icon">
							<svg width="45" height="45" viewBox="0 0 38 38" fill="none"
								xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
									clip-rule="evenodd"
									d="M16.4 9.6H9.6V16.4H16.4V9.6ZM8 8V18H18V8H8Z" fill="#0D0D0D"></path>
                                    <path fill-rule="evenodd"
									clip-rule="evenodd"
									d="M28.4 9.6H21.6V16.4H28.4V9.6ZM20 8V18H30V8H20Z"
									fill="#0D0D0D"></path>
                                    <path fill-rule="evenodd"
									clip-rule="evenodd"
									d="M16.4 21.6H9.6V28.4H16.4V21.6ZM8 20V30H18V20H8Z"
									fill="#0D0D0D"></path>
                                    <path d="M20 20H30V30H20V20Z"
									fill="#FF5757"></path>
                                </svg>
						</div>
						<div class="depth1-text">전체</div>
					</div>
					
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=1'" >
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/board.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">보드게임 · TRPG</div>
					</div>
					
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=2'">
				        <div class="depth1-icon">
				            <img 
				            	src="https://tumblbug-assets.imgix.net/categories/svg/digital-game.svg" 
				            	class="depth1-icon-img">
				        </div>
				        <div class="depth1-text">디지털 게임</div>
				    </div>
				    
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=3'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/comics.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">웹툰 · 만화</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=4'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/webtoon-resource.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">웹툰 리소스</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=5'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/stationary.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">디자인 문구</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=6'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/charactor-goods.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">캐릭터 · 굿즈</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=7'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/home-living.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">홈 · 리빙</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=8'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/tech-electronics.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">테크 · 가전</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=9'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/pet.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">반려동물</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=10'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/food.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">푸드</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=11'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/perfumes-cosmetics.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">향수 · 뷰티</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=12'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/fashion.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">의류</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=13'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/accessories.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">잡화</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=14'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/jewerly.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">주얼리</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=15'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/publishing.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">출판</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=16'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/design.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">디자인</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=17'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/art.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">예술</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=18'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/photography.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">사진</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=19'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/music.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">음악</div>
					</div>
				</div>
				<div class="depth1-group">
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=20'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/film.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">영화 · 비디오</div>
					</div>
					<div class="depth1-item" onclick="location.href='../categoryTab/categoryTab.jsp?category_num=21'">
						<div class="depth1-icon">
							<img
								src="https://tumblbug-assets.imgix.net/categories/svg/performing-art.svg"
								class="depth1-icon-img">
						</div>
						<div class="depth1-text">공연</div>
					</div>
				</div>
			</div>
		</div>
	
	<hr id="default-hr" width="100%" noshade />

	<!-- 프로필 편집 -->
	<div class="profile-edit">
		<h1>설정</h1>
	</div>

	<!-- 프로필 카테고리 시작 -->
	<div style="margin-bottom: 30px;">
		<label class="profile-label">프로필 편집</label>
		<hr id="highlight-hr" width="100%" noshade />
	</div>
	<form id="projectForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="Action" value="submit" >
	<!-- 각 프로필 카테고리 마다 사용될 body. -->
	<div id="content">

		<div id="profile-content" class="tab-content">

			<div class="Edit-Main">

				<!-- 프로필 편집 왼쪽 부분. -->
				<div class="left-section">

					<!-- 프로필 사진 편집. -->
					<div class="edit-box">
						<div class="edit-title">
							<b>프로필 사진</b>
							<button class="change-button" type="button">변경</button>
						</div>
						<div class="image-box">
							<img id="profileImage" name="profileImage" src="<%=mybean.getUser_image()%>"
								alt="Profile Image"
								style="width: 100px; height: 100px; border-radius: 50%;">
							<div class="image-info">
								<label for="profilePhotoInput" class="custom-file-input-label">이미지 파일 업로드</label>
								<input type="file" id="profilePhotoInput" name="profilePhotoInput" accept="image/*"
									class="file-input">
								<p class="user-name"
									style="margin: 8px 0px 0px; color: rgb(109, 109, 109); font-size: 13px; line-height: 20px; letter-spacing: -0.015em;">250
									x 250 픽셀에 최적화되어 있으며, 5MB 이하의 JPG, GIF, PNG 파일을 지원합니다.</p>
							</div>
						</div>
						<button class="save-button" type="button" onclick="submitForm('profilePhotoInput')">저장</button>
					</div>

					<!-- 사용자 이름 편집. -->
					<div class="edit-box">
						<div class="edit-title">
							<b>사용자 이름</b>
							<button class="change-button" type="button">변경</button>
						</div>
						<p class="user-name"  style="margin: 0px;"><%=mybean.getUser_name() %></p>
						<input class="input_text" type="text" inputmode="text" id="name" name="name" value=<%=mybean.getUser_name() %>
							placeholder="이름을 입력해주세요.">
						<button class="save-button" type="button" onclick="submitForm('name')">저장</button>
					</div>

					<!-- 소개 편집 -->
					<div class="edit-box">
						<div class="edit-title">
							<b>소개</b>
							<button class="change-button" type="button">변경</button>
						</div>
						<p class="user-name" 
							style="margin: 0px; color: rgb(158, 158, 158); white-space: pre-wrap;"><%=mybean.getUser_info() %></p>
						<textarea placeholder="자기소개를 입력해주세요." class="input_textarea" id="info" name="info"><%=mybean.getUser_info() %></textarea>
						<button class="save-button" type="button" onclick="submitForm('info')">저장</button>
					</div>

					<!-- 연락처 편집 -->
					<div class="edit-box">
						<div class="edit-title">
							<b>연락처</b>
							<button class="change-button" type="button">변경</button>
						</div>
						<p class="user-name"
							style="margin: 0px; color: rgb(158, 158, 158);"><%=mybean.getUser_phone() %></p>
						<input class="input_text" type="text" inputmode="text" id="phone" name="phone" value=<%=mybean.getUser_phone() %>
							placeholder="휴대폰 번호를 입력해주세요.">
						<button class="save-button" type="button" onclick="submitForm('phone')">저장</button>
					</div>


					<!-- 주소 편집 -->
					<div class="edit-box">
						<div class="edit-title">
							<b>주소</b>
						</div>
						<div id="deliver-detail">
							<div id="deliver-profile">
								
								<p id="deliver-address"><%=mybean.getUser_address() %></p>
							</div>
							<button id="deliver-change" type="button">변경</button>
						</div>
						
					</div>

				</div>

				<!-- 프로필 편집 오른쪽 부분. -->
				<div class="right-section">
					<div class="info-box">
						<b>어떤 정보가 프로필에 공개되나요?</b>
						<p>
						프로필 사진과, 사용자 이름, 소개글, 연락처 , 주소 및 회원님과 관련된 프로젝트 등이 프로필 페이지에 공개 됩니다. <a href="../profile/profile.jsp?userId=<%=mybean.getUser_id()%>">내 프로필 바로가기</a>
						</p>
						
					</div>
				</div>
			</div>

		</div>


	</div>

	<!-- 배송지 추가 모달 -->
	<div id="delivery-modal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<h2>배송지 수정</h2>
			<div id="delivery-form">
				

				<label id="address-name" for="address">주소</label> <input type="text"
					id="address" name="address" placeholder="받는 분의 주소를 입력해주세요." value=<%=mybean.getUser_address() %>>

				<button id="address-add" type="button" onclick="submitForm('address')">수정</button>
			</div>
		</div>
	</div>
	</form>

	<script src="profileEdit.js"></script>
	<script src="detailInfo.js"></script>
	<script src="delivery_modal.js"></script>
	<script src="dropdown.js"></script>
</body>
</html>

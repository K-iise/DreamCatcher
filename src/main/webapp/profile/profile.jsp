<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.usersMgr"%>
<%@ page import="entity.usersBean"%>
<%@ page import="control.followMgr"%>
<%@ page import="entity.followBean"%>
<%@ page import="control.fundingMgr"%>
<%@ page import="entity.fundingBean"%>
<%

usersMgr uMgr = new usersMgr();
followBean fbean = new followBean();
followMgr fMgr = new followMgr();

usersBean ubean = uMgr.oneUserList("aaaa");
usersBean mybean = uMgr.oneUserList("aaa");


if(ubean.getUser_image()==null||ubean.getUser_image().equals("")){
	
	ubean.setUser_image("image/guest.png");
	
}


if(mybean.getUser_image()==null||mybean.getUser_image().equals("")){
	
	mybean.setUser_image("image/guest.png");
	
}

int follower = fMgr.getFollowerCount(ubean.getUser_id());
int following = fMgr.getFollowingCount(ubean.getUser_id());

fundingMgr fdMgr = new fundingMgr();

Vector<fundingBean> fdvlist = fdMgr.fundingListForUserId(ubean.getUser_id());


int fdCount=fdMgr.fundingCount(ubean.getUser_id());




%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 화면</title>
<style>
</style>
<link href="profile.css" rel="stylesheet">
<script>
        function highlight(selectedLabel, contentId) {
            // 모든 프로필 라벨 색상 초기화
            const labels = document.querySelectorAll('.profile-label');
            labels.forEach(label => {
                label.classList.remove('active');
            });

            // 선택된 라벨 색상 변경
            selectedLabel.classList.add('active');

            // 모든 콘텐츠 숨기기
            const contents = document.querySelectorAll('.tab-content');
            contents.forEach(content => {
                content.style.display = 'none';
            });

            // 선택된 콘텐츠만 보이기
            document.getElementById(contentId).style.display = 'block';
        }
</script>
</head>
<body>
	<!-- 상단바 1 -->
	<header class="title-header">
		<h1>Dream Catcher</h1>
		<div>
			<%
			if (mybean.getUser_id() == null || mybean.getUser_id().equals("")) {
			%>
			<input type="button" class="upload-button" onclick=""> <input
				type="button" class="login-button" onclick="">
			<%
			} else {
			%>

			<input type="button" class="upload-button" onclick=""> <input
				type="button" class="heart-button" onclick=""> <input
				type="button" class="bell-button" onclick=""> 
				<span onclick=""> <img src='<%=mybean.getUser_image()%>'> <b><%=mybean.getUser_name()%></b>
			</span>
		</div>

		<%
		}
		%>
	</header>

	<!-- 카테고리 시작 -->
	<header>
		<label class="category-label"><img src="image/menubar.png">카테고리</label>
		<label class="category-label">홈</label> <label class="category-label">인기</label>
		<label class="category-label">신규</label> <label class="category-label">스토어</label>

		<span class="search-span"> <input type="text"
			class="input_text" name="search" placeholder="검색어를 입력하세요."> <img
			alt="searchicon" src="image/searchicon.png" class="input_icon">
		</span>
	</header>
	<!-- 카테고리 끝 -->
	<hr id="default-hr" width="100%" noshade />

	<!-- 프로필 정보 -->
	<div class="profile">
		<img src='<%=ubean.getUser_image() %>' alt="Profile Image">
		<div class="profile-info">
			<b><%=ubean.getUser_name()%></b>
			<div class="profile-detail">
				<div>
					<b>팔로워</b><br>
					<%=follower%>
				</div>
				<div>
					<b>팔로잉</b><br>
					<%=following%>
				</div>
				<div>
					<b>누적 후원자</b><br> 20
				</div>
			</div>
		</div>
		<div class="profile-buttons">
			<!-- 새로운 Flexbox div 추가 -->
			<%
			if (mybean.getUser_id().equals(ubean.getUser_id())) {
			%>
			<input type="button" class="edit-button" onclick="">
			<%
			} else {
			%>
			<input type="button" class="share-button"
				onclick="alert('공유 버튼 클릭!')"> <input type="button"
				class="follow-button" onclick="alert('팔로우 버튼 클릭!')">
			<%
			}
			%>
		</div>
	</div>

	<!-- 프로필 카테고리 시작 -->
	<div>
		<label class="profile-label active"
			onclick="highlight(this, 'profile-content')">프로필</label> <label
			class="profile-label" onclick="highlight(this, 'review-content')">프로젝트
			후기</label> <label class="profile-label"
			onclick="highlight(this, 'project-content')">올린 프로젝트</label> <label
			class="profile-label" onclick="highlight(this, 'followers-content')">팔로워</label>
		<label class="profile-label"
			onclick="highlight(this, 'following-content')">팔로잉</label>
		<hr id="highlight-hr" width="100%" noshade />
	</div>

	<!-- 각 프로필 카테고리 마다 사용될 body. -->
	<div id="content">
		<div id="profile-content" class="tab-content"><%=ubean.getUser_info()%></div>
		<div id="review-content" class="tab-content" style="display: none;">프로젝트 후기 내용</div>
		<div id="project-content" class="tab-content" style="display: none;">
			<div style="margin-left: 20px; margin-top: 20px;"><%=fdCount %>개의 프로젝트가 있습니다.</div>
			<%if(fdCount!=0){ %>
			
    <div id="projects">
    <% for (int i = 0; i < fdCount; i++) { %>
        <div id="upload-project">
            <!-- 프로젝트 사진 -->
            <img src='<%= fdvlist.get(i).getFunding_image() %>'> 
            <!-- 창작자 명 -->
            <a class="creator-name">
                <%= uMgr.oneUserList(fdvlist.get(i).getFunding_user_id()).getUser_name() %>
            </a><br>
            <!-- 제품명 -->
            <label class="product-name">
                <%= fdvlist.get(i).getFunding_title() %>
            </label><br>
            <!-- 진행 정보 -->
            <div class="progress-info">
                <span class="progress-percentage">
                    <%= (int)(((double)fdvlist.get(i).getFunding_nprice() / fdvlist.get(i).getFunding_tprice()) * 100) %> %
                </span> 
                <span class="progress-amount">
                    <%= fdvlist.get(i).getFunding_nprice() %>원
                </span> 
                <span class="progress-time">
                    <%= fdMgr.fundDate(fdvlist.get(i).getFunding_num()) %>일 남음
                </span>
            </div>
            <!-- 진행 바 -->
            <progress id="progress" value="<%= (int)(((double)fdvlist.get(i).getFunding_nprice() / fdvlist.get(i).getFunding_tprice()) * 100) %>" min="0" max="100"></progress>
        </div>
        <% } %>
    </div>

		<%} %>

		<div id="followers-content" class="tab-content" style="display: none;">팔로워
			목록</div>
		<div id="following-content" class="tab-content" style="display: none;">팔로잉
			목록</div>
	</div>

</body>
</html>

<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="control.usersMgr"/>
<jsp:useBean id="login" class="entity.usersBean" scope="session"/>
<jsp:setProperty property="*" name="login"/>
<%
	String url="login.jsp";
	if(request.getParameter("url")!=null&&!request.getParameter("url").equals("null")){
		url=request.getParameter("url");
	}
	
	boolean result = mgr.userCheck(login.getUser_id(), login.getUser_pw());
	//out.print(result);
	String msg = "로그인 실패";
	if(result){
		msg = "로그인 성공"; 
		session.setAttribute("idKey", login.getUser_id());
		session.setAttribute("login", login);
		response.sendRedirect("/DreamCatcher/alarm/alarm.jsp?user_id=" + login.getUser_id());
        return;
	}
%>
<script>er_id());
        return;
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>
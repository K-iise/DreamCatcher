<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="control.usersMgr" />
<jsp:useBean id="bean" class="entity.usersBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
    String userId = request.getParameter("user_id");
    String nationalIdFront = request.getParameter("national_id_number_front");
    String nationalIdBack = request.getParameter("national_id_number_back");

    String resnum = nationalIdFront + "-" + nationalIdBack;

    String pw = mgr.findUserPW(userId, resnum);

    if (pw != null && !pw.isEmpty()) {
    	session.setAttribute("user_id", userId);
    	session.setAttribute("user_resnum", resnum);
        response.sendRedirect("/DreamCatcher/changepassword/changepassword.jsp");
    } else {
        out.println("<script>alert('입력하신 정보와 일치하는 사용자가 없습니다.'); history.back();</script>");
    }
%>
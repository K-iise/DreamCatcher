<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="control.usersMgr" />
<jsp:useBean id="bean" class="entity.usersBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
    String password = request.getParameter("password");
    String chkpassword = request.getParameter("chkpassword");
    String userId = request.getParameter("user_id");
    String userResnum = request.getParameter("user_resnum");

    if (!password.equals(chkpassword)) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
    } else {
        bean.setUser_id(userId);
        bean.setUser_resnum(userResnum);
        bean.setUser_pw(password);

        mgr.updateUserPW(bean);

        out.println("<script>alert('비밀번호가 성공적으로 변경되었습니다.'); location.href='/DreamCatcher/login/login.jsp';</script>");
    }
%>

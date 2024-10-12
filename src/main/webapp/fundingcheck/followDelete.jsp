<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entity.followBean"%>
<%@ page import="control.followMgr"%>

<%
    String follow_set_user_id = request.getParameter("follow_set_user_id");
    String follow_get_user_id = request.getParameter("follow_get_user_id");
    int fundingNum = Integer.parseInt(request.getParameter("fundingNum"));
    
    followBean fBean = new followBean();
    fBean.setFollow_set_user_id(follow_set_user_id);
    fBean.setFollow_get_user_id(follow_get_user_id);

    followMgr fMgr = new followMgr();
    fMgr.followDelete(fBean);

    response.sendRedirect("fundingcheck.jsp?fundingNum=" + fundingNum);
%>

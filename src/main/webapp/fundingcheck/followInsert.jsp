<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entity.followBean"%>
<%@ page import="control.followMgr"%>
<%
    String follow_set_user_id = request.getParameter("follow_set_user_id");
    String follow_get_user_id = request.getParameter("follow_get_user_id");

    // fundingNum 받아오기
    int fundingNum = Integer.parseInt(request.getParameter("fundingNum"));

    followBean fBean = new followBean();
    fBean.setFollow_set_user_id(follow_set_user_id);
    fBean.setFollow_get_user_id(follow_get_user_id);

    followMgr fMgr = new followMgr();
    fMgr.followInsert(fBean);

    // 팔로우 후 다시 해당 페이지로 리다이렉트
    response.sendRedirect("fundingcheck.jsp?fundingNum=" + fundingNum);
%>
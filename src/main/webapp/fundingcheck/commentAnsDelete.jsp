<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="control.commentsMgr" %>
<%
    commentsMgr cMgr = new commentsMgr();
    
    // Get the comment_num and fundingNum from the request
    int commentNum = Integer.parseInt(request.getParameter("comment_num"));
    int fundingNum = Integer.parseInt(request.getParameter("fundingNum"));

    // Use the ansDelete method to set comment_ans to null
    cMgr.ansDelete(commentNum);

    // Redirect back to the funding page after deletion
    response.sendRedirect("fundingcheck.jsp?fundingNum=" + fundingNum);
%>
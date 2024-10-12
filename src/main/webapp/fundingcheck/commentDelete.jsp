<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="control.commentsMgr"%>
<%@page import="entity.commentsBean"%>
<%
    // 댓글 삭제를 위한 commentsMgr 인스턴스 생성
    commentsMgr cMgr = new commentsMgr();

    // 댓글 번호와 fundingNum을 쿼리 파라미터에서 가져옴
    int commentNum = Integer.parseInt(request.getParameter("comment_num"));
    int fundingNum = Integer.parseInt(request.getParameter("fundingNum"));

    // 댓글 삭제 메소드 호출
    cMgr.commentDelete(commentNum);

    // 삭제 후 fundingcheck.jsp로 리다이렉션
    response.sendRedirect("fundingcheck.jsp?fundingNum=" + fundingNum);
%>

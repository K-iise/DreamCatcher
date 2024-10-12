<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="control.commentsMgr"%>
<%@page import="entity.commentsBean"%>
<%
    request.setCharacterEncoding("UTF-8");
    // 댓글 업데이트를 위한 commentsMgr 인스턴스 생성
    commentsMgr cMgr = new commentsMgr();

    // 댓글 번호와 답변 내용을 쿼리 파라미터에서 가져옴
    int commentNum = Integer.parseInt(request.getParameter("comment_num"));
    String commentAns = request.getParameter("comment_ans"); // 답변 내용
    int fundingNum = Integer.parseInt(request.getParameter("fundingNum")); 

    // 댓글 수정 객체 생성 및 업데이트 호출
    commentsBean commentBean = new commentsBean();
    commentBean.setComment_num(commentNum);
    commentBean.setComment_ans(commentAns); // 답변 내용 설정

    // 답변 저장 메소드 호출
    cMgr.ansInsert(commentAns, commentNum); // 답변 저장 메소드 호출

    // 수정 후 fundingcheck.jsp로 리다이렉션 
    response.sendRedirect("fundingcheck.jsp?fundingNum=" + fundingNum);
%>
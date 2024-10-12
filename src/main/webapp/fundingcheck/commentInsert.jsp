<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="control.commentsMgr"%>
<%@page import="control.resomeCommentMgr"%> 
<%@page import="entity.commentsBean"%>
<%@page import="entity.recomeCommentBean"%> 
<%@page import="java.util.Date"%>
<%
    request.setCharacterEncoding("UTF-8");
    commentsMgr cMgr = new commentsMgr();
    resomeCommentMgr rcMgr = new resomeCommentMgr(); 
    recomeCommentBean rcBean = new recomeCommentBean();
    commentsBean comment = new commentsBean();

    // 세션에서 사용자 ID 가져오기
    String user_id = (String) session.getAttribute("idKey");
    
    // 폼에서 전달받은 데이터
    String commentCon = request.getParameter("comment_con");
    int fundingNum = Integer.parseInt(request.getParameter("fundingNum"));

    // 댓글 객체 설정
    comment.setComment_funding_num(fundingNum);
    comment.setComment_user_id(user_id);
    comment.setComment_con(commentCon);
    
    // 댓글 저장
    cMgr.commentInsert(comment);

 // 댓글 저장 후 추가: 추천 정보 처리
    String recomCommentNumStr = request.getParameter("recom_comment_num"); 
    if (recomCommentNumStr != null) { 
        int recomCommentNum = Integer.parseInt(recomCommentNumStr);

        // 이미 추천했는지 여부 확인
        boolean alreadyRecommended = rcMgr.checkRecome(recomCommentNum, user_id);

        if (alreadyRecommended) {
            // 이미 추천한 경우, 추천 삭제
            rcMgr.recomeDelete(recomCommentNum, user_id);
        } else {
            // 추천하지 않은 경우, 추천 등록
            recomeCommentBean recomBean = new recomeCommentBean();
            recomBean.setRecom_comment_num(recomCommentNum);
            recomBean.setRecom_user_id(user_id); 
            rcMgr.recomeInsert(recomBean); 
        }
    }

    // 댓글 저장 후 원하는 페이지로 리다이렉션 (예: 원래 페이지로 돌아가기)
    response.sendRedirect("fundingcheck.jsp?fundingNum=" + fundingNum);
%>
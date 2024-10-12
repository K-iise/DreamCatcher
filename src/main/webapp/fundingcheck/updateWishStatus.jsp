<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="control.readRecordMgr"%>
<%@page import="entity.readRecordBean"%>
<%
    // 필요한 객체 생성
    readRecordMgr reMgr = new readRecordMgr();
    readRecordBean reBean = new readRecordBean();

    // 쿼리 파라미터에서 값 가져오기
    int fundingNum = Integer.parseInt(request.getParameter("fundingNum"));
    String userId = request.getParameter("userId");

    // 열람 기록이 이미 존재하는지 확인
    boolean readExists = reMgr.checkIfRead(userId, fundingNum);

    if (readExists) {
        // 열람 기록이 있을 경우, read_wish 값을 1로 업데이트
        reMgr.updateReadWish(userId, fundingNum, 1);
    } else {
        // 열람 기록이 없을 경우, 새로운 기록을 삽입
        reBean.setRead_funding_num(fundingNum);
        reBean.setRead_user_id(userId);
        reBean.setRead_wish(1); // read_wish를 1로 설정
        reMgr.readInsert(reBean);
    }

    // 원하는 페이지로 리디렉션
    response.sendRedirect("fundingcheck.jsp?fundingNum=" + fundingNum);
%>

<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="entity.*"%>
<%@page import="control.*"%>

<%
   String priceNumStr = request.getParameter("priceNum");
   String userId = request.getParameter("userId");
   String quantityStr = request.getParameter("quantity");

   if (priceNumStr != null && userId != null && quantityStr != null) {
       int priceNum = Integer.parseInt(priceNumStr);
       int quantity = Integer.parseInt(quantityStr); // quantity 값 가져오기

       buyRecordMgr bMgr = new buyRecordMgr();

       // quantity만큼 반복하여 buy_record 테이블에 데이터 삽입
       for (int i = 0; i < quantity; i++) {
           buyRecordBean buyBean = new buyRecordBean();
           buyBean.setBuy_price_num(priceNum);
           buyBean.setBuy_user_id(userId);

           // buy_record 테이블에 데이터 삽입
           bMgr.buyRecordInsert(buyBean);
       }
   }
%>
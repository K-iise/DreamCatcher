<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="control.*"%>
<%@page import="entity.*"%>	
<%@page import="java.io.*"%>
<%
    String fundingNumStr = request.getParameter("fundingNum");
    String amountStr = request.getParameter("amount");

    if (fundingNumStr != null && amountStr != null) {
        int fundingNum = Integer.parseInt(fundingNumStr);
        int amount = Integer.parseInt(amountStr);

        fundingMgr fMgr = new fundingMgr();
        fMgr.increaseFundingNprice(fundingNum, amount);
    }
%>

<%@page import="java.nio.file.Paths"%>
<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
request.setCharacterEncoding("UTF-8");

String user_id = (String) session.getAttribute("idKey");
//기본 정보

String selectedProject = request.getParameter("project");

String projectSummary = request.getParameter("projectSummary");  // 프로젝트 요약




session.setAttribute("projectSummary", projectSummary);
session.setAttribute("selectedProject", selectedProject);



// 쿼리 스트링에서 페이지 이름을 가져오기
String pageString = request.getParameter("page");

// 해당 페이지로 리디렉션
if (pageString != null && !pageString.isEmpty()) {
    response.sendRedirect(pageString+".jsp");
} else {
    // 기본 리디렉션
    response.sendRedirect("projectBasicinfo.jsp");
}




%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


</body>
</html>
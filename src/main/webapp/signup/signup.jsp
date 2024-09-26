<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.usersMgr" %>
<%@ page import="entity.usersBean" %>
<%

	request.setCharacterEncoding("UTF-8");

	String name=request.getParameter("name");
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String phonenumber=request.getParameter("phonenumber");
	String national_id_number_front=request.getParameter("national_id_number_front");
	String national_id_number_back=request.getParameter("national_id_number_back");
	String address=request.getParameter("address");
	
	usersBean bean=new usersBean();
	
	bean.setUser_name(name);
	bean.setUser_id(username);
	bean.setUser_pw(password);
	bean.setUser_phone(phonenumber);
	bean.setUser_resnum(national_id_number_front+"-"+national_id_number_back);
	bean.setUser_address(address);
	bean.setUser_master(0);
	
	usersMgr mgr=new usersMgr();
	mgr.userInsert(bean);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<tr>
  <td><%= name %></td>
  <td><%= username %></td>
  <td><%= password %></td>
  <td><%= phonenumber %></td>
  <td><%= national_id_number_front %></td>
  <td><%= national_id_number_back %></td>
  <td><%= address %></td>
</tr>
</body>
</html>
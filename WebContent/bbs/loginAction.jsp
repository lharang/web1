<%@page import = "java.io.PrintWriter" %>
<%@page import = "bbs.UsersDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    


<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="users" class="bbs.Users" scope="page"/>
<jsp:setProperty name="users" property="id" />
<jsp:setProperty name="users" property="passwd"/>
    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>


<body>
	<%
		UsersDAO usersDAO = new UsersDAO();
		int result = usersDAO.login(users.getId(), users.getPasswd());
		
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 성공')");
			script.println("location.href='bbsView.jsp'");
			script.println("</script>");
		}else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터 베이스 오류입니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		%>
</body>
</html>
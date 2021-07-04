<%@page import="java.io.PrintWriter"%>
<%@page import="noticeBoard.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="user" class="noticeBoard.JanusBean" scope="page" />
<jsp:setProperty name="user" property="*" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String id = null;
	if(session.getAttribute("id")!=null){
		id = (String) session.getAttribute("id");
	}
	if(id != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
	}
		if (user.getId() == null || user.getPasswd() == null || user.getName() == null
			|| user.getGender() == null || user.getAddress() == null || user.getPhone() == null
				|| user.getEmail() == null || user.getPin_num() == null )
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			
			JanusDBBean userDAO = new JanusDBBean();
			
			int result = userDAO.insertMember(user);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				session.setAttribute("id", user.getId());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'sss.jsp'");
				script.println("</script>");
			}
		}
	
	%>
</body>
</html>
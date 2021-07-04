<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@page import="noticeBoard.*"%>

<!DOCTYPE html>
<html>
<head>
	<style>
		.font{
			font-size:40px;
		}
	</style>
<meta charset="">
<title>Insert title here</title>
</head>
<body>
<% 
	String id = (String) session.getAttribute("id"); 
	
	if(id == null){
		response.sendRedirect("join.jsp"); 
		} 
	
	JanusDBBean mdao = new JanusDBBean(); 
	
	JanusBean mb = mdao.getMember(id);
	
	if(mb != null){ 
	%>
	<h2>나의 정보 조회</h2>
	<table border="0" width="100%" height="100%">
		<tr>
			<td class='font' colspan='2' width="90%"><strong><%=mb.getName() %></strong>님은  <strong><%=mb.getUserGrade() %></strong> 등급입니다</td>
			
			<td><%
				if(mb.getUserGrade().equals("Bronze"))
					out.print("<img src='img/Bronze.PNG'>");
				else if(mb.getUserGrade().equals("Silver"))
					out.print("<img src='img/Silver.PNG'>");
				else if(mb.getUserGrade().equals("Gold"))
					out.print("<img src='img/Gold.PNG'>");
				%>
			</td width="10%">
		</tr>
		
		<tr>
			<td colspan='3'><hr></td>
		</tr>
		
		<tr>
			<td width="10%">이  름 :</td>
			<td colspan='2'><%=mb.getName() %></td>
		</tr>
		
		<tr>
			<td colspan='3'><hr></td>
		</tr>
		
		<tr>
			<td width="10%">아이디 :</td>
			<td colspan='2'><%=mb.getId() %></td>
		</tr>
		
		<tr>
			<td colspan='3'><hr></td>
		</tr>
		
		<tr>
			<td width="10%">성  별 :</td>
			<td colspan='2'><%= mb.getGender()%></td>
		</tr>
		
		<tr>
			<td colspan='3'><hr></td>
		</tr>
		
		<tr>
			<td width="10%">거주지 :</td>
			<td colspan='2'><%= mb.getAddress() %></td>
		</tr>
		
		<tr>
			<td colspan='3'><hr></td>
		</tr>
		
		<tr>
			<td width="10%">전화번호:</td>
			<td colspan='2'><%=mb.getPhone() %></td>
		</tr>
		
		<tr>
			<td colspan='3'><hr></td>
		</tr>

		<tr>
			<td width="10%">이메일 :</td>
			<td colspan='2'><%=mb.getEmail() %></td>
		</tr>
		
	</table>
	<% 
} 
%>
	<hr>
	<input type="button" value="뒤로가기" onclick="location.href='../bbs/loginIndex.jsp'">
	<input type="button" value="내 정보수정" onclick="location.href='change.jsp'">

</body>
</html>
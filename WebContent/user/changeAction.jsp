<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "noticeBoard.*" %>
<%@ page import="java.io.*"%>

<% request.setCharacterEncoding("utf-8");%>

<%
	String id ="";
	try{
		id = (String)session.getAttribute("id");
		if(id==null || id.equals("")){
	       response.sendRedirect("login.jsp");
		}else{%>
		
		<jsp:useBean id="member" scope="page" class="noticeBoard.JanusBean">
		     <jsp:setProperty name="member" property="*"/>
		</jsp:useBean>
		
<%
		 JanusDBBean memberProcess = JanusDBBean.getInstance();
		 memberProcess.updateMember(member); 
%>
		    <script type="text/javascript">      
		         alert("회원정보를 수정하였습니다.");
		   </script>
		   <meta http-equiv="Refresh" content="0;url=loginIndex.jsp" >
<%		}
	}catch(Exception ex){
		System.out.println("SQLException: " + ex.getMessage());
	}
%>
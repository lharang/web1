<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="noticeBoard.Bbs" %>
<%@ page import="noticeBoard.BbsDAO" %>
<%@ page import="noticeBoard.FileDTO" %>
<%@ page import="noticeBoard.FileDAO" %>
<% request.setCharacterEncoding("utf-8"); %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width-device-width", initial-scale="1">
    <title>게시글 작성</title>
    <style>
        body {background-color: white;}
        #wraps {width: 100%; height: 800px; margin: 0 auto; font-size: 20px; color:#fff; text-align: center; text-transform: uppercase;}
        .a {float: left; width: 80%; height: 70px; line-height: 70px; background-color : #505060;}
        div.id {float: left;  height: 70px; width: 50%; line-height: 70px; background-color : #505060;}
        div.part {float: left; width: 30%; height: 70px; line-height: 70px; background: #454555;}
		.b {float: left; width: 10%; height: 70px; line-height: 70px; background-color : #404050;}
		.c {float: left; width: 10%; height: 70px; line-height: 70px; background-color : #303040;}
        
		.d {width: 100%; height: 100px; background-color: white;}  
        
		.e {float: left; width: 30%; height: 70px; line-height: 70px; background: #404050;}
        .f {float: left; width: 70%; height: 70px; line-height: 70px; background: #505060;}
		
		.g {width: 100%; height: 540px; background: #404050;}
        
		.h {float: left; width: 30%; height: 70px; line-height: 70px; background: #404050;}
        .i {float: left; width: 70%; height: 70px; line-height: 70px; background: #505060;}
		
		textarea {font-size: 15px; width: 99%; height: 86%; resize: none;}
    </style>


</head>
<body>

<%
		//로긴체크
		String id = null;
		if(session.getAttribute("id") != null){
			id = (String)session.getAttribute("id");
		}
		if(id == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용할 수 있는 서비스 입니다')");
			script.println("location.href='../user/login.jsp'");
			script.println("</script>");
		}
		
		//게시글번호
		int bbsId = 0;
		if(request.getParameter("bbsId") != null){
			bbsId = Integer.parseInt(request.getParameter("bbsId"));
		}
		if(bbsId == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		//해당 'bbsID'에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크한다
		Bbs bbs = new BbsDAO().getBbs(bbsId);
		if(!id.equals(bbs.getId())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		FileDTO fileDTO = new FileDAO().getFile(bbs.getBbsId());
	%>
	
    <div id="wraps">
      <form name="bbsUpdate" action="updateAction.jsp?bbsId=<%=bbsId%>" method="post"  enctype="multipart/form-data" >
      
        <div class="part">작성자</div>
        <div class="id"><%=bbs.getId()%></div>
        <div class="b">
        	<input type="button" value="뒤로가기" onclick='history.back(-1)'>
        </div>
		<div class="c">
			<input type="submit" value="등록">
        </div>
        <div class="d"></div>
        <div class="e">제목</div>
        <div class="f">
        	<input class="title" type="text" placeholder="글 제목" name="bbsTitle" value="<%=bbs.getBbsTitle()%>" maxlength="50">
		</div> <!--메모-->
        <div class="g">
			<textarea class="content" placeholder="내용" name="bbsContent" maxlength="2048"><%=bbs.getBbsContent()%></textarea>
        </div>
        <div class="h">첨부파일</div>
        <div class="i">
        <a href="upload.jsp">
        <input type="file" name="file" value="파일 선택" >
        <%=fileDTO.getFileName()%>
        </a>
        
   		</div>
   		</form>
    </div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="noticeBoard.Bbs" %>
<%@ page import="noticeBoard.BbsDAO" %>
<%@ page import="noticeBoard.FileDTO" %>
<%@ page import="noticeBoard.FileDAO" %>
<%@ page import = "java.io.File" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>


    
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8">
 	<meta name="viewport" content="width-device-width", initial-scale="1">
 	
    <title>bbsView</title>

    <style>
        body 
        {
        	background-color: white;
        }
        #wraper {width: 60%; height: 800px; padding : 0; margin: auto; font-size: 20px; 
        color:#fff; text-align: center;}
       
		div.id {float: left;  height: 70px; width: 55%; line-height: 70px; background-color : #505060;}
		div.back1 {float: left; width: 10%; height: 70px; line-height: 70px; background-color : #303040;}
		div.back2 {float: left; width: 30%; height: 70px; line-height: 70px; background-color : #303040;}
		div.update {float: left; width: 10%; height: 70px; line-height: 70px; background-color : #454555;}
		div.delete {float: left; width: 10%; height: 70px; line-height: 70px; background-color : #404050;}
		div.blank{width: 100%; height: 100px; background-color: white;}  
		
		div.part {float: left; width: 15%; height: 70px; line-height: 70px; background: #454555;}
		div.text {float: left; width: 35%; height: 70px; line-height: 70px; background: #404050;}
		div.content1 {width: 100%; height: 640px; background:#404050;}
		div.content2 {font-size: 15px; width: 99%; height: 86%; background-color:white; margin : 0 6px; 
		color: black; text-align: left; padding : 0;}
		
		
		div.comment{float: left; width: 99%; height: 50px; line-height: 70px; background: #ef6c00;}
        .?{width: 100%; height: 240px; background: #ff9800;}
		textarea.text {font-size: 15px; width: 99%; height: 56%; resize: none;}
    </style>

</head>

<body>

<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String id = null;
		if(session.getAttribute("id") != null){
			id = (String)session.getAttribute("id");
		}
		
		// bbsID를 초기화 시키고
		// 'bbsID'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
		int bbsId = 0;
		if(request.getParameter("bbsId") != null){
			bbsId = Integer.parseInt(request.getParameter("bbsId"));
		}
		
		// 만약 넘어온 데이터가 없다면
		if(bbsId == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("history.back()");
			script.println("</script");
		}
		
		// 유효한 글이라면 구체적인 정보를 인스턴스에 담는다
		Bbs bbs = new BbsDAO().getBbs(bbsId);
		
		//조회수 저장
		BbsDAO bbsDAO = new BbsDAO();
	    bbsDAO.bbsCnt(bbs.getBbsCnt()+1,bbsId);
		
	%>
	
	
    <div id="wraper">
        
        <div class="part">작성자</div>
        <div class="id"><%=bbs.getId()%></div>
        
        	<%
				if(id != null && id.equals(bbs.getId())){
			%>
				<div class="update">
					<input type="button" value="수정" onclick="location.href='update.jsp?bbsId=<%= bbsId %>'" >
				</div>
				<div class="delete">
					<input type="button" value="삭제" onclick="location.href='deleteAction.jsp?bbsId=<%= bbsId %>'" >
				</div>	
				<div class="back1">
        		<input type="button" value="뒤로가기"  onclick='history.back(-1)'>
        		</div>
			<%
				}else{ %>
					<div class="back2">
		        	<input type="button" value="뒤로가기"  onclick='history.back(-1)'>
		       		 </div>
			<%	}
			%>
			
        

        <div class="blank"></div>
        
        
        <div class="part">제목</div>
        <div class="text">
        <%=
        bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll("<","&gt;").replaceAll("\n","<br>") 
        %>
		</div>
		
		<div class="part">작성일</div>
        <div class="text">
        <%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + ":"
			+ bbs.getBbsDate().substring(14, 16)%>
		</div>
		
		<div class="part">첨부파일</div>
        <div class="text">
		
		<%
		//다운로드
    	String directory = application.getRealPath("/upload/"+bbsId+"/");
	
		File targetDir = new File(directory);
		if(!targetDir.exists()){
			targetDir.mkdirs();
		}
		
		String files[] = new File(directory).list();
        for(String file : files){
		out.write("<a href=\"" + request.getContextPath() + "/downloadAction?bbsId="+bbsId+"&file="+
				java.net.URLEncoder.encode(file,"UTF-8") + "\">" + file + "</a><br>");
					}
		%>
        
        
		</div>
		
		<div class="part">조회수</div>
        <div class="text">
        <%=bbs.getBbsCnt()+1%>
		</div>
		
        <div class="content1">
        	<div class="content2">
			<%= bbs.getBbsContent()%>
			</div>
        </div>
        
        <div class="blank"></div>
        
        
    </div>
</body>
</html>
<%@page import="java.io.PrintWriter"%>
<%@page import= "noticeBoard.BbsDAO"%>
<%@page import= "noticeBoard.Bbs"%>
<%@ page import="noticeBoard.FileDTO" %>
<%@ page import="noticeBoard.FileDAO" %>
<%@ page import = "java.io.File" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeBoard</title>
</head>

<body>

	<%
		//현재 세션 상태를 체크한다
		String id = null;
		if(session.getAttribute("id")!=null){
			id = (String)session.getAttribute("id");
		}
		//로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다.
		if(id == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용할 수 있는 서비스 입니다')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}else{

			BbsDAO bbsDAO = new BbsDAO();
			Bbs bbs = new Bbs();
			bbs.setBbsId(bbsDAO.getNext());
			int bbsId = bbs.getBbsId();
			
			String directory = application.getRealPath("/upload/"+bbsId+"/");
			
			File targetDir = new File(directory);
			if(!targetDir.exists()){
				targetDir.mkdirs();}
			
			
			//파일업로드
			//실제경로 
			//C:\eclipse_ee\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\noticeBoard\업로드 (영어로쓰면 주석처리x)
			int maxSize = 1024 * 1024 * 100; //파일 사이즈
			String encoding = "UTF-8";
			//파일 업로드 실행
			MultipartRequest multipartRequest= new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
			String fileName = multipartRequest.getOriginalFileName("file");
			String fileRealName = multipartRequest.getFilesystemName("file");
		
		    //글쓰기
			String bbsTitle = multipartRequest.getParameter("bbsTitle");
			String bbsContent = multipartRequest.getParameter("bbsContent");
			bbs.setBbsTitle(bbsTitle);
			bbs.setBbsContent(bbsContent);
			
			
			if(bbs.getBbsTitle() == null || bbs.getBbsContent()==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else{
		
				System.out.println("getNext before bbsDAO.write : " + bbs.getBbsId());
				int result = bbsDAO.write(bbs.getBbsTitle(),id,bbs.getBbsContent());
				
				new FileDAO().upload(fileName, fileRealName, bbs.getBbsId());
				out.write("fileName : " + fileName + "<br>");
				out.write("fileRealName : " + fileName + "<br>");
				
				
				
				//데이터베이스 오류인 경우
				if(result==-1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('등록되었습니다')");
					script.println("location.href='loginIndex.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>
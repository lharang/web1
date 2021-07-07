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
			script.println("location.href='../user/login.jsp'");
			script.println("</script>");
		}else{
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
			}else{
				
				
				//파일업로드
				//실제경로 
				//C:\eclipse_ee\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\noticeBoard\업로드 (영어로쓰면 주석처리x)
				String directory = application.getRealPath("/upload/"+bbsId+"/");
				File targetDir = new File(directory);
				if(!targetDir.exists()){
					targetDir.mkdirs();
				}	
				int maxSize = 1024 * 1024 * 100; //파일 사이즈
				String encoding = "UTF-8";
				MultipartRequest multipartRequest= new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());
				String fileName = multipartRequest.getOriginalFileName("file");
				String fileRealName = multipartRequest.getFilesystemName("file");
				//글쓰기
			    BbsDAO bbsDAO = new BbsDAO();
				String bbsTitle = multipartRequest.getParameter("bbsTitle");
				String bbsContent = multipartRequest.getParameter("bbsContent");
				bbs.setBbsTitle(bbsTitle);
				bbs.setBbsContent(bbsContent);
				
				
				if(bbs.getBbsTitle()==null || bbs.getBbsContent()==null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력되지 않은 사항이 있습니다')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					
					//파일이있을 경우
					if(fileName!=null)
					{
						new FileDAO().update(fileName, fileRealName, bbs.getBbsId());
						out.write("fileName : " + fileName + "<br>");
						out.write("fileRealName : " + fileName + "<br>");
						
					}
						
					System.out.println("getNext before bbsDAO.write : " + bbs.getBbsId());
					int result = bbsDAO.update(bbsTitle, bbsContent,bbsId);
					
					
					//데이터베이스 오류인 경우
					if(result==-1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정에 실패했습니다')");
						script.println("history.back()");
						script.println("</script>");
					}else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('수정되었습니다')");
						script.println("location.href='loginIndex.jsp'");
						script.println("</script>");
					}
				}
				
		}
		}
	%>
</body>
</html>
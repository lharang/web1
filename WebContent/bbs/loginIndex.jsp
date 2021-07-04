<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	<%@ page import="java.io.PrintWriter"%>
<%@ page import="noticeBoard.BbsDAO"%>
<%@ page import="noticeBoard.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<title>Index</title>
	<style>
	    #1{
	    	width : 5%;
	    }
	    #2{
	    	width : 10%;
	    }
	    #3{
	    	width : 35%;
	    }
	    #4{
	    	width : 20%;
	    }
	    #5{
	    	width : 25%;
	    }
	    #6{
	    	width : 5%;
	    }
	    #bar{
	    	height="1";
	    	color : white;
	    	background-color : #505060;
	    }
	    
	    body{
	    	background-color:  white;
	    }
		.header {
			background-color : white;
			height:80px;
		}
		.body {
			width:200px;
			text-align:left;
			float:left;
			padding:10px;
		}
		.header,.body{ text-align:center; }
		.header{ line-height:100px; }
		.body { line-height:240px; }
		
		.header_first{
			border: 0px solid; 
			float: left;
			width: 33%;
		}
		div.header_second{
			border: 0px solid; 
			float: left; 
			width: 33%;
		}
		input.header_second{
			width: 80%;
		}
		button.header_second{
			width : 10%;
			height : 50px;
			background-color : #404050;
			color : white;
			border: 1px solid white;
		    border-radius :3px;
		}
		.header_third{
			border: 0px solid; 
			float: left; 
			width: 33%;		
		}
		.userDIV{
			display:none;
			position: absolute;
    		top: 20%;
    		right:11%;
    		transform : translate(-50%,-50%);
			border: 2px solid black;
   			width: 100px;
			height: 100px;
		}
		.login, .join{
  			display: flex;
  			justify-content: center;			
		}
		div.write{
			padding : 0;
			margin-top : 0;
			margin-left : 20px;
		}
		input.write{
		    border: 1px solid white;
		    border-radius :3px;
			background-color : #404050;
			color : white;
		}
		div.BbsList{
		    margin-top : 120px;
		    padding : 30px 0 ;
			width : 100%;
			height : auto;
			color : black;
			background-color : white;
			border : 3px solid white;
			border-radius: 12px;
			
		}
		table.BbsList{
			width : 100%;
			text-align : center;
			margin : 20px 0;
			background-color : #F0F0F5;
		}
		div.page{
			padding : 0;
			margin-top : 0;
			margin-left : 15px;
		}
		button.left{
			background-color : #404050;
			color : white;
			border: 1px solid white;
		    border-radius :3px;
		    height : 25px;
		}
		button.right{
			background-color : #404050;
			color : white;
			border: 1px solid white;
		    border-radius :3px;
		    height : 25px;
		}
		input[type="text"] {
			border: solid 2px black;
			border-radius: 12px;
			height:50px;
			
		}
		
	</style>
	<script>
		var bDisplay = true;
		function doDisplay(){
			var con = document.getElementById("myDIV");
			
			if(con.style.display=='none'){
				con.style.display = 'block';
			}else{
				con.style.display = 'none';
			}	
		}
	</script>
</head>





<body>

<%
	//������ �ѹ�
	int pageNumber = 1; //�⺻�� 1 �������� �Ҵ�
		// ���� �Ķ���ͷ� �Ѿ�� ������Ʈ Ÿ�� 'pageNumber'�� �����Ѵٸ�
		// 'int'Ÿ������ ĳ������ ���ְ� �� ���� 'pageNumber'������ �����Ѵ�
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	
	
	<div class="header">
		<div class="header_first">
			<img src="img/Janus.PNG" style="width:85px; height:85px;"><br>
		</div>
		<div class="header_second">
			<form method="post" action="searchIndex.jsp" class="header_second">
			<input type="text" name="search" size=50 placeholder="search" class="header_second">
			<button type="submit" class="header_second">�˻�</button>
			</form>
		</div>
		<div class="header_third">
			<a href="javascript:doDisplay();">
			<img src="img/human.PNG" style="width:85px; height:85px;"><br>
			</a>
		</div>
	</div>
	
	<div class="userDIV" id="myDIV" >
		<div class="login">
			<a href="../user/myInfo.jsp">�� ���� ����</a>
		</div>
		<br>
		<div class="join">
			<a href="../user/logoutAction.jsp">�α׾ƿ�</a>
		</div>
	</div>

		
		<!-- �Խñ� ����Ʈ -->
		<div class="BbsList">
		<div class="write">
			<a href="bbsWrite.jsp"> <input class="write" type="button" value="�۾���">
			</a>
		</div>
			<table class="BbsList">
				<thead>
						<tr height="5">
							<td width="5"></td>
						</tr>
						<tr id="bar">
							<td id="1"></td>
							<td id="2"">��ȣ</td>
							<td id="3"">����</td>
							<td id="4">�۾���</td>
							<td id="5">�ۼ���</td>
							<td id="6"></td>
						</tr>
						<tr height="25" align="center">
						</tr>
						<tr height="1" bgcolor="#D2D2D2">
							<td colspan="6"></td>
						</tr>
						</thead>
				
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO(); // �ν��Ͻ� ����
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td id="1"></td>
						<td id="2"><%= list.get(i).getBbsId() %></td>
						<!-- �Խñ� ������ ������ �ش� ���� �� �� �ֵ��� ��ũ�� �ɾ�д� -->
						<td id="3"><a href="bbsView.jsp?bbsId=<%= list.get(i).getBbsId() %>">
							<%= list.get(i).getBbsTitle() %></a></td>
						<td id="4"><%= list.get(i).getId() %></td>
						<td id="5"><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + ":"
							+ list.get(i).getBbsDate().substring(14, 16) %></td>
						<td id="6"></td>
					</tr>
					
					<%
						}
					%>

				</tbody>
					</table>
				
				<div class="page">
				<!-- ����¡ -->
				<%if(pageNumber !=1){%>
				    <button onclick="location.href='bbs.jsp?pageNumber=<%=pageNumber -1 %>'"
				         class="left">Back</button>
				         
				 <%}if(bbsDAO.nextPage(pageNumber +1)){%>
				 	<button onclick="location.href='bbs.jsp?pageNumber=<%=pageNumber +1 %>'"
				 		class="right">Next</button>
				 <%}%>
				 </div>
				 
					</div>
</body>

</html>
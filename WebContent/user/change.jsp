<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="noticeBoard.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update</title>
		<style>
			 .change{
    			position: absolute;
    			top: 50%;
    			left:50%;
    			transform : translate(-50%,-50%)
    		}
    		h2{
    			text-align : center;
    		}
		</style>
    </head>
    
    <script type="text/javascript">
   		 function test() {
      	 var p1 = document.getElementById('passwd').value;
         var p2 = document.getElementById('passwd2').value;
      
          if( p1 != p2 ) 
          {
            alert("비밀번호불일치");
            return false;
          } 
          
          else
          {
            alert("비밀번호가 일치합니다");
            return true;
          }
    }
  </script>
  
  
    <body>
	<%
	String id = (String)session.getAttribute("id"); 
	
	JanusDBBean mdao = new JanusDBBean(); 
	
	JanusBean mb = mdao.getMember(id);
	%>
	회원님의 이름은 <%=mb.getName()%> 입니다.
    <%
    	String oriId = mb.getId();
    %>
    
    <div class="change">
        <form action="changeAction.jsp" method="post">
            <table border ="0" width="250" height="150">
            <h2>정보수정</h2>
                <tr bgcolor="gray" >
                    <td align = "center"> <font size = 2 color="white">현재 아이디</font></td>
                    <td> <input type ="hidden" name="OriId" size="13" value=<%=oriId%>><%=oriId %></td>
                </tr>
                <tr bgcolor="gray" >
                    <td align = "center"> <font size = 2 color="white">이름</font></td>
                    <td> <input type ="text" name ="name" size="13" value=<%=mb.getName()%>></td>
                </tr>
                
                <tr bgcolor="gray" >
                    <td align = "center"> <font size = 2 color="white">아이디</font></td>
                    <td> <input type ="text" name ="id" size="13" value=<%=mb.getId()%>></td>
                </tr>

                <tr bgcolor="gray">
                    <td align = "center"><font size = 2 color="white">비밀번호</font></td>
                    <td> <input type ="password" name ="passwd" size="14" value=<%=mb.getPasswd()%>></td>
                </tr>
                
                <tr bgcolor="gray">
                    <td align = "center"><font size = 2 color="white">비밀번호확인</font></td>
                    <td> <input type ="password" name ="passwd2" size="14"></td>
                </tr>
                
                <tr bgcolor="gray">
               		<td align = "center"><font size = 2 color="white">성별</font></td>
  						<td>
   							<input type="radio" name="gender" value="남" checked/><font size = 2 color="white">남자</font>
   							<input type="radio" name="gender" value="여"/><font size = 2 color="white">여자</font>
  						</td> 
  				</tr>
  				
                <tr bgcolor="gray">
                    <td align = "center"><font size = 2 color="white">전화번호</font></td>
                    <td> <input type ="text" name ="phone" size="13" value=<%=mb.getPhone()%>></td>
                </tr>
                
                <tr bgcolor="gray">
 					<td align = "center"><font size = 2 color="white">이메일</font></td>
 					<td><input type="text" name="email" size=13 value=<%=mb.getEmail()%>></td>
 				</tr>
                
                <tr bgcolor="gray">
                    <td align = "center"><font size = 2 color="white">현재거주지</font></td>
                    <td> <input type ="text" name ="address" size="13" value=<%=mb.getAddress()%>></td>
                </tr>
                
                 <tr bgcolor="gray">
                    <td align = "center"><font size = 2 color="white">핀번호</font></td>
                    <td> <input type ="text" name ="pin_num" size="13" value=<%=mb.getPin_num()%>></td>
                </tr>
                
                <tr>
                    <td colspan="7" align ="center">
                        <input type="submit" value="변경하기"><br>
                    </td>
                </tr>
            </table>
        </form>
        </div>
    </body>
</html> 
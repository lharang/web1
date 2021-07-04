<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <style>
        .lost{
    		position: absolute;
    		top: 50%;
    		left:50%;
    		transform : translate(-50%,-50%)
    	}
        </style>
    </head>
    <body>
    <div class="lost">
        <form action="loginOk.jsp" method="post">
            <table border ="0" width="250" height="150">
            <h2>계정을 잃어버리셨습니까?</h2>
                <tr bgcolor="gray" >
                    <td align = "center"> <font size = 2 color="white">이름</font></td>
                    <td> <input type ="text" name ="name" size="13"></td>
                </tr>

                <tr bgcolor="gray">
                    <td align = "center"><font size = 2 color="white">주민번호</font></td>
                    <td> <input type ="text" name ="pin_num" size="14"></td>
                </tr>
                <tr>
                    <td colspan="7" align ="center">                        
                        <a href=""><font size = 2 color="Balck">계정 찾기</a><br>      
                    </td>
                </tr>
            </table>
        </form>
       </div>
    </body>
</html> 
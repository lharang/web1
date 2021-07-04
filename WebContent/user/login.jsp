<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    	<style>
    		.login{
    			position: absolute;
    			top: 50%;
    			left:50%;
    			transform : translate(-50%,-50%)
    		}
    		h2{
    			text-align : center;
    		}
    	</style>
        <title>Login</title>
    </head>
    <body>
    
    <div class="login">
        <form action="loginAction.jsp" method="post">
            <table border ="0" width="250" height="150">
            <h2>로그인</h2>
                <tr bgcolor="gray" >
                    <td align = "center"> <font size = 2 color="white">아이디</font></td>
                    <td> <input type ="text" name ="id" size="13"></td>
                </tr>

                <tr bgcolor="gray">
                    <td align = "center"><font size = 2 color="white">비밀번호</font></td>
                    <td> <input type ="password" name ="passwd" size="14"></td>
                </tr>
                <tr>
                    <td colspan="7" align ="center">
                        <input type="submit" value="로그인"><br>
                        <a href="#"><font size = 2 color="Balck">계정을 잃어버리셨습니까?</a><br>
                        <a href="join.jsp"><font size = 2 color="Balck">새 계정을 만드시겠습니까?</a>
                    </td>
                </tr>
            </table>
        </form>
        </div>
    </body>
</html>
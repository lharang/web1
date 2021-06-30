<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html>


<head>
<meta charset="UTF-8">
<link href="style.css?ver=2" rel="stylesheet" type="text/css">
<title>Library_Login</title>
</head>


<body>

<div class=wrapper>
<table border=1>

<!-- 로고 -->
<tr class="header">
<td colspan="2">
	<section>
		<h1>
		<a href="main.jsp" class="logo">
		<img src="C:\\Users\\User\\git\\web1\\myjsp\\images\\library.png" alt="library" class="logo">
		Library
		</a>
		</h1>
	</section>
</td>
</tr>

<tr>
<td colspan="2" class="nav">
	<hr/>
	
	<ul>
	<li class="nav"><a href="#">검색</a></li>
	<li class="nav"><a href="#">내 정보</a></li>
	<li class="nav"><a href="#">추천</a></li>
	<li class="nav"><a href="#">도서 판매</a></li>
	<li class="nav"><a href="#">도서 순위</a></li>
	</ul>
	
	<br/><hr/>
</td>
</tr>


<tr>

<td class="aside">
<section class="aside">
	<ul class="aside">
	<li class="aside" id=aside0>회원<br/>가입<hr/></li>
	<li class="aside" id=aside1><a href="signUp_e.jsp">e-mail</a><br/></li>
	<li class="aside" id=aside2><a href="signUp_n.jsp">naver</a><br/></li>
	<li class="aside" id=aside3><a href="signUp_k.jsp">kakao</a><br/></li>
	<li class="aside" id=aside4><a href="signUp_f.jsp">facebook</a></li>
	</ul>
</section>
</td>


<td class="main">
<section class="login">

	<div class="login">
		<h2><span class="login">Login</span></h2>
		
		<form name="loginForm" action="loginAction.jsp" method="post" class="login">
		ID <input type="text" name="id" class="login" id="login_id">
		PW <input type="password" name="passwd" class="login" id="login_pw">
		<input type="submit" value="Login" class="login" id="login_submit">
		</form>
	</div>
	
</section>
</td>

</tr>





<!-- footer -->
<tr>
<td colspan="2" class="footer">
	<span class="footer">
	제작자 : 이하랑
	</span>
	<span class="footer">
	연락처 : 010 - 2401 - 8069 
	</span>
</td>
</tr>

</table>









</div>
</body>
</html>
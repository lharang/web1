<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8">
    <title>bbsView</title>
    <style>
        body 
        {
        	background-color: #ffe0b2;
        }
        table
        {
        	width: 100%; height: 1200px; margin: 0 0; padding : 0px 0px;
        	font-size: 20px; color:#fff; text-align: center; text-transform: uppercase;
        	border-spacing: 0px;
        }
        .top{
        	width : 100%; height : 70px; margin : 0 auto;
        }
        .name 
        {
        	float: left; width: 80%; height: 70px; line-height: 70px; background: #ef6c00;
        }
		.back 
		{
			float: left; width: 10%; height: 70px; line-height: 70px; background: #ffa726;
		}

		.blank 
		{
			height: 20px; background: #ffe0b2;
		}
        
        .middle_1{
        	height : 70px; width : 100%; margin : 0 auto;
        }
        .middle_2{
        	height : 70px; width : 100%; margin : 0 auto;
        }
		.part 
		{
			float: left; width: 10%; height: 70px; line-height: 70px; background: #fb8c00;
		}
		.text 
		{
			float : left; width : 30%; height : 70px; line-height : 70px; background : #ffa726;
		}
		
		<!--하단-->
		.bottom{
        	height : auto; margin : 0 auto;
        }
		.content 
		{
			width: 100%; height: 640px; background: #ff9800;
		}
        
		textarea {font-size: 15px; width: 99%; height: 76%; resize: none;}
    </style>
</head>

<body>
        <table>
        	<tr class="top">
        		<td class="name">작성자 이름</td>
        		<td class="back"><input type="button" value="뒤로가기"></td>
        	</tr>
        	<tr>
        		<td colspan="2" class="blank"></td>
        	</tr>
        	<tr class="middle_1">
        		<td class="part">제목</td>
        		<td class="text">제목표시</td>
        		<td class="part">작성일</td>
        		<td class="text">작성일표시</td>
        	</tr>
        	<tr class="middle_2">
        		<td class="part">첨부파일</td>
        		<td class="text">첨부파일표시</td>
        		<td class="part">조회수</td>
        		<td class="text">조회수표시</td>
        	</tr>
        	<tr class="bottom">
        	<td colspan="2" class="content">
        		<textarea name="text_box"></textarea>
        	</td>
        	</tr>
        	
        </table>
</body>
</html>
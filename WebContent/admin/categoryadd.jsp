<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.admin.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="myhome.category.*"%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<style>
	th{
		float: left;
	}
	 #update{
		border: none; /*---테두리 정의---*/
	   background-Color: skyblue; /*--백그라운드 정의---*/
	   font: 12px 굴림; /*--폰트 정의---*/
	   font-weight: bold; /*--폰트 굵기---*/
	   color: white; /*--폰트 색깔---*/
	   width: 70px;
	   height: 30px; /*--버튼 크기---*/
	}
</style>
<script>
function textchk(obj){
	if(obj.imgtext.value=='')
	{
		alert('이미지를 등록해주세요');
		return false;
	}
		else if(obj.cname.value=='')
	{
			alert('카테고리이름 등록해주세요');
			return false;
	}
	
}

function simgpath(obj){
	var path = obj.value;
	var file = path.substring(path.lastIndexOf('\\')+1,path.length);
	fm.imgpath.value=file;
}
</script>
</head>
<body>
<section>
	<article>
		<form name="fm" action="categoryadd_ok.jsp" method="post" enctype="multipart/form-data" onsubmit="return textchk(this)">
			<table>
				<tr>
					<th>이미지</th>
					<td><input type="text" id="imgtext" name="imgpath" readOnly style="border:0px; font-weight: bold"></td>
					<td><input type="file" id="fileimg" name="cimg" onChange ="simgpath(this)"></td>
				</tr>
				<tr>
					<th>카테고리 이름</th>
					<td><input type="text" name="cname"></td>
				</tr>
				<tr>
					<td colspan="2">
					<input type="submit" value="등록" id="update">
					<input type="reset" value="다시작성" id="update">
					</td>
				</tr>
			</table>
		</form>
	
	</article>
</section>
</body>
</html>
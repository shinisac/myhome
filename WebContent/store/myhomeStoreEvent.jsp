<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
 #update{
		border: none; /*---테두리 정의---*/
	   background-Color: skyblue; /*--백그라운드 정의---*/
	   font: 15px 굴림; /*--폰트 정의---*/
	   font-weight: bold; /*--폰트 굵기---*/
	   color: white; /*--폰트 색깔---*/
	   width: 130px;
	   height: 60px; /*--버튼 크기---*/
}
</style>
<script>
function goShopping(){
	location.href="/myhome/store/myhomeStoreList.jsp";
}
</script>
</head>
<body>
<%@include file="../header.jsp" %>
<br>
<table align="center" width="1000">
	<tr>
		<td>
			<article align="center">
				<img src="../img/event.jpg" width="1000"height="764">
			</article>
		</td>
	</tr>
	<tr>
		<td align="center">
			<br>
			<input type="button" value="계속 쇼핑하기" onclick="goShopping()" id="update">
		</td>
	</tr>	
</table>
<br>
<%@include file="../footer.jsp" %>
</body>
</html>
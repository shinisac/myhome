<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta  charset=UTF-8">
<title>Myhome</title>
<style>
table td{
	width:200;
	height:100;
}

</style>
</head>
<body bgcolor="skyblue">
<%@include file="header.jsp" %>
	<form method="POST">
		<table border="1" cellspacing="0" align="center" >
			<tr>
				<td><a href="admin_goods.jsp">상품관리</a></td>
				<td><a href="goods_oreder.jsp">주문관리</a></td>
				<td><a href="admin_bbslist.jsp">게시판관리</a></td>
				<td><a href="admin_memberlist.jsp">회원관리</a></td>
				<td><a href="category.jsp">카테고리관리</a></td>
			</tr>
		</table>
	
	</form>


</body>
</html>
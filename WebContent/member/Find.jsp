<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.beans.*"%>
<%@ page import="java.util.*"%>    
<%request.setCharacterEncoding("utf-8"); %><!-- 검색을 전달하는 페이지도 인코딩 방식을 지정해주어야함 -->
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
<link rel="stylesheet" type="text/css" href="../css/myhomeLayout.css">
</head>
<body>
<%@include file="../header.jsp" %>
<section>
<article>
<h2>상 품 검 색</h2>
	<form name="goodsfind" action="Find.jsp" method="post"> <!-- action 태그 생략이 자신을 그대로 호출함 -->
		<fieldset>
		<legend>상품검색</legend>
		<select name="fkey">
			<option value="goods_name">제품 이름</option><!--   컬럼으로 사용할 이름-->
			<option value="goods_content">제품설명</option>
		</select>
		<input type="text" name="fvalue">
		<input type="submit" value="검색">
		</fieldset>
	</form>
</article>
<article>
<hr>

<hr>
</article>
</section>
<%@include file="../footer.jsp" %>
</body>
</html>
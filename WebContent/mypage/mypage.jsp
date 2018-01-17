<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
</head>
<body>
<%@include file="../header.jsp" %>
<form method="POST">
<section>
	<article align="center">
		<br>
		<div><a href="mystory.jsp"><font size="5" color="skyblue"><Strong>나의 스토리</Strong></font></a></div>
		<br>
		<hr>
		<br>
		<div><a href="mybuy.jsp"><font size="5" color="skyblue"><Strong>나의 구매내역</Strong></font></a></div>
		<br>
		<hr>
		<br>
		<div><a href="#"><font size="5" color="skyblue"><Strong>회원정보 수정</Strong></font></a></div>
		<br>
		<hr>
		<br>
		<div><a href="/myhome/bbs/write.jsp"><font size="5" color="skyblue"><Strong>스토리 올리기</Strong></font></a></div>
		<br>
	</article>
	
</section>
</form>
<%@include file="../footer.jsp" %>
</body>
</html>
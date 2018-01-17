<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.beans.*"%>
<%@ page import="java.util.*"%>    
<%request.setCharacterEncoding("utf-8"); %><!-- 검색을 전달하는 페이지도 인코딩 방식을 지정해주어야함 -->
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
<h2>스 토 리 검 색</h2>
	<form name="sfind" action="SFind.jsp" method="post"> <!-- action 태그 생략이 자신을 그대로 호출함 -->
		<fieldset>
		<legend>스토리 검색</legend>
		<select name="fkey">
			<option value="bbs_writer">작성자 검색</option><!--   컬럼으로 사용할 이름-->
			<option value="bbs_subject">내용 검색</option>
		</select>
		<input type="text" name="fvalue">
		<input type="submit" value="검색">
		</fieldset>
	</form>
</article>
<article>
<hr>
<%
if(request.getMethod().equals("GET")){ //사용하는 방식
	%><h3 style="color:blue;">
	위 검색란에 검색어를 입력해주세요.
	</h3><%
}else{
	%>
	<jsp:include page="SResult.jsp"/>
	<%
}
%>
<hr>
</article>
</section>
<%@include file="../footer.jsp" %>
</body>
</html>
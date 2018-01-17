<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
</head>
<%
String userid=(String)session.getAttribute("aid");

if(userid==null||userid.equals("")){
   %>
   <script>
   window.alert('로그인 후 이용가능한 서비스입니다.');
   location.href='/myhome/index.jsp';
   </script>
   <%
   return;//자바 코드를 멈출때 사용하는 키워드
}
%> 
<body>
<h2 align="center">관리자 페이지</h2>

</body>
</html>
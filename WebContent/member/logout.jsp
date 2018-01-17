<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <%request.setCharacterEncoding("UTF-8"); %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 

%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
 
    <%
    // 로그아웃 버튼을 누르면 오게되는 곳인데
    // session을 재시작해서 저장된 정보를 날린다
    session.invalidate();
    // 그리고 다시 login.jsp로 돌아가게 한다
    response.sendRedirect("/myhome/index.jsp"); 
    %>

</body>
</html>
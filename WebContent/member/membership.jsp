<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 

%>
        <%request.setCharacterEncoding("UTF-8"); %>
    <%!
    	boolean isset(String str)
    	{
    		if(str==null)return false;
    		if(str.equals(""))return false;
    		return true;
    	}
    %>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
</head>
<body>
<%
if(!isset((String)session.getAttribute("member_id")) || !isset((String)session.getAttribute("member_password")))
{
	out.println("<p align=\"center\">로그인 되지 않았습니다.</p>");
	out.println("<p align=\"center\"><a href=\"membership.jsp\">로그인하기</a></p>");
}
else
{
	out.println("<p align=\"center\">환영합니다."+
(String)session.getAttribute("member_id")+"님 - <a href=\"logout.jsp\">로그아웃</a></p>");
}
%>

</body>
</html>
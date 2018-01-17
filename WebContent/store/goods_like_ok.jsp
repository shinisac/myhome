<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.store.*" %>
<jsp:useBean id="mdao" class="myhome.store.MyhomeDAO" scope="session"/>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 

%>
<%
int idx = Integer.parseInt(request.getParameter("goods_like"));
int count=mdao.ulikenum(idx);
String msg=count>0?"좋아요!":"좋아요실패!";
%>
<script>
window.alert('<%=msg%>');
location.href="myhomeStoreContent.jsp?goods_like=<%=idx%>";
window.self.close();
</script>


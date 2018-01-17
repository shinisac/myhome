<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page  import="myhome.admin.*" %>
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>
    

<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=UTF-8");
int idx=Integer.parseInt(request.getParameter("idx"));
int result=adao.goodsdel(idx);
String msg=result>0?"상품 삭제성공":"상품 삭제실패";
if(result>0){
%>
<script>
window.alert('<%=msg%>');
window.self.close();
window.opener.location.href='/myhome/admin/admin_goods.jsp';
</script>
<%
}else{
%>
<script>
window.alert('<%=msg%>');
window.self.close();
window.opener.location.href='/myhome/admin/admin_goods.jsp';
</script>
<%
}
%>



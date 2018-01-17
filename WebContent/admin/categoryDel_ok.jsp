<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page  import="myhome.admin.*" %>
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>
    

<%
String idx_s[] = request.getParameterValues("ck");
int result=0;
for(int i=0; i<idx_s.length; i++){
	int idx=Integer.parseInt(idx_s[i]);
	result=adao.categorydel(idx);
}

String msg=result>0?"카테고리 삭제성공":"카테고리 삭제실패";
if(result>0){
%>
<script>
window.alert('<%=msg%>');
location.href="category.jsp"
window.self.close();
</script>
<%
}else{
%>
<script>
window.alert('<%=msg%>');
location.href="category.jsp";
window.self.close();
</script>
<%
}
%>



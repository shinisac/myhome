<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adao" class="myhome.admin.adminDAO"/>
<%
	String userid=request.getParameter("ck");
	String level=request.getParameter("level");
	
	int result=adao.admin_memberUpdate(userid, level);
	
	String msg=result>0?"회원수정성공":"회원수정실패";
%>
<script>
window.alert('<%=msg%>');
location.href="admin_memberlist.jsp";
</script>
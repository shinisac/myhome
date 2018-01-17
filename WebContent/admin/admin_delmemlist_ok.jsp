<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adao" class="myhome.admin.adminDAO"/>
<%
	String userid=request.getParameter("ck");
	
	
	int result=adao.admin_memberdel(userid);
	
	String msg=result>0?"회원삭제성공":"회원삭제실패";
%>
<script>
window.alert('<%=msg%>');
location.href="admin_delmemlist.jsp";
</script>
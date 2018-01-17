<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page  import="myhome.admin.*" %>
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>   
<%
	String[] chk = request.getParameterValues("ck");
	for(int i=0;i<chk.length;i++){
		int idx = Integer.parseInt(chk[i]);
		int count = adao.goodsdel(idx);		
	}
	%>
	<script>
		location.replace('/myhome/admin/admin_goods.jsp');
	</script>
	<%		
%> 

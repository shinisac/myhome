<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page  import="myhome.admin.*" %>
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>   

<%
	String[] dchk = request.getParameterValues("dck");
	String[] achk = request.getParameterValues("ack");
	if(dchk!=null){
		for(int i=0;i<dchk.length;i++){
			int idx = Integer.parseInt(dchk[i]);
			adao.goodsdislpay(idx);		
		}
	}
	if(!(achk==null)){
		for(int i=0;i<achk.length;i++){
			int idx = Integer.parseInt(achk[i]);
			adao.goodsnodislpay(idx);		
		}
	}	
	%>
	<script>
		location.replace('/myhome/admin/goods_display.jsp');
	</script>
	<%		
%> 

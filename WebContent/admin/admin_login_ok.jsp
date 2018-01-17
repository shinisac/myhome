<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page  import="myhome.admin.adminDAO.*" %>
<%@page  import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="java.io.*" %>
<jsp:useBean id="admindao" class="myhome.admin.adminDAO" scope="session"/>  
   <%
   String admin_id=request.getParameter("admin_id");
   String admin_pwd=request.getParameter("admin_pwd");
   
   int result=admindao.admin_login(admin_id, admin_pwd);
	String msg=result>0?"로그인성공":"로그인실패";
	%>
	<script>
	window.alert('<%=msg%>');
	if(<%=result%>>0){
		
		<%
		String savepath=request.getSession().getServletContext().getRealPath("/")+"img/test/"+admin_id;

		File f=new File(savepath);
		if(!f.exists()){
			f.mkdir();
		}
		%>
		location.href="/myhome/admin/admin_main.jsp";
		<%
		session.setAttribute("aid", admin_id);
		%>
	}else{
		location.href="/myhome/admin/index.jsp";
	}
	
	</script>
   
  
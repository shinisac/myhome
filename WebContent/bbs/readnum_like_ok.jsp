<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.bbs.*"%>
<%@ page import="myhome.rip.*"%>
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session"/>
<jsp:useBean id="rdto" class="myhome.rip.ripDTO" scope="session"/>
<jsp:setProperty property="*" name="rdto" />       
<jsp:useBean id="rdao" class="myhome.rip.ripDAO"/>

    <%
	String userid=(String)session.getAttribute("sid");
	%>	
	<%
	
	int idx=Integer.parseInt(request.getParameter("idx2"));
	bdao.readNum(idx);
	%>
	<script>
	window.location.href="content.jsp?idx2=<%=idx%>"
	window.self.close();
	</script>
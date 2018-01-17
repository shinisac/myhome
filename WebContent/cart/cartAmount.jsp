<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<jsp:useBean id="cdao" class="myhome.cart.CartDAO"/>
<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=UTF-8");
Map<String, String[]> m = request.getParameterMap();

if( m.keySet().size() == 0 ) {
	%>
	<script>
		alert('[접근오류]');
		location.replace('/myhome');
	</script>
	<%	
		return;
}
%>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 

if(session.getAttribute("sid")==null){
%>
<script>
	alert('로그인이 필요한 페이지입니다.');
	location.replace('/myhome');
</script>
<%	
	return;
}
%>
<%
	String[] idx = request.getParameterValues("hi_idx");
	String[] amount = request.getParameterValues("amount");

	
 	for(int i=0;i<idx.length;i++){
		int a = Integer.parseInt(idx[i]);
		int b = Integer.parseInt(amount[i]);
		cdao.cartAmount(a,b);
	} 
%>
	<script>
	
		location.href='cartPage.jsp';
				
	</script>
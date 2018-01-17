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
	String[] chk = request.getParameterValues("chk_cart_goods");

	if(chk==null||chk.length==0){
		
			String idxs = request.getParameter("idx");
			
			int count = cdao.cartDel(idxs);	
		
			if(count>0){
				%>
				<script>
					location.href='cartPage.jsp';
				</script>
				<%
			}else{
				%>
				<script>
					location.href='cartPage.jsp';
				</script>
				<%
			}
			
	}else{
		for(int i=0;i<chk.length;i++){
			
			int count = cdao.cartDel(chk[i]);
		}
		%>
		<script>
			location.href='cartPage.jsp';
		</script>
		<%		
	}
%>
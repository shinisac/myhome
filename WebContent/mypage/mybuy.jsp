<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>   
<%@ page import="myhome.cart.*" %>  
<%@ page import="myhome.member.*" %>
<%@ page import="myhome.store.*" %>
<%@ page import="myhome.order.*" %> 
<%@ page import="java.text.*" %> 
<jsp:useBean id="odto" class="myhome.order.OrderDTO" />
<jsp:useBean id="odao" class="myhome.order.OrderDAO" />
<jsp:useBean id="mdao" class="myhome.store.MyhomeDAO" />
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
    String m_id=(String) session.getAttribute("sid");
	
	if(m_id==null||m_id.equals("")){
		%>
		<script>
			window.alert('로그인 후 이용 가능합니다.');
			location.href='javascript:openLogin();';
		</script>
		<%
		return;
	}

	SimpleDateFormat sdfCurrent = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT ="-1">
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
	th{
		
		border-top: 1px solid skyblue;
		border-bottom: 1px solid lightgray;
	}
	td{
		border-bottom: 1px solid lightgray;
	}
</style>
</head>
<body>
<%@include file="../header.jsp" %>
<h2 align="center"><font color="skyblue"><%=sname%>님 쇼핑내역</font></h2>
<section>
	<article>
	<form method="POST">
		<table align="center" width="1000" style="text-align: center;">	
				<tr>
				<th>상품</th>
				<th>상품명</th>
				<th>상품금액</th>
				<th>주문상태</th>
				<th>배송상태</th>
				<th>주문날짜</th>
				</tr>		
			<%
			ArrayList<OrderDTO> arr = odao.myhomeBuyList(m_id);
			
			if(arr==null||arr.size()==0){
				%>	
				 <tr>
				 	<td colspan="6">주문내역이 없습니다.</td>
				 </tr>
					
				<%
			}else{
				for(int i=0;i<arr.size();i++){
				%>
				<tr>
					<td><img src="/myhome/img/<%=arr.get(i).getOrder_imgpath()%>" width="100" height="100">
					<td><%=arr.get(i).getOrder_goods_name()%></td>
					<td><%=arr.get(i).getOrder_goods_price()%></td>
					<td><%=arr.get(i).getOrder_state() %></td>
					<td><%=arr.get(i).getOrder_shipstate() %></td>
					<td><%=sdfCurrent.format(arr.get(i).getOrder_date())  %></td>
				</tr>	
			<%
				}
			} 
			%>			
		</table>
	</form>
	</article>
</section>
<%@include file="../footer.jsp" %>
</body>
</html>
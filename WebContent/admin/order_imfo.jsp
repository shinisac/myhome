<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.admin.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="myhome.order.*" %>
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<style>
table{
	width:500px;
	height:300px;
	padding:0px 0px 0px 0px;
	margin:10px auto;
	border-top: 2px solid #ddd;
}
table tbody{
 	text-align: center;
}
table img{
	width:100%;
	height:130px;
	margin:0px auto;
}
table tbody th{
	width:100px;
	height:40px;
	border-bottom: 2px solid #ddd;
	background-color: #EAEAEA;
}
table td{
	border-bottom: 2px solid #ddd;
 	height:40px;
}
table tfoot td{
	padding:0px 0px 0px 5px;
}
table thead td{
	height:35px;
	padding:0px 0px 0px 5px;
	font-weight: bold;
	font-size: 18px;
}
 #update{
		border: none; /*---테두리 정의---*/
	   background-Color: skyblue; /*--백그라운드 정의---*/
	   font: 12px 굴림; /*--폰트 정의---*/
	   font-weight: bold; /*--폰트 굵기---*/
	   color: white; /*--폰트 색깔---*/
	   width: 70px;
	   height: 30px; /*--버튼 크기---*/
}
</style>
</head>
<body>
<% 
	String idx_s = request.getParameter("IDX");
	int idx = Integer.parseInt(idx_s);
	OrderDTO orders = adao.orderimfo(idx);
	SimpleDateFormat sdfdate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	DecimalFormat dfprice = new DecimalFormat("#,##0");
%>
<form name="fmgoodsimfo" method="POST">
	<table>
	<thead>
		<tr>
			<td colspan="4">
				주문 상세정보 
			</td>
		</tr>
	</thead>
		<tfoot>
			<tr>
				<td colspan="4" align="center">
					<input type="button" value="닫기" onClick="window.close();" id="update">
				</td>
			</tr>	
		<tfoot>	
		<tbody>
			<tr>
				<th>주문번호</th>
				<td style="width:100px"><%=orders.getOrder_idx()%></td>
				<th>주문날짜</th>
				<td><%=sdfdate.format(orders.getOrder_date())%></td>
			</tr>
		
			<tr>
				<th>주문자</th>
				<td colspan="3"><%=orders.getOrder_member_id()%></td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3"><%=orders.getOrder_addr()%></td>
			</tr>
			<tr>
				<th>결제금액</th>
				<td>\ <%=dfprice.format(orders.getOrder_price())%></td>
				<th>결제수단</th>
				<td><%=orders.getOrder_pay()%></td>
			</tr>
		</tbody>
	</table>
</form>
</body>
</html>
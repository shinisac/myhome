<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.admin.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="myhome.goods.*"%>
<%@ page import="java.text.*" %>
<%@ page import="myhome.category.*"%>
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
</style>
</head>
<body>
<% 
	String idx_s = request.getParameter("IDX");
	int idx = Integer.parseInt(idx_s);
	GoodsDTO goods = adao.goodsLook(idx);
	CategoryDTO cate = adao.categorygoods(goods.getGoods_category());
	SimpleDateFormat sdfdate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	DecimalFormat dfprice = new DecimalFormat("#,##0");
%>
<form name="fmgoodsimfo" method="POST">
	<table>
	<thead>
		<tr>
			<td colspan="4">
				제품 상세정보 
			</td>
		</tr>
	</thead>
		<tfoot>
			<tr>
				<td colspan="4">
					<input type="button" value="닫기" onClick="window.close();">
				</td>
			</tr>	
		<tfoot>	
		<tbody>
			<tr>
				<th>상품코드</th>
				<td><%=goods.getGoods_idx()%></td>
				<th>카테고리</th>
				<td><%=cate.getCategory_goods_name()%></td>
			</tr>
		
			<tr>
				<th colspan="2" rowspan="3"><img src="/myhome/img/<%=goods.getGoods_path()%>"></th>
				<th>상품명</th>
				<td><%=goods.getGoods_name()%></td>
			</tr>
			<tr>
				<th>수량</th>
				<td><%=goods.getGoods_amount()%></td>
			</tr>
			<tr>
				<th>가격</th>
				<td><%=dfprice.format(goods.getGoods_price())%></td>
			</tr>
			<tr>
				<th colspan="1">판매 상태</th>
				<td colspan="3"><%=goods.getGoods_state()%></td>
			</tr>
			<tr>
				<th colspan="1">등록일</th>
				<td colspan="3"><%=sdfdate.format(goods.getGoods_date())%></td>
			</tr>
		</tbody>
		
	</table>
</form>
</body>
</html>
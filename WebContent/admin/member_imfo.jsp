<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.admin.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="myhome.member.*" %>
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>  
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
<style>
#main{
	width:650px;
	height:300px;
	padding:0px 0px 0px 0px;
	margin:50px auto;
	border-top: 2px solid #ddd;
}
#main tbody{
 	text-align: center;
}
#main img{
	width:100%;
	height:130px;
	margin:0px auto;
}
#main tbody th{
	width:100px;
	height:40px;
	border-bottom: 2px solid #ddd;
	background-color: #EAEAEA;
}
#main td{
	border-bottom: 2px solid #ddd;
 	height:40px;
}
#main tfoot td{
	padding:0px 0px 0px 5px;
}
#main thead td{
	height:35px;
	padding:0px 0px 0px 5px;
	font-weight: bold;
	font-size: 18px;
}
#menu{
	float:left;
	margin-top:50px;
	margin-left: 20px;
}
#menu table{
	width:180px;
}
#menu table td{
	padding:0px 0px 0px 10px;
	height: 30px;
	border-bottom: 2px solid #ddd;
	border-top: 2px solid #ddd;
	border-left: 2px solid #ddd;
	border-right:2px solid #ddd;
}
#menu table td:hover{
 	background-color: #E6FFFF;
 	 	cursor:pointer;
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
<script>
function gocart(idx){
	location.href='admin_cartdetail.jsp?idx='+idx;
}
function goorder(id){
	location.href='admin_orderdetail.jsp?id='+id;
}
function gobbs(id){
	location.href='admin_bbs_detail.jsp?id='+id;
}
function gorip(id){	
	location.href='admin_rip_detail.jsp?id='+id;
}
</script>
</head>
<body>
<header>
	<div id="mainheader">
		
		<!-- 각 메뉴의 글자를 이미지로 대체하면 좋을 것으로 예상-->
		<div id="mainmenu">
			<a id="mainimg" href="/myhome/admin/admin_main.jsp">
				<img alt="마이홈 이미지로고" src="/myhome/img/mainhomeR.jpg" width="200" height="65">
			</a>
			
			<ul>
				<li class="dropmenu">
					<a href="javascript:void(0)" class="dropbtn">상품</a>
					<div class="dropmenu-content">
						<a href="javascript:location.href='admin_goods.jsp'">상품 리스트</a>
						<a href="javascript:location.href='goods_add.jsp'">상품 등록</a>
						<a href="javascript:location.href='goods_display.jsp'">상품 진열</a>
					</div>
				</li>
				
				<li class="dropmenu">
					<a href="javascript:void(0)" class="dropbtn">주문</a>
					<div class="dropmenu-content">
						<a href="goods_oreder.jsp">입금 현황</a>
						<a href="goods_oreder2.jsp">배송 현황</a>
						<a href="javascript:location.href='admin_sales.jsp'">매출 확인</a>
					</div>
				</li>
				
				<li class="dropmenu">
					<a href="javascript:void(0)" class="dropbtn">게시판</a>
					<div class="dropmenu-content">
						<a href="admin_bbslist.jsp">게시글 리스트</a>
						<a href="admin_bbsdellist.jsp">게시글 분류</a>
					</div>
				</li>
				
				<li class="dropmenu">
					<a href="javascript:void(0)" class="dropbtn">회원</a>
					<div class="dropmenu-content">
						<a href="admin_memberlist.jsp">회원 정보</a>
					</div>				
				</li>
				
				<li class="dropmenu">
					<a href="javascript:void(0)" class="dropbtn">분류</a>
					<div class="dropmenu-content">
						<a href="category.jsp">카테고리 등록</a>
					</div>				
				</li>
			</ul>
		</div>
	</div>
</header>
<% 
	String idx_s = request.getParameter("idx");
	int idx= Integer.parseInt(idx_s);
	SimpleDateFormat sdfdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	MemberDTO memberimfo = adao.memberimfo(idx);
%>
<div style="margin:0px auto;width:900px">
	<div style="float:left;">
<form name="fmgoodsimfo" method="POST">
	<table id="main" >
	<thead>
		<tr>
			<td colspan="4">
				회원 정보
			</td>
		</tr>
	</thead>
		<tfoot>
			<tr>
				<td colspan="4" align="center">
					<input type="button" value="닫기" onClick="history.back();" id="update">
				</td>
			</tr>	
		<tfoot>	
		<tbody>
			<tr>
				<th>회원코드</th>
					<td style="width:100px">
						<%=memberimfo.getMember_idx()%>
					</td>
				<th>등급</th>
				<td><%=memberimfo.getMember_level()%></td>
			</tr>
		
			<tr>
				<th>아이디</th>
				<td colspan="3"><%=memberimfo.getMember_id()%></td>
			</tr>
			<tr>
				<th>이름</th>
				<td colspan="3"><%=memberimfo.getMember_name()%></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><%=memberimfo.getMember_birthday()%></td>
				<th>성별</th>
				<td><%=memberimfo.getMember_gen()%></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td colspan="3"><%=memberimfo.getMember_phone()%></td>
			</tr>	
			<tr>
				<th>이메일</th>
				<td colspan="3"><%=memberimfo.getMember_email()%></td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3"><%=memberimfo.getMember_addr()%></td>
			</tr>
			<tr>
				<th>가입일</th>
				<td colspan="3"><%=sdfdate.format(memberimfo.getMember_date())%></td>
			</tr>				
		</tbody>
		
	</table>
</form>
</div>
<div id="menu">
<table >
	<tr><td onclick="gocart('<%=memberimfo.getMember_idx() %>')">장바구니 내역</td></tr>
	<tr><td onclick="goorder('<%=memberimfo.getMember_id() %>')">주문 내역</td></tr>
	<tr><td onclick="gobbs('<%=memberimfo.getMember_id() %>')">등록 게시글</td></tr>
	<tr><td onclick="gorip('<%=memberimfo.getMember_id() %>')">등록 댓글</td></tr>
</table>
</div>
</div>
</body>
</html>
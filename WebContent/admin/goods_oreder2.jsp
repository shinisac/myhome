<%@page import="myhome.goods.GoodsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="myhome.bbs.*"%>
<%@ page import="myhome.member.*"%>
<%@ page import="myhome.admin.*"%>
<%@ page import="myhome.goods.*"%>
<%@ page import="myhome.order.*"%>
<%@ page import="java.text.*" %>
<jsp:useBean id="bdto" class="myhome.bbs.bbsDTO" scope="session"/>
<jsp:setProperty property="*" name="bdto" />
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session"/>
<jsp:useBean id="mdto" class="myhome.member.MemberDTO" scope="session"/>
<jsp:setProperty property="*" name="mdto" />

<jsp:useBean id="adto" class="myhome.admin.adminDTO" scope="session"/>
<jsp:setProperty property="*" name="adto" />
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=UTF-8");
	String userid = (String) session.getAttribute("aid");
if(userid==null||userid.equals("")){
	   %>
	   <script>
	   window.alert('로그인 후 이용가능한 서비스입니다.');
	   location.href='/myhome/index.jsp';
	   </script>
	   <%
	   return;//자바 코드를 멈출때 사용하는 키워드
	}
%>
<%
	int totalCnt = adao.order_getbbsTotalCnt3();//총게시물수
	int listSize = 10; //보여줄 리스트수
	int pageSize = 5; //보여줄 페이지수

	String cp_s = request.getParameter("cp");
	if (cp_s == null || cp_s.equals("")) {
		cp_s = "1";
	}
	int cp = Integer.parseInt(cp_s); //현재사용자위치

	int totalPage = totalCnt / listSize + 1;
	{
		if (totalCnt % listSize == 0)
			totalPage--;
	}
	int userGroup = cp / pageSize;
	{
		if (cp % pageSize == 0)
			userGroup--;
	}
	SimpleDateFormat sdfCurrent = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
	DecimalFormat df1 = new DecimalFormat("#,##0");
%>
<html>
<style>
 article table{
 	margin-top: 20px;
    margin-right: auto;
    margin-bottom: 0px;
    margin-left: auto;
	width:850px;
	border-collapse: collapse;
 }
 #search{
 	text-align: left;
 	background-color: #EAEAEA;
	border-bottom: 2px solid #ddd;
	height:150px;
	
 }
 #search tr{
	 border-bottom: 2px solid #ddd;
	 
 }
 #search td,#search th{
	 border-bottom: 2px solid #ddd;
	 padding:0px 0px 0px 20px;
 }
 #list{
 	text-align: center;
	width:900px;
 }
 #list th{
 	background-color: #EAEAEA;
	border-bottom: 2px solid #ddd; 	
	height:35px;
 }
 #btn{
 	text-align: center;
 }
 #list div{
 	float: left;
 	padding:0px 0px 0px 15px;
 	font-weight: bold;
 }
 #list td{
 	border-bottom: 2px solid #ddd;
 	height:30px;
 }
  #list tbody tr:hover{
 	background-color: #E6FFFF;
 	cursor:pointer;
 }
a{
 	color:black;
	text-decoration: none;
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
<head>
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
<meta  charset=UTF-8">
<title>Myhome</title>
<script>
function show(){//체크박스 모두 선택
	if(document.fm.allck1.checked==true){//체크박스가 체크됬을떄
		for(var i=0; i<document.fm.ck.length; i++){
			document.fm.ck[i].checked=true;
			
		}
	}else{
		for(var i=0; i<document.fm.ck.length; i++){
			document.fm.ck[i].checked=false;
			
		}
	}
}

function show2(){//체크박스 모두 선택
	if(document.fm2.allck2.checked==true){//체크박스가 체크됬을떄
		for(var i=0; i<document.fm2.ack.length; i++){
			document.fm2.ack[i].checked=true;
		}
	}else{
		for(var i=0; i<document.fm2.ack.length; i++){
			document.fm2.ack[i].checked=false;
			
		}
	}
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
<h2 align="center">배송현황</h2>

	<form name="fm" action="goods_oreder2_ok.jsp" method="POST">

		<table align="center" id="list">
			
			<tr>
				<th><input type="checkbox" name="allck1" onchange="show()"></th>
				<th>주문번호</th>
				<th>주문자ID</th>
	
				<th>상품이름</th>
				<th>수량</th>
			
				<th>주문금액</th>
				<th>주문주소</th>
				<th>배송상태</th>
				
				<th>주문날짜</th>
			</tr>
			<%
	ArrayList<OrderDTO> arr2=adao.orderlist2(cp, listSize);
%>
			<%
				if(arr2==null||arr2.size() == 0){
					%>
					<tr>
					<td colspan="10">등록된 주문이 없습니다.</td>
					</tr>
					<%
				}else{
					
					for(int i=0; i<arr2.size(); i++){
						%>
						<tr align="center">
							<td ><input type="checkbox" name="ck" value="<%=arr2.get(i).getOrder_idx() %>" onchange="show2()"></td>
							<td><%=arr2.get(i).getOrder_idx() %></td>
							<td><%=arr2.get(i).getOrder_member_id() %></td>
							<td><%=arr2.get(i).getOrder_goods_name() %></td>
							<td><%=arr2.get(i).getOrder_amount() %></td>
                        	<td><%=df1.format(arr2.get(i).getOrder_price()) %></td>
                        	<td><%=arr2.get(i).getOrder_addr() %></td>
                        	<td><%=arr2.get(i).getOrder_shipstate() %></td>
                        	<td><%=sdfCurrent.format(arr2.get(i).getOrder_date())%></td>
							
						</tr>
						<%
					}
				}
			%>
		
		</table>
		<p align="center">	
		<% //왼쪽 << 표시
		if(userGroup!=0){
			%><a href="goods_oreder2.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a><%
		}
			%>
	
		<% //페이지 보여주기   1,2,3,4,5 
		for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
		%>&nbsp;&nbsp;<a href="goods_oreder2.jsp?cp=<%=i%>"><%=i %></a>&nbsp;&nbsp;<%  
			if(i==totalPage) break;  //브레이크 건이유는 총페이지수가 13페이지인데 그룹때문에 15페이지까지나올때 브레이크걸어줌
		}
		%>
		<% //오른쪽 >>표시
			if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
			%><a href="goods_oreder2.jsp?cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a><%
		}
		%> 
		</p>
		
		<div align="center">
			<input type="submit" value="배송시작" id="update">
			
		</div>
		</form>
<%
	
	int totalCnt2 = adao.order_getbbsTotalCnt3_1();//총게시물수
	int listSize2 = 10; //보여줄 리스트수
	int pageSize2 = 5; //보여줄 페이지수
	
	String cp_s2 = request.getParameter("cp");
	if (cp_s2 == null || cp_s2.equals("")) {
		cp_s2 = "1";
	}
	int cp2 = Integer.parseInt(cp_s); //현재사용자위치
	
	int totalPage2 = totalCnt2 / listSize2 + 1;
	{
		if (totalCnt2 % listSize2 == 0)
			totalPage2--;
	}
	int userGroup2 = cp2 / pageSize2;
	{
		if (cp2 % pageSize2 == 0)
			userGroup2--;
	}

	ArrayList<OrderDTO> arr3=adao.orderlist3(cp, listSize);
%>
		
	<h2 align="center">배송중 현황</h2>

	<form name="fm2" action="goods_oreder3_ok.jsp">

		<table align="center" id="list">
			
			<tr>
				<th><input type="checkbox" name="allck2" onchange="show2()"></th>
				<th>주문번호</th>
				<th>주문자ID</th>
	
				<th>상품이름</th>
				<th>수량</th>
			
				<th>주문금액</th>
				<th>주문주소</th>
				<th>배송상태</th>
				
				<th>주문날짜</th>
			</tr>
			
			<%
				if(arr3==null||arr3.size() == 0){
					%>
					<tr>
					<td colspan="10">등록된 주문이 없습니다.</td>
					</tr>
					<%
				}else{
					
					for(int i=0; i<arr3.size(); i++){
						%>
						<tr align="center">
							<td ><input type="checkbox" name="ack" value="<%=arr3.get(i).getOrder_idx() %>"></td>
							<td><%=arr3.get(i).getOrder_idx() %></td>
							<td><%=arr3.get(i).getOrder_member_id() %></td>
							<td><%=arr3.get(i).getOrder_goods_name() %></td>
							<td><%=arr3.get(i).getOrder_amount() %></td>
                        	<td><%=df1.format(arr3.get(i).getOrder_price()) %></td>
                        	<td><%=arr3.get(i).getOrder_addr() %></td>
                        	<td><%=arr3.get(i).getOrder_shipstate() %></td>
                        	<td><%=sdfCurrent.format(arr3.get(i).getOrder_date()) %></td>
							
						</tr>
						<%
					}
				}
			%>
		
		</table>
		<p align="center">	
		<% //왼쪽 << 표시
		if(userGroup2!=0){
			%><a href="goods_oreder2.jsp?cp2=<%=(userGroup2-1)*pageSize2+pageSize2%>">&lt;&lt;</a><%
		}
			%>
	
		<% //페이지 보여주기   1,2,3,4,5 
		for(int i=(userGroup2*pageSize2+1);i<=(userGroup2*pageSize2+pageSize2);i++){
		%>&nbsp;&nbsp;<a href="goods_oreder2.jsp?cp2=<%=i%>"><%=i %></a>&nbsp;&nbsp;<%  
			if(i==totalPage2) break;  //브레이크 건이유는 총페이지수가 13페이지인데 그룹때문에 15페이지까지나올때 브레이크걸어줌
		}
		%>
		<% //오른쪽 >>표시
			if(userGroup2!=(totalPage2/pageSize2-(totalPage2%pageSize2==0?1:0))){
			%><a href="goods_oreder2.jsp?cp2=<%=(userGroup2+1)*pageSize2+1%>">&gt;&gt;</a><%
		}
		%> 
		</p>
		
		<div align="center">
			<input type="submit" value="배송완료" id="update">
			<input type="button" value="목록으로" onclick="location.href='admin_main.jsp'" id="update">
		</div>
		
		</form>
</body>
</html>
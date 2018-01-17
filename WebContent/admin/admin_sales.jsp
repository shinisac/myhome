<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="myhome.order.*" %>
<%@ page import="java.text.*" %>
<jsp:useBean id="adao" class="myhome.admin.adminDAO"/>   
<%request.setCharacterEncoding("UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
<style>
 #today{
 	margin-top: 70px;
    margin-right: auto;
    margin-bottom: 0px;
    margin-left: auto;
	width:850px;
	border-collapse: collapse;
 }
 
 table th{
  	background-color: #EAEAEA;
	border-bottom: 2px solid #ddd; 	
	height:35px;
 }
 #today th{
 	width:200px;
 	border: 2px solid #ddd;
 }
 #today td{
 	border: 2px solid #ddd;
 	padding: 0px 0px 0px 15px;
 	font-size: 18px;
 	font-weight: bold;
 	
 }
 #list{
 	text-align: center;
	margin:0px auto;
	width:850px;
	border-collapse: collapse;
 }
 #list td{
 	border-top:2px solid #ddd;
  	border-bottom: 2px solid #ddd;
 	height:30px;
 	padding:0px 0px 0px 0px;
 }
#listbody{
 	height:305px;
 	vertical-align: top;
  border-bottom: 2px solid #ddd;
 }
 #searchbody{
  	margin-top: 50px;
    margin-right: auto;
    margin-bottom: 0px;
    margin-left: auto;
	width:850px;
	border-collapse: collapse;
	height: 300px;
	padding:0px;
	text-align: center;
	border-bottom: 2px solid #ddd;
	
 }
  #list div{
 	float: left;
 	padding:5px 15px 0px 5px;
 	font-weight: bold;
 	height: 30px;
 }
 a{
 	color:black;
	text-decoration: none;
	font-size: 18px;
 }
 #list tbody tr:hover{
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
function openorder(idx){
	cw=530;
	ch=300;

	sw=screen.availWidth;
	sh=screen.availHeight;

	px=(sw-cw)/2;
	py=(sh-ch)/2;
	test=window.open('/myhome/admin/order_imfo.jsp?IDX='+idx,'orderimfo','left='+px+',top='+py+',width='+cw+',height='+ch);
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
<section>
	<article>
<%

	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	if(startdate==null){
		startdate="";
		enddate="";
	}
	int totalCnt = adao.salescount(startdate, enddate);//총게시물수
	int listSize = 7; //보여줄 리스트수
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

	DecimalFormat df1 = new DecimalFormat("#,##0");
	SimpleDateFormat sdfCurrent = new SimpleDateFormat ("YYYY/MM/dd HH:mm:ss");
	int todaysales = adao.todaysales();
	int todayorder = adao.todayorder();
	
%>
	<table id="today">
		<tr>
			<th>오늘 매출 현황</th>
			<td><%=df1.format(todaysales) %> 원</td>
		</tr>
		<tr>
			<th>오늘 주문 건수</th>
			<td><%=todayorder%> 건</td>
		</tr>
	</table>
	<!--날짜별 매출액 검색부분 몸체 시작 -->
	<form name="fmsales" action="admin_sales.jsp" method="POST">
	<table id="searchbody">
		<tbody>
		 <tr id="listbody">
		 	<td>
		 		<!--날짜별 매출액 결과부분 시작 -->
				<table id="list">
					<tr >
						<td colspan="6">
							<div style="float:left;">
								<input type="text" name="startdate"> ~
								<input type="text" name="enddate">
								<input type="submit" value="검색" id="update">
							</div>
							<div style="float:right;">
								매출액 <%=df1.format(adao.totalsales(startdate, enddate))%> 원
							</div>
						</td>
					</tr>
					<tr>
						<th style="width:70px">주문번호</th>
						<th style="width:80px">고객명</th>
						<th style="width:80px">결제방식</th>
						<th style="width:100px">금액</th>
						<th style="width:50px">수량</th>
						<th style="width:140px">주문일</th>	
					</tr>
<%
	ArrayList<OrderDTO> arr=adao.salessearch(startdate, enddate, cp, listSize);

				if(arr==null||arr.size()==0){
				%>
					<tr>
						<td colspan="6">주문 내역이 없습니다.</td>
					</tr>
				<%		
				}else{
					for(int i=0;i<arr.size();i++){
				%>
					<tr onClick="openorder(<%=arr.get(i).getOrder_idx()%>)">
						<td><%=arr.get(i).getOrder_idx() %></td>
						<td><%=arr.get(i).getOrder_member_id() %></td>
						<td><%=arr.get(i).getOrder_pay() %></td>
						<td><%=df1.format(arr.get(i).getOrder_price())%></td>
						<td><%=arr.get(i).getOrder_amount() %></td>
						<td><%=sdfCurrent.format(arr.get(i).getOrder_date()) %></td>
					</tr>
				<%		
					}
				}
%>					
				</table>
				<!--날짜별 매출액 결과부분 끝 -->	 	
		 	</td>
		 </tr>
		 </tbody>
		 <tfoot>
		 <tr>
		 	<td>
			<% //왼쪽 << 표시
			if(userGroup!=0){
				%><a href="admin_sales.jsp?startdate=<%=startdate %>&enddate=<%=enddate%>&cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a><%
			}
				%> 
		
			<% //페이지 보여주기   1,2,3,4,5 
			for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
				if(cp==i){%><b><%}
			%>&nbsp;<a href="admin_sales.jsp?startdate=<%=startdate %>&enddate=<%=enddate%>&cp=<%=i%>"><%=i %></a>&nbsp;<%  
				if(cp==i){%></b><%}
				if(i==totalPage) break; 
			}
			%>
			<% //오른쪽 >>표시
				if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
				%><a href="admin_sales.jsp?startdate=<%=startdate %>&enddate=<%=enddate%>&cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a><%
			}
			%> 	
		 	</td>
		 </tr>
		 </tfoot>
	</table>
	</form>
	<!--날짜별 매출액 검색부분 몸체 끝 -->

	</article>
</section>

</body>
</html>
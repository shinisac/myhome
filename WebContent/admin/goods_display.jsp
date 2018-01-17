<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="myhome.admin.*"%>
<%@ page import="myhome.goods.*"%>
<%@ page import="myhome.category.*"%>
<%@ page import="java.text.*" %>
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
<style>
#dis table{
	width:850px;
	text-align: center;
	border-collapse: collapse;
}

#dis table th{
	height:35px;
	background-color: #EAEAEA;
	border-bottom: 2px solid #ddd;

}
#dis table td{
	border-bottom: 2px solid #ddd;
}
#dis table th a{
	color:black;
	text-decoration: none;
}

#title{
	padding:0px 0px 0px 20px;
}
#look{
	padding:0px 5px 0px 0px;
}
#tdline{
	border-right: 2px solid #ddd;
}
.cnt{
	float: left;
	padding:0px 0px 0px 20px;
	font-size: 13px;
	position: absolute;
}
.listbody {
	height: 260px;
	vertical-align: top
}
#list tbody tr:hover{
 	background-color: #E6FFFF;
 	cursor:pointer;
 }
 a{
 	color:black;
	text-decoration: none;
 }
 #sub{
 	position: relative;
 	margin:20px auto 20px auto;
 	text-align: center;
 	width:40px;
 	height:40px;
 	overflow: hidden;
 	
 }
 #arrow{
	position: absolute;
 	width:85px;
 	height:40px;
 	top:0px;
 	left: -1px;
 	border: 0px;
 }
 #maintable1{
 	margin:30px auto;
 }
  #maintable2{
 	margin:0px auto;
 }
</style>
<script>
function dshow(){//체크박스 모두 선택
	var chk = document.getElementsByName('dck').length;
	if(document.getElementsByName('dallck')[0].checked==true){//체크박스가 체크됬을떄
		for(var i=0; i<chk; i++){
			document.getElementsByName('dck')[i].checked=true;	
		}
	}else{
		for(var i=0; i<chk; i++){
			document.getElementsByName('dck')[i].checked=false;
			
		}
	}
}
function ashow(){//체크박스 모두 선택
	var chk = document.getElementsByName('ack').length;
	if(document.getElementsByName('aallck')[0].checked==true){//체크박스가 체크됬을떄
		for(var i=0; i<chk; i++){
			document.getElementsByName('ack')[i].checked=true;	
		}
	}else{
		for(var i=0; i<chk; i++){
			document.getElementsByName('ack')[i].checked=false;
			
		}
	}
}
function opengoods(idx){
	cw=530;
	ch=400;

	sw=screen.availWidth;
	sh=screen.availHeight;

	px=(sw-cw)/2;
	py=(sh-ch)/2;
	test=window.open('/myhome/admin/goods_imfo.jsp?IDX='+idx,'goodsLook','left='+px+',top='+py+',width='+cw+',height='+ch);
}
function arrows(){
	var achk = document.getElementsByName('ack');
	var dchk = document.getElementsByName('dck');
	var img = document.getElementById('arrow');

	var count =0;
	for(var i=0;i<achk.length;i++){
		if(achk[i].checked==true){
			count++;
		}
	}
	for(var i=0;i<dchk.length;i++){
		if(dchk[i].checked==true){
			count++;
		}
	}
	if(count>0){
		img.style.left='-45px';
		return;
	}else{
		img.style.left='-1px';
		return;		
	}
}
</script>
</head>
<%
//진열된 상품을 위한 페이징 준비----시작
	int d_totalCnt = adao.goodsshowCount();//총게시물수
	int d_listSize = 7; //보여줄 리스트수
	int d_pageSize = 5; //보여줄 페이지수

	String d_cp_s = request.getParameter("d_cp");
	if (d_cp_s == null || d_cp_s.equals("")) {
		d_cp_s = "1";
	}
	int d_cp = Integer.parseInt(d_cp_s); //현재사용자위치

	int d_totalPage = d_totalCnt / d_listSize + 1;
	{
		if (d_totalCnt % d_listSize == 0)
			d_totalPage--;
	}
	int d_userGroup = d_cp / d_pageSize;
	{
		if (d_cp % d_pageSize == 0)
			d_userGroup--;
	}
//진열된 상품을 위한 페이징 준비----끝
//진열대기 상품을 위한 페이징 준비----시작
	int a_totalCnt = adao.goodsnoshowCount();//총게시물수
	int a_listSize = 7; //보여줄 리스트수
	int a_pageSize = 5; //보여줄 페이지수

	String a_cp_s = request.getParameter("a_cp");
	if (a_cp_s == null || a_cp_s.equals("")) {
		a_cp_s = "1";
	}
	int a_cp = Integer.parseInt(a_cp_s); //현재사용자위치

	int a_totalPage = a_totalCnt / a_listSize + 1;
	{
		if (a_totalCnt % a_listSize == 0)
			a_totalPage--;
	}
	int a_userGroup = a_cp / a_pageSize;
	{
		if (a_cp % a_pageSize == 0)
			a_userGroup--;
	}
//진열대기 상품을 위한 페이징 준비----끝	
%>
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
	ArrayList<CategoryDTO> cate = adao.categoryList();
	SimpleDateFormat sdfdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat dfprice = new DecimalFormat("#,##0");
	ArrayList<GoodsDTO> dis=adao.goodsDisplaylist(d_cp, d_listSize);
	ArrayList<GoodsDTO> nodis=adao.goodsnoDisplaylist(a_cp, a_listSize);
%>	
<section>
	<article id="dis">
		<form name="fmdisplay" action="goods_display_ok.jsp" method="POST">
		<table id="maintable1">
			<tbody>
			<tr class="listbody">
				<td>
				
					<table id="list" >	
					<thead>
					<tr>
						<th id="cnt" colspan="6"><div class="cnt">총 <%=d_totalCnt %>건</div><div>진열된 상품</div></td>
					</tr>	
						<tr>
							<th><input type="checkbox" name="dallck" onclick="dshow();arrows()"></th>
							<th>상품코드</th>
							<th>상품명</th>
							<th>가격</th>
							<th>수량</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<%
							if(dis==null||dis.size() == 0){
								%>
								<tr>
								<td colspan="6">진열된 상품이 없습니다.</td>
								</tr>
								<%
							}else{
								
								for(int i=0; i<dis.size(); i++){
									%>
									<tr align="center" >
										<td ><input type="checkbox" name="dck" value="<%=dis.get(i).getGoods_idx() %>" onClick="arrows()"></td>
										<td onClick="opengoods(<%=dis.get(i).getGoods_idx()%>)"><%=dis.get(i).getGoods_idx() %></td>
										<td onClick="opengoods(<%=dis.get(i).getGoods_idx()%>)" ><%=dis.get(i).getGoods_name() %></td>
										<td onClick="opengoods(<%=dis.get(i).getGoods_idx()%>)"><%=dfprice.format(dis.get(i).getGoods_price()) %></td>
										<td onClick="opengoods(<%=dis.get(i).getGoods_idx()%>)"><%=dis.get(i).getGoods_amount() %></td>
										<td onClick="opengoods(<%=dis.get(i).getGoods_idx()%>)"><%=sdfdate.format(dis.get(i).getGoods_date()) %></td>	
									</tr>
									<%
								}
							}
						%>
						</tbody>

					</table>
				</td>
			</tr>
			</tbody>
				<tfoot>
						<tr>
							<td colspan="6">
								<% //왼쪽 << 표시
								if(d_userGroup!=0){
									%><a href="goods_display.jsp?a_cp=<%=a_cp%>&d_cp=<%=(d_userGroup-1)*d_pageSize+d_pageSize%>">&lt;&lt;</a><%
								}
									%>
							
								<% //페이지 보여주기   1,2,3,4,5 
								for(int i=(d_userGroup*d_pageSize+1);i<=(d_userGroup*d_pageSize+d_pageSize);i++){
									if(d_cp==i){%><b><%}
								%>&nbsp;<a href="goods_display.jsp?a_cp=<%=a_cp%>&d_cp=<%=i%>"><%=i %></a>&nbsp;<%  
									if(d_cp==i){%></b><%}
									if(i==d_totalPage) break;  //브레이크 건이유는 총페이지수가 13페이지인데 그룹때문에 15페이지까지나올때 브레이크걸어줌
								}
								%>
								<% //오른쪽 >>표시
									if(d_userGroup!=(d_totalPage/d_pageSize-(d_totalPage%d_pageSize==0?1:0))){
									%><a href="goods_display.jsp?a_cp=<%=a_cp%>&d_cp=<%=(d_userGroup+1)*d_pageSize+1%>">&gt;&gt;</a><%
								}
								%> 
							</td>
						</tr>
				</tfoot>	
		</table>

<div id="sub"><input id="arrow" type="image" border="0" src="/myhome/img/arrows.png"></div>



		<table id="maintable2">
		<tbody >
		<tr  class="listbody">
			<td>
				<table id="list" >	
					<thead>
						<tr>
							<th id="cnt" colspan="6"><div class="cnt">총 <%=a_totalCnt %>건</div><div>진열 대기 상품</div></td>
						</tr>	
						<tr>
							<th><input type="checkbox" name="aallck" onclick="ashow();arrows()"></th>
							<th>상품코드</th>
							<th>상품명</th>
							<th>가격</th>
							<th>수량</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
					<%
						if(nodis==null||nodis.size() == 0){
							%>
							<tr>
							<td colspan="6">등록된 상품이 없습니다.</td>
							</tr>
							<%
						}else{
							
							for(int i=0; i<nodis.size(); i++){
								%>
								<tr align="center" >
									<td ><input type="checkbox" name="ack" value="<%=nodis.get(i).getGoods_idx() %>" onClick="arrows()"></td>
									<td onClick="opengoods(<%=nodis.get(i).getGoods_idx()%>)"><%=nodis.get(i).getGoods_idx() %></td>
									<td onClick="opengoods(<%=nodis.get(i).getGoods_idx()%>)" ><%=nodis.get(i).getGoods_name() %></td>
									<td onClick="opengoods(<%=nodis.get(i).getGoods_idx()%>)"><%=dfprice.format(nodis.get(i).getGoods_price()) %></td>
									<td onClick="opengoods(<%=nodis.get(i).getGoods_idx()%>)"><%=nodis.get(i).getGoods_amount() %></td>
									<td onClick="opengoods(<%=nodis.get(i).getGoods_idx()%>)"><%=sdfdate.format(nodis.get(i).getGoods_date()) %></td>	
								</tr>
								<%
							}
						}
					%>
					</tbody>
	
				</table>
			</td>
		</tr>
		</tbody>

			<tfoot>
				<tr>
					<td colspan="6">
						<% //왼쪽 << 표시
						if(a_userGroup!=0){
						%><a href="goods_display.jsp?d_cp=<%=d_cp%>&a_cp=<%=(a_userGroup-1)*a_pageSize+a_pageSize%>">&lt;&lt;</a><%
						}
						%>
									
						<% //페이지 보여주기   1,2,3,4,5 
						for(int i=(a_userGroup*a_pageSize+1);i<=(a_userGroup*a_pageSize+a_pageSize);i++){
						if(a_cp==i){%><b><%}
						%>&nbsp;<a href="goods_display.jsp?d_cp=<%=d_cp%>&a_cp=<%=i%>"><%=i %></a>&nbsp;<%  
						if(a_cp==i){%></b><%}
						if(i==a_totalPage) break;  //브레이크 건이유는 총페이지수가 13페이지인데 그룹때문에 15페이지까지나올때 브레이크걸어줌
						}
						%>
						<% //오른쪽 >>표시
						if(a_userGroup!=(a_totalPage/a_pageSize-(a_totalPage%a_pageSize==0?1:0))){
						%><a href="goods_display.jsp?d_cp=<%=d_cp%>&a_cp=<%=(a_userGroup+1)*a_pageSize+1%>">&gt;&gt;</a><%
						}
						%> 
					</td>
				</tr>
			</tfoot>		

		</table>
			
		</form>
</article>
</section>
</body>
</html>
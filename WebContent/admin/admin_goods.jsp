<%@page import="java.text.DecimalFormat"%>
<%@page import="myhome.goods.GoodsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="myhome.bbs.*"%>
<%@ page import="myhome.member.*"%>
<%@ page import="myhome.admin.*"%>
<%@ page import="myhome.goods.*"%>
<%@ page import="myhome.category.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%	
request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=UTF-8");
%>
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
	String goods_name=request.getParameter("goods_name");
	String goods_category=request.getParameter("goods_category");
	String minprice = request.getParameter("minprice");
	String maxprice = request.getParameter("maxprice");
	int chs = 0;
	if(goods_name==null){
		goods_name="";
		goods_category="";
		minprice="";
		maxprice="";
	}
	
	if(minprice.equals("")&&maxprice.equals("")){
		chs=1;
	}
	int totalCnt = adao.store_getbbsTotalCnt(chs,goods_name,goods_category,minprice,maxprice);//총게시물수
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
%>
<html>
<head>
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
<meta  charset=UTF-8">
<title>Myhome</title>
<style>
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

function show(){//체크박스 모두 선택
	var chk = document.getElementsByName('ck').length;
	if(document.getElementsByName('allck')[0].checked==true){//체크박스가 체크됬을떄
		for(var i=0; i<chk; i++){
			document.getElementsByName('ck')[i].checked=true;	
		}
	}else{
		for(var i=0; i<chk; i++){
			document.getElementsByName('ck')[i].checked=false;
			
		}
	}
}


function goodsDel(){
	var chk = document.getElementsByName('ck').length;
	var count=0;
	for(var i=0; i<chk; i++){
		if(document.getElementsByName('ck')[i].checked==true){count++;}	
	}
	if(count>0){
		fmbody.submit();

	}else{
		alert('삭제할 상품을 선택해주세요.');
		return;
	}
	
}
function minprice(obj){
	document.fmgoods.minprice.value = obj.value;
}
function maxprice(obj){
	document.fmgoods.maxprice.value = obj.value;
}
function search(){
	if(document.fmgoods.minsprice.value!='' && document.fmgoods.maxsprice.value==''){
		document.fmgoods.minprice.value=document.fmgoods.minsprice.value;
		document.fmgoods.maxprice.value='999999999';
	}else if(document.fmgoods.minsprice.value==''&&document.fmgoods.maxsprice.value!=''){
		document.fmgoods.minprice.value='0';
		document.fmgoods.maxprice.value=document.fmgoods.maxsprice.value;
	}

	fmgoods.submit();
}
function opengoods(idx){
	cw=530;
	ch=400;

	sw=screen.availWidth;
	sh=screen.availHeight;

	px=(sw-cw)/2;
	py=(sh-ch)/2;
	test=window.open('/myhome/admin/admin_goodsLook.jsp?IDX='+idx,'goodsLook','left='+px+',top='+py+',width='+cw+',height='+ch);
}
</script>
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
</style>
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
						<a href="goods_oreder.jsp">주문 현황</a>
						<a href="javascript:location.href='admin_sales.jsp'">매출 확인</a>
					</div>
				</li>
				
				<li class="dropmenu">
					<a href="admin_bbslist.jsp" class="dropbtn">게시판</a>
					<div class="dropmenu-content">
						<a href="admin_bbslist.jsp"  >게시글 리스트</a>
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
	
		<h2 align="center">상품 리스트</h2>
<%	
	ArrayList<CategoryDTO> cate = adao.categoryList();
	SimpleDateFormat sdfdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat dfprice = new DecimalFormat("#,##0");
	ArrayList<GoodsDTO> arr=adao.goodslist(chs,goods_name,goods_category,minprice,maxprice,cp, listSize);
%>		<form name="fmgoods" action="admin_goods.jsp" method="POST">
			<table id="search" >
			
				<tr>
					<th>상품명</th>
					<td><input type="text" name="goods_name"></td>
				</tr>
				<tr>
					<th>카테고리명</th>
					<td>
						<select name="goods_category">
							<option value="">모두 검색</option>
							<%
							if(!(cate==null||cate.size()==0)){
	
								for(int j=0;j<cate.size();j++){
									%>
									<option value="<%=cate.get(j).getCategory_goods_num() %>"><%=cate.get(j).getCategory_goods_name()%></option>
									<%		
								}
	
							}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>가격</th>
					<td><input type="text" name="minsprice" onBlur="minprice(this)"><input type="hidden" name="minprice"> ~ <input type="text" name="maxsprice" onBlur="maxprice(this)"><input type="hidden" name="maxprice"></td>
				</tr>
				<tr>
				<td colspan="2" id="btn">
					<input type="button" value="검색" onClick="search();" id="update">
				</td>
				</tr>
			</table>
		</form>
		
		
		<form name="fmbody" action="admin_goodsDel.jsp">
			<table id="list" >	
			<thead>
			<tr>
				<th id="cnt" colspan="6"><div>총 <%=totalCnt %>건</div></td>
			</tr>	
				<tr>
					<th><input type="checkbox" name="allck" onclick="show()"></th>
					<th>상품코드</th>
					<th>상품명</th>
					<th>가격</th>
					<th>수량</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<%
					if(arr==null||arr.size() == 0){
						%>
						<tr>
						<td colspan="6">등록된 상품이 없습니다.</td>
						</tr>
						<%
					}else{
						
						for(int i=0; i<arr.size(); i++){
							%>
							<tr align="center" >
								<td ><input type="checkbox" name="ck" value="<%=arr.get(i).getGoods_idx() %>" onchange="show2()"></td>
								<td onClick="opengoods(<%=arr.get(i).getGoods_idx()%>)"><%=arr.get(i).getGoods_idx() %></td>
								<td onClick="opengoods(<%=arr.get(i).getGoods_idx()%>)" ><%=arr.get(i).getGoods_name() %></td>
								<td onClick="opengoods(<%=arr.get(i).getGoods_idx()%>)"><%=dfprice.format(arr.get(i).getGoods_price()) %></td>
								<td onClick="opengoods(<%=arr.get(i).getGoods_idx()%>)"><%=arr.get(i).getGoods_amount() %></td>
								<td onClick="opengoods(<%=arr.get(i).getGoods_idx()%>)"><%=sdfdate.format(arr.get(i).getGoods_date()) %></td>	
							</tr>
							<%
						}
					}
				%>
				</tbody>	
			</table>
		</form>
			<p align="center">	
			<% //왼쪽 << 표시
			if(userGroup!=0){
				%><a href="admin_goods.jsp?goods_name=<%=goods_name %>&goods_category=<%=goods_category %>&minprice=<%=minprice%>&maxprice=<%=maxprice%>&cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a><%
			}
				%>
		
			<% //페이지 보여주기   1,2,3,4,5 
			for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
				if(cp==i){%><b><%}
			%>&nbsp;&nbsp;<a href="admin_goods.jsp?goods_name=<%=goods_name %>&goods_category=<%=goods_category %>&minprice=<%=minprice%>&maxprice=<%=maxprice%>&cp=<%=i%>"><%=i %></a>&nbsp;&nbsp;<%  
				if(cp==i){%></b><%}
				if(i==totalPage) break;  //브레이크 건이유는 총페이지수가 13페이지인데 그룹때문에 15페이지까지나올때 브레이크걸어줌
			}
			%>
			<% //오른쪽 >>표시
				if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
				%><a href="admin_goods.jsp?goods_name=<%=goods_name %>&goods_category=<%=goods_category %>&minprice=<%=minprice%>&maxprice=<%=maxprice%>&cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a><%
			}
			%> 
			</p>
			
			<div align="center">
				<input type="button" value="상품삭제" onclick="goodsDel()" id="update">
				<input type="button" value="처음으로" onclick="location.href='admin_main.jsp'" id="update">
			</div>
	
	</article>
</section>

</body>
</html>
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
<jsp:useBean id="bdto" class="myhome.bbs.bbsDTO" scope="session"/>
<jsp:setProperty property="*" name="bdto" />
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session"/>
<jsp:useBean id="mdto" class="myhome.member.MemberDTO" scope="session"/>
<jsp:setProperty property="*" name="mdto" />

<jsp:useBean id="adto" class="myhome.admin.adminDTO" scope="session"/>
<jsp:setProperty property="*" name="adto" />
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>
<!DOCTYPE html>

<html>
<head>
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
<meta  charset=UTF-8">
<title>Myhome</title>
<script>
function show(){//체크박스 모두 선택
	if(document.fm.allck.checked==true){//체크박스가 체크됬을떄
		for(var i=0; i<document.fm.ck.length; i++){
			document.fm.ck[i].checked=true;
		}
	}else{
		for(var i=0; i<document.fm.ck.length; i++){
			document.fm.ck[i].checked=false;
		}
	}
}

function categoryAdd(){
	window.open('categoryadd.jsp','category','width=600, height=350');
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
<%
	ArrayList<CategoryDTO> arr=adao.categoryList();
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
<h2 align="center">카테고리관리</h2>
	<%for(int i=0; i<arr.size(); i++){ %>
	<form name="fm" action="categoryDel_ok.jsp" method="POST">
	<%} %>
		<table id="list" width="1000" align="center">
			<tr>
				<th><input type="checkbox" name="allck" onchange="show()"></th>
				<th>이미지</th>
				<th>번호</th>
				<th>종류</th>
			</tr>
			<%
				if(arr==null||arr.size() == 0){
					%>
					<tr>
					<td colspan="8">등록된 카테고리가 없습니다.</td>
					</tr>
					<%
				}else{
					
					for(int i=0; i<arr.size(); i++){
						%>
						<tr align="center">
							<td><input type="checkbox" name="ck" value="<%=arr.get(i).getCategory_goods_num() %>"></td>
							<td><img src="../img/<%=arr.get(i).getCategory_goods_imgpath() %>" width="82"height="100"></td>
							<td><%=arr.get(i).getCategory_goods_num() %></td>
							<td><%=arr.get(i).getCategory_goods_name() %></td>
						</tr>
						<%
					}
				}
			%>
		
		</table>
		<br>
		<br>
		<div align="center">
			<input type="button" value="등록" onclick="categoryAdd()" id="update">
			<input type="submit" value="삭제" id="update">
			<input type="button" value="목록으로" onclick="location.href='admin_main.jsp'" id="update">
		</div>
		
	
	</form>
</body>
</html>
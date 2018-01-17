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
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
<style>
table{
	padding:0px 0px 0px 0px;
	margin:50px auto;
	border-top: 2px solid #ddd;
	height:300px;
}


table tbody th{
	height:30px;
	border-bottom: 2px solid #ddd;
	background-color: #EAEAEA;
	text-align: center;
	width:180px;
}
table td{
	border-bottom: 2px solid #ddd;
 	height:40px;
}
table tbody td{
	padding:0px 0px 0px 10px;
}
table tfoot td{
	padding:5px 0px 5px 10px;
}
table thead td{
	height:40px;
	padding:0px 0px 0px 5px;
	font-weight: bold;
	font-size: 18px;
}
table textarea{
	resize: none;
	padding:5px;
	letter-sspacing:120%;
	line-height:150%;
}
#imgtext{
border:0; 
font-Weight:bold;

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

function textchk(obj){
	
	var patterns = /^[0-9]+$/;
	
	if(document.fm.name.value=='')
	{ 
		alert('상품명을 입력해주세요');
		return false;
	}
	else if(document.fm.amount.value==''||!document.fm.amount.value.match(patterns))
	{
		alert('수량을 확인해주세요');
		return false;
	}
	else if(document.fm.price.value==''||!document.fm.price.value.match(patterns))
	{
		alert('가격을 확인해주세요');
		return false;
	}else if(document.fm.img.value==''){
		alert('이미지를 등록해주세요');
		return false;
	}else if(document.fm.content.value==''){
		alert('상품내용이미지를 등록해주세요');
		return false;
	}
			
}

function imgchk(img){
		var pattern = /.+(\.jpg|\.gif|\.bmp|\.png|\.jpeg)+$/gi;
		var obj= document.getElementById('fileimg');
		if(!img.match(pattern)){
			alert('이미지 파일만 업로드 가능합니다.');
			obj.outerHTML=obj.outerHTML;
			return;
		}
		
		simgpath(img);
		return;
}

function simgpath(obj){
	
	var path = obj;
	var file = path.substring(path.lastIndexOf('\\')+1,path.length);
	fm.imgpath.value=file;
	
}

function cimgchk(img){
		var pattern = /.+(\.jpg|\.gif|\.bmp|\.png|\.jpeg)+$/gi;
		var obj= document.getElementById('cfileimg');
		if(!img.match(pattern)){
			alert('이미지 파일만 업로드 가능합니다.');
			obj.outerHTML=obj.outerHTML;
			return;
		}
		cimgpath(img);
		return;
}

function cimgpath(obj){
	var path = obj;
	var file = path.substring(path.lastIndexOf('\\')+1,path.length);
	fm.cimgpath.value=file;
	
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
	ArrayList<CategoryDTO> catelist = adao.categoryList();

%>

<section>
	<article>
		<form name="fm" action="goods_add_ok.jsp?" method="post" enctype="multipart/form-data" onsubmit="return textchk(this.form)">
			<table>
				<tfoot>
					<tr >
						<td colspan="3" align="center">
						<input type="submit" value="등록" id="update">
						<input type="reset" value="다시작성" id="update">
						</td>
					</tr>
				</tfoot>			
				<thead>
					<tr>
						<td colspan="3">
							제품 정보 등록
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>카테고리</th>
						<td colspan="2">
	<%
							if(catelist==null||catelist.size()==0){
								%>
								<script>
								window.alert('카테고리가 존재하지않습니다. 카테고리메뉴에서 등록해주세요.');
								window.close();
								</script>
								<%	
								return;
							}else{
								%>
								<select name="category">
									<%
									for(int i=0;i<catelist.size();i++){
										%>
										<option value="<%=catelist.get(i).getCategory_goods_num() %>"><%=catelist.get(i).getCategory_goods_name() %></option>
										<%		
									}	
									%>
								</select>
								<%	
							}				
		%>	
						</td>
					</tr>
					<tr>
						<th>상품명</th>
						<td colspan="2">
							<input type="text" name="name">
							<input type="hidden" name="state" value="입고">
						</td>
					</tr>
					<tr>
						<th>수량</th>
						<td colspan="2"><input type="text" name="amount"></td>
					</tr>				
					<tr>
						<th>가격</th>
						<td colspan="2"><input type="text" name="price"></td>
					</tr>
					<tr>
							<th>이미지</th>
							<td><input type="text" id="imgtext" name="imgpath" readOnly></td>
							<td><input type="file" id="fileimg" name="img" onchange="imgchk(this.value)"></td>
					</tr>
					<tr>
							<th>상품 내용 이미지</th>
							<td><input type="text" id="imgtext" name="cimgpath" readOnly></td>
							<td><input type="file" id="cfileimg" name="content" onchange="cimgchk(this.value)"></td>
					</tr>
				</tbody>	

			</table>
		</form>
	
	</article>
</section>
</body>
</html>
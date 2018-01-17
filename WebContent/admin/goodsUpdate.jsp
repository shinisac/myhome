<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.admin.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="myhome.goods.*"%>
<%@ page import="java.text.*" %>
<%@ page import="myhome.category.*"%>
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>
<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<style>
table{
	width:500px;
	height:380px;
	padding:0px 0px 0px 0px;
	margin:10px auto;
	border-top: 2px solid #ddd;
}
table th{
	width:100px;
}

table tbody th{
	height:30px;
	border-bottom: 2px solid #ddd;
	background-color: #EAEAEA;
	text-align: center;
}
table td{
	border-bottom: 2px solid #ddd;
 	height:30px;
}
table tbody td{
	padding:0px 0px 0px 10px;
}
table tfoot td{
	padding:5px 0px 5px 10px;
}
table thead td{
	height:35px;
	padding:0px 0px 0px 5px;
	font-weight: bold;
	font-size: 18px;
}
#fileimg{
	width:180px;
}
#imgtext{
border:0; 
font-Weight:bold;

}
#fileimg2{
	width:180px;
}
#imgtext2{
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
	
	if(obj.name.value==''){
		alert('상품명을 입력해주세요');
		return false;
	}else if(obj.price.value==''||!obj.price.value.match(patterns)){
		alert('가격을 확인해주세요');
		return false;
	}else if(obj.amount.value==''||!obj.amount.value.match(patterns)){
		alert('수량을 확인해주세요');
		return false;
	}else if(obj.imgpath.value==''){
		alert('내용이미지를 등록해주세요');
		return false;
	}else if(obj.imgpath2.value==''){
		alert('상품이미지를 등록해주세요');
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


function imgchk2(img){
		var pattern = /.+(\.jpg|\.gif|\.bmp|\.png|\.jpeg)+$/gi;
		var obj= document.getElementById('fileimg2');
		if(!img.match(pattern)){
			alert('이미지 파일만 업로드 가능합니다.');
			obj.outerHTML=obj.outerHTML;
			return;
		}
		simgpath2(img);//이미지 텍스트 초기화메소드
		return;
	}
function simgpath2(obj){
	var path = obj;
	var file = path.substring(path.lastIndexOf('\\')+1,path.length);
	fm.imgpath2.value=file;
	
}
</script>
</head>
<%
	String idx_s = request.getParameter("IDX");
	int idx = Integer.parseInt(idx_s);
	GoodsDTO goods = adao.goodsLook(idx);
	CategoryDTO cate = adao.categorygoods(goods.getGoods_category());
	ArrayList<CategoryDTO> catelist = adao.categoryList();
%>
<body>
<section>
	<article>
		<form name="fm" action="goodsUpdate_ok.jsp?idx=<%=idx_s%>" method="post" enctype="multipart/form-data" onsubmit="return textchk(this)">
			<table >
				<tfoot>

					<tr>
						<td colspan="3" align="center">
						<input type="submit" value="수정" id="update">
						<input type="reset" value="다시작성" id="update">
						<input type="button" value="돌아가기" onClick="history.back();" id="update">
						</td>
					</tr>
				</tfoot>
				<thead>
					<tr>
						<td colspan="3">상품 정보 수정</td>
					</tr>
				</thead>			
				<tbody>	
				
					<tr>
						<th>상품명</th>
						<td colspan="2">
							<input type="text" name="name" value="<%=goods.getGoods_name() %>">
							<input type="hidden" name="idx" value="<%=idx_s%>">
						</td>
					</tr>	
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
									<option value="<%=catelist.get(i).getCategory_goods_num() %>" <%if(cate.getCategory_goods_num()==catelist.get(i).getCategory_goods_num()){%>selected<%}%>><%=catelist.get(i).getCategory_goods_name() %></option>
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
						<th>가격</th>
						<td colspan="2"><input type="text" name="price" value=<%=goods.getGoods_price() %>></td>
					</tr>
					<tr>
						<th>수량</th>
						<td colspan="2"><input type="text" name="amount" value=<%=goods.getGoods_amount() %>></td>
					</tr>
					<tr>
	                  <th>내용 이미지</th>
	                  <td><input type="text" id="imgtext" name="imgpath" value="<%=goods.getGoods_content()%>" readOnly></td>
	                  <td><input type="file" id="fileimg" name="content" onChange ="imgchk(this.value)"></td>
	               </tr>
					<tr>
						<th>판매 상태</th>
						<td colspan="2">
							<input id="radio1" type="radio" name="sl" value="입고" <%if(goods.getGoods_state().equals("입고")){%>checked<%}%>><label for="radio1">입고</label>
							<input id="radio2" type="radio" name="sl" value="게시"<%if(goods.getGoods_state().equals("게시")){%>checked<%}%>><label for="radio2">게시</label>
							
						</td>
					</tr>
					<tr>
						<th>상품 이미지</th>
						<td><input type="text" id="imgtext2" name="imgpath2" value="<%=goods.getGoods_path()%>" readOnly></td>
						<td><input type="file" id="fileimg2" name="img2" onchange="imgchk2(this.value)"></td>
					</tr>
				</tbody>	
			</table>
		</form>
	
	</article>
</section>
</body>
</html>
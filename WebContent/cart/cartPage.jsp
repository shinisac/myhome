<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>   
<%@ page import="myhome.cart.*" %>  
<%@ page import="myhome.member.*" %> 
<%@ page import="java.text.*" %> 
<jsp:useBean id="cdao" class="myhome.cart.CartDAO" />
<jsp:useBean id="mdao" class="myhome.member.MemberDAO" />
<%request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=UTF-8"); %>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 

if(session.getAttribute("sid")==null){
%>
<script>
	alert('로그인이 필요한 페이지입니다.');
	location.replace('/myhome');
</script>
<%	
	return;
}

%>

<script>
    function openLogin() {
		window.open('/myhome/member/login.jsp','login','width=1000,height=550');
		history.back();
	}
</script>
<% 
    String m_id=(String) session.getAttribute("sid");
	
	if(m_id==null||m_id.equals("")){
		%>
		<script>
			window.alert('로그인 후 이용가능한 서비스입니다.');
			location.href='javascript:openLogin();';
		</script>
		<%
		return;
	}
	MemberDTO mdto = mdao.memberSearch(m_id);
	
	int idx = mdto.getMember_idx();

%>
<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Pragma" content="no-cache">
   <meta HTTP-EQUIV="Expires" CONTENT ="-1">
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
table{
	width:800px;
	height:auto;
	margin:0px auto;
}

article table img{
	width:60px;
	height:70px;
}
article table div img{
	width:300px;
	height:225px;
}

.dropdowns
{
    position: relative;
}
.dropdowns-content
{
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}
.dropdowns:hover .dropdowns-content
{
    display: block;
}
.names
{
    padding: 15px;
    text-align: center;
}
#id{
	text-align:center;
}
.border th,td{
	border-bottom: 1px solid #ddd;
}
.maintable{
	padding:15px;
	border: 1px solid #ddd;
	border-collapse: collapse;
	margin: 6px 0px 6px 0px;
	
}
#total{
	font-size:25px;
	font-weight: bold;
}
#button{
	text-align:right;
}
	.buttonimg{
		border: none; /*---테두리 정의---*/
	   background-Color: skyblue; /*--백그라운드 정의---*/
	   font: 12px 굴림; /*--폰트 정의---*/
	   font-weight: bold; /*--폰트 굵기---*/
	   color: white; /*--폰트 색깔---*/
	   margin-right:1px;
	   margin-left:1px;
	   margin-bottom:3px;
	   height: 30px; /*--버튼 크기---*/
	}
</style>
<script>
function openchk(){
	var chk = document.getElementsByName('chk_cart_goods').length;
	for(i=0; i<chk; i++){
		document.getElementsByName('chk_cart_goods')[i].checked = true;
	}
}
function chkstate(){
	var chk =document.getElementsByName('chk_cart_goods');
	var state = document.getElementsByName("chk_state");
	for(i=0; i<chk.length; i++){
		if(chk[i].checked==true){	
			state[i].value='on';
		}else{
			state[i].value='off';
		}

	}
}
function orderOpen(obj){
	   var state = document.getElementsByName("chk_state");
	   var idx = document.getElementsByName("hi_goods_idx");
	   var amount = document.getElementsByName("amount");   
	   var price = document.getElementsByName("price");   
	   var hidx = document.getElementsByName("hi_idx");
	   var chk = document.getElementsByName('chk_cart_goods');
	   var count = 0;
	   for(i=0; i<chk.length; i++){
	      if(chk[i].checked==true){
	         count++;
	      }
	   }
	   if(count==0){
	      alert('선택된 상품이 없습니다.');
	      return;
	   }
	   for(i=0; i<state.length; i++){
	      if(state[i].value=='off'){
	         state[i].disabled = true;
	         idx[i].disabled = true;
	         amount[i].disabled = true;
	         price[i].disabled= true;
	         hidx[i].disabled= true;
	      }

	   }
	   obj.action='orderPage.jsp';
	   obj.submit();
	}
function cartamount(idx,am){

	location.href='cartAmount.jsp?idx='+idx+',amount='+am;
	
}
function cart_del(idx){
	
	location.href='cartDel.jsp?idx='+idx;
}
function chkDel(obj){
	   
	   var chk = document.getElementsByName('chk_cart_goods');
	   var count = 0;
	   for(i=0; i<chk.length; i++){
	      if(chk[i].checked==true){
	         count++;
	      }
	   }
	   if(count==0){
	      alert('선택된 상품이 없습니다.');
	      return;
	   }
	   obj.action='cartDel.jsp';
	   obj.submit();

	}

function amountupdate(obj){
	obj.action='cartAmount.jsp';
	obj.submit();
}

function allchkt(){
	
	var chk = document.getElementsByName('chk_cart_goods').length;
	var state = document.getElementsByName("chk_state");
	
	for(i=0; i<chk; i++)
		{
			document.getElementsByName('chk_cart_goods')[i].checked = true;
			state[i].value='on';
		}
	totalprice();
}

function allchkf(){
	var chk = document.getElementsByName('chk_cart_goods').length;
	var state = document.getElementsByName("chk_state");
	for(i=0; i<chk; i++)
		{
			document.getElementsByName('chk_cart_goods')[i].checked = false;
			state[i].value='off';
		}
	totalprice();
}
function totalprice(){
	
	var total = document.getElementsByName("amount");
	var price = document.getElementsByName("price");
	var state = document.getElementsByName("chk_state");
	var j = 0;
	
	for(var i = 0;i<total.length;i++){
		if(state[i].value=='on'){
			var result = parseInt(total[i].value)*parseInt(price[i].value);
			j+=parseInt(result);
		}
		
	}
	
	document.getElementById("tprice").innerText= '총 주문금액  : '+commas(j)+' 원';
	
}
function amountchge(obj){
	
	var state = document.getElementsByName("chk_state");
	var amount = document.getElementsByName("amount");	
	var hidx = document.getElementsByName("hi_idx");	
	obj.action='cartAmount.jsp';
	obj.submit();
}
function commas(num){
	if(isNaN(num)) return num;
	var reg = /(^[+-]?\d+)(\d{3})/; 
	var rep = num + '';                        
	while (reg.test(rep)) rep = rep.replace(reg, '$1' + ',' + '$2');
	return rep;
	}
	
function goShopping(){
	location.href="/myhome/store/myhomeStoreList.jsp";
}
</script>
</head>
<body onLoad="openchk()">
<%@include file="../header.jsp" %>
<section>
<article>
<%
int total_price=0;
DecimalFormat df1 = new DecimalFormat("#,##0");

%>
<form name="fm_cart" action="" method="post">
<table style="margin-top: 50px;margin-bottom: 50px;">
	<tr >
		<td style="padding-bottom: 5px; padding-top: 5px;" >
			<input class="buttonimg" type="button" value="전체선택" onClick="allchkt()";>
			<input class="buttonimg" type="button" value="선택해지" onClick="allchkf()";>
			<input class="buttonimg" type="button" value="선택상품삭제" onClick="chkDel(this.form)">
			<br>
			<table  class="maintable">
			
				<thead>
					<tr class="maintable">
						<th colspan="3" width="120px" >
							상품명
						</th>
						<th width="140px" >
							상품금액
						</th>
						<th width="100px">
							수량
						</th>
						<th width="160px">
							주문금액
						</th>
						<th width="50px">
							
						</th>	
					</tr>
					</thead>
						<!-- jsp 영역 시작 // 현재 로그인된 아이디의 장바구니의 내역을 가져와서 뿌린다. -->
				<tbody>
				<tr>
						<td colspan="7" style="padding:10px 10px 20px 10px;">
				<%
				
				ArrayList<CartDTO> arr = cdao.cartList(idx);
				
				if(arr==null||arr.size()==0){
					%>	
						<table>
							<tr>
								<td align="center" height="150px">
								장바구니에 담긴 상품이 없습니다.<br>
								상품을 장바구니에 담아주세요!
								</td>
							</tr>
						</table>
						
				
					<%
				}else{
					%>
						<table  class="border" id="id">
					<%
					
					for(int i=0;i<arr.size();i++){
						int price = arr.get(i).getGoods_price();
						int amount = arr.get(i).getGoods_amount();
						int allprice = price * amount;
						total_price += allprice;
						double prices = (double) price;
						double allprices = (double) allprice;
						double total_prices = (double) total_price;
						
						
						
						%>	
						
								<tr>
									<td width="10px">
									<input type="checkbox" name="chk_cart_goods" value="<%=arr.get(i).getIdx() %>" onChange="chkstate();totalprice();">
									<input type="hidden" name="chk_state" value="on">						
									</td>
					
									<td class="dropdowns" width="60px">
									
										<img src="../img/<%=arr.get(i).getGoods_imgpath()%>">
											<div class="dropdowns-content">
												<img src="../img/<%=arr.get(i).getGoods_imgpath() %>">
												<div class="names"><%=arr.get(i).getGoods_name() %></div>
											</div>
									</td>
					
									<td width="210px">
									<input type="hidden" name="hi_goods_idx" value="<%=arr.get(i).getGoods_idx()%>">
									<input type="hidden" name="cart_idx" value="<%=arr.get(i).getIdx()%>">
									<%=arr.get(i).getGoods_name() %>
									</td>
					
									<td width="120px">
									<input type="hidden" name="price" value="<%= prices%>">
									<%= df1.format(prices)%>원
									<input type="hidden" name="option_a" value="<%=arr.get(i).getGoods_optiona()%>">
									<input type="hidden" name="option_b" value="<%=arr.get(i).getGoods_optionb()%>">
									</td>
					
									<td width="100px">
									<input type="hidden" name="hi_idx" value="<%=arr.get(i).getIdx()%>">
									<select name="amount" onchange="amountchge(this.form)">
										<%
										for(int j=1;j<=100;j++){
											%>
												<option value="<%=j %>" <%if(j==amount){%> selected <% } %>><%=j%></option>
											<%
										}
										
										%>
									</select>
									<br>
									
									</td>
					
									<td width="100px">
					
									<%=df1.format(allprice) %>원
									</td>
					
									<td width="20px">
										<input type="button" value="삭제" onClick="cart_del(<%=arr.get(i).getIdx() %>)" class="buttonimg">
									</td>
								</tr>																	
						<%			
					}
					%>
						</table>
					<%
					
				}
			%>
						</td>
					</tr>
				</tbody>
						<!-- jsp 영역 끝 // 현재 로그인된 아이디의 장바구니의 내역을 가져와서 뿌린다. -->		
			</table>
			<input class="buttonimg" type="button" value="전체선택" onClick="allchkt()";>
			<input class="buttonimg" type="button" value="선택해지" onClick="allchkf()";>
			<input class="buttonimg" type="button" value="선택상품삭제" onClick="chkDel(this.form)">
		</td>
	</tr>
</table><br>
<table>
	<tr>
	<td > <b  id="tprice">총 주문금액  : <%=df1.format(total_price) %>원</b>
	</td>
	<td>
	</td>
	<td id="button">
	<input class="buttonimg" type="button" value="계속 쇼핑하기" onclick="goShopping()">
	<input class="buttonimg" type="button" value="구매하기" onClick="orderOpen(this.form)">
	</td>
	</tr>
	
</table>
</form>
</article>
</section>
<%@include file="../footer.jsp" %>
</body>
</html>
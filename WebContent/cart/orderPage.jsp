<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>   
<%@ page import="myhome.store.*" %>  
<%@ page import="myhome.member.*" %> 
<%@ page import="java.text.*" %> 
<jsp:useBean id="sdao" class="myhome.store.MyhomeDAO"/>
<jsp:useBean id="mdao" class="myhome.member.MemberDAO"/>
<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=UTF-8");
Map<String, String[]> m = request.getParameterMap();

if( m.keySet().size() == 0 ) {
	%>
	<script>
		alert('[접근오류]');
		location.replace('/myhome');
	</script>
	<%	
		return;
}
%>
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

<%
	String[] cart_idx=null;
	if(request.getParameterValues("cart_idx")!=null){
		cart_idx=request.getParameterValues("cart_idx");
	}
%>
<%
String option1=request.getParameter("option_a");
String option2=request.getParameter("option_b");
%>
<script>
    function openLogin() {
		window.open('/myhome/member/login.jsp','login','width=1000,height=550');
		history.back();
	}
</script> 
<% 
	String m_id=(String)session.getAttribute("sid");
	
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
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT ="-1">
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<script>
	function orderOk(){
		window.alert('결제가 완료되었습니다.');
		location.href="/myhome/index.jsp";
	}
	function orderCancle(){
		window.alert('결제가 취소되었습니다.');
		location.href="/myhome/index.jsp";
	}
	function resets(){
		document.fm.username.value='';
		document.fm.userphone.value='';
		document.fm.useraddr.value='';

	}
</script>
<style>
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
</head>
<body>
<%@include file="../header.jsp" %>
<h2 align="center" size="5"><font color="skyblue">주문/결제하기</font></h2>
<%
int total_price=0;
int all_price=0;
DecimalFormat df1 = new DecimalFormat("#,##0");
%>
<br>
<section>
	<article>
		<form name="fm" action="orderPage_ok.jsp" method="POST">
		<table align="center">
			<tr>
				<td colspan="3">
				배송지
				</td>
				<td>
				<input class="buttonimg" type="button" value="수정" onClick="resets()">
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<hr>
				</td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="userid" value="<%=mdto.getMember_id()%>">
					
					<input type="text" name="username" placeholder="성명" value="<%=mdto.getMember_name()%>">
				<td>
					<input type="text" name="userphone" placeholder="전화번호" value="<%=mdto.getMember_phone()%>"></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="text" name="useraddr" placeholder="주소" value="<%=mdto.getMember_addr()%>" size="46">
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<select style="color:skyblue;width:190px;">
					<option value="배송요청사항 선택">배송요청사항 선택</option>
					<option value="배송 전 연락 바랍니다.">배송 전 연락 바랍니다.</option>
					<option value="부재시 휴대폰으로 연락 바랍니다.">부재시 휴대폰으로 연락 바랍니다.</option>
					<option value="부재시 경비실에 맡겨 주세요.">부재시 경비실에 맡겨 주세요.</option>
					<option value="경비실이 없습니다.배송전 연락 바랍니다.">경비실이 없습니다.배송전 연락 바랍니다.</option>
				</select>
				</td>
			</tr>
			</table>
			
			<table align="center" width="370">
			<%
				String[] goods_idx = request.getParameterValues("hi_goods_idx");
				String[] goods_amount = request.getParameterValues("amount");
				String option_a=request.getParameter("option_a");
				String option_b=request.getParameter("option_b");
				
				ArrayList<MyhomeDTO> arr = new ArrayList<MyhomeDTO>();
				
				for(int j=0;j<goods_idx.length;j++){
					
					int goods_idx_s = Integer.parseInt(goods_idx[j]);
					int goods_amount_s = Integer.parseInt(goods_amount[j]);
					
					MyhomeDTO dto = sdao.myhomeIdxList(goods_idx_s,goods_amount_s);
					
					arr.add(dto);		
				}
				
				
					for(int i=0;i<arr.size();i++){
						int price = arr.get(i).getGoods_price();
						int amount = arr.get(i).getGoods_amount();
						int allprice = price * amount;
						total_price += allprice;
						all_price +=total_price;
						double prices = (double) price;
						double allprices = (double) allprice;
						double total_prices = (double) total_price;
						double all_prices = (double) all_price;	
			%>
			<tr>
				<td colspan="4">
				<br>주문상품
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<hr>
				</td>
			</tr>
			<tr>
				<td rowspan="4">
				<img src="../img/<%=arr.get(i).getGoods_imgpath() %>" width="100"height="100">
				</td>
				<td colspan="3">
				<%=arr.get(i).getGoods_name() %>
				<input type="hidden" name="goodsidx" value="<%=arr.get(i).getGoods_idx()%>">
				<input type="hidden" name="goods_amount" value="<%=arr.get(i).getGoods_amount()%>">
				<input type="hidden" name="goods_name" value="<%=arr.get(i).getGoods_name() %>">
				<input type="hidden" name="goods_price" value="<%=arr.get(i).getGoods_price() %>">
				<input type="hidden" name="goods_imgpath" value="<%=arr.get(i).getGoods_imgpath() %>">
				<%
				if(request.getParameterValues("cart_idx")!=null){
					 %>
				<input type="hidden" name="cart_idx" value="<%=cart_idx[i]%>">
				<% 
				}
				%>
				</td>
			</tr>
			<tr>
				<td><%= df1.format(prices)%>원(배송비 무료)</td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="3">수량:<%=arr.get(i).getGoods_amount() %>개</td>
			</tr>
			<tr>
				<td colspan="3"><%=option1%>/<%=option2%></td>
			</tr>
			<tr>
				<td colspan="4">
				<hr>
				</td>
			</tr>
			<tr>
				<td>
				<b>주문금액</b>
				</td>
				<td colspan="3">
				<%=df1.format(total_price) %>원
				</td>
			</tr>
			<%
			}
			%>
			</table>
			<br>
			<table align="center" width="370">
			<tr>
				<td colspan="4">
				최종결제금액
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<hr>
				</td>
			</tr>
			<tr>
				<td><b>결제 예상금액</b></td>
				<td colspan="3">
					<%=df1.format(all_price) %>
					<input type="hidden" name="totalprice" value="<%=all_price %>">
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<hr>
				</td>
			</tr>	
			<tr>
				<td colspan="4">
				<br>
				<input type="radio" name="se" value="카드결제" checked>카드결제
				<input type="radio" name="se" value="핸드폰결제">핸드폰결제
				<input type="radio" name="se" value="무통장입금">무통장입금
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
				<br>
				<input class="buttonimg" type="submit" name="order" value="결제하기">
				<input class="buttonimg" type="button" name="cancle" value="결제 취소하기" onclick="orderCancle()">
				</td>
			</tr>
		</table>
		</form>
	</article>
</section>
<%@include file="../footer.jsp" %>
</body>
</html>

















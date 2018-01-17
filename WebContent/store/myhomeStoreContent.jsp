<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.store.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %> 
<jsp:useBean id="mdao" class="myhome.store.MyhomeDAO" scope="session"/>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 
%>
<%
	if(application.getAttribute("goodsidx")==null){
		ArrayList<String> list = new ArrayList<String>();
		HashMap<String,ArrayList> like = new HashMap<String,ArrayList>();
		like.put(null, list);
		application.setAttribute("goodsidx", like);
	}

	String m_id= request.getRemoteAddr();
	if(application.getAttribute("readidx")==null){
		ArrayList<String> list = new ArrayList<String>();
		HashMap<String,ArrayList> like = new HashMap<String,ArrayList>();
		like.put(m_id, list);
		application.setAttribute("readidx", like);
	}

	String idx=request.getParameter("goods_idx");
	
	HashMap<String,ArrayList> maps = new HashMap<String,ArrayList>();
	 maps = (HashMap)application.getAttribute("readidx");
	 boolean chk=false;
	 
	 if(!(maps.containsKey(m_id))){
	    	
	    	chk = true;
		    ArrayList<String> arr = new ArrayList<String>();
		   	arr.add(idx);
		    maps.put(m_id, arr);
		    application.setAttribute("readidx", maps);
		    
	   }else{
	   	ArrayList<String> list=maps.get(m_id);
	   	if(list.contains(idx)){
	   		chk=false;
 	}else{
	   		chk=true;
	   		list.add(idx);
	   		maps.put(m_id,list);
	   		application.setAttribute("readidx", maps);
 	}
	   }
	 int read=Integer.parseInt(idx);
	 
	 if(chk){
	       mdao.ureadnum(read);
	    }
%>
<%
	String idx_s=request.getParameter("goods_idx");
	if(idx_s==null||idx_s.equals("")){
		idx_s="0";
	}
	int goods_idx=Integer.parseInt(idx_s);
	MyhomeDTO mto=mdao.myhomeStoreContent(goods_idx);
%>
<%
	if(request.getParameter("goods_like")!=null){
		int like_idx=Integer.parseInt(request.getParameter("goods_like"));
		mto=mdao.myhomeStoreContent(like_idx);
	}else if(request.getParameter("goods_idx")==null||request.getParameter("goods_idx").equals("")){
	%>
		<script>
         window.alert('삭제된 게시글 또는 잘못된 접근입니다');
         window.href='myhomeStoreContent.jsp';
        </script>
		<%
	}else{
		goods_idx=Integer.parseInt(request.getParameter("goods_idx"));
		mto=mdao.myhomeStoreContent(goods_idx);
	}
	if(mto==null){
		%>
		<script>
         window.alert('삭제된 게시글 또는 잘못된 접근입니다');
         window.href='myhomeStoreContent.jsp';
        </script>
		<%
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
	h2{
		text-align: center;
		color: skyblue;
	}
	article{
		margin: 0px auto;
	}
	table{
		margin: 0px auto;
		text-align: center;
	}
	fieldset {
		text-align: left;
		margin: 0px auto;
		border:1px solid #999;
		box-shadow:0 0 3px #999;
	}
	#mainImg{
		width: 500px;
		float: left;
	}
	#mainImg img{
		width: 500px;
	}
	#mainMenu{
		float: left;
		margin-top: 0px;
	}
	#Img{
		float: right;
	}
	#update{
		border: none; /*---테두리 정의---*/
	   background-Color: skyblue; /*--백그라운드 정의---*/
	   font: 15px 굴림; /*--폰트 정의---*/
	   font-weight: bold; /*--폰트 굵기---*/
	   color: white; /*--폰트 색깔---*/
	   width: 110px;
	   height: 60px; /*--버튼 크기---*/
	}
	#store thead{
		border-bottom: 2px solid #ddd;
	}
	#store thead{
		border-bottom: 2px solid #ddd;
	}
	#sel{
		border-color: #ddd;
		height: 30px;
	}
</style>
<script>
	function cartOpen(obj){
		var ola = content.option_a.options[content.option_a.selectedIndex].value;
		var olb = content.option_b.options[content.option_b.selectedIndex].value;
		var olc = content.amount.options[content.amount.selectedIndex].value;
		var lo = '0';
		if(ola==lo){
			alert('색상을 선택해 주세요.');
			
		}else if(olb==lo){
				alert('사이즈를 선택해 주세요.');
				
		}else if(olc==lo){
				alert('수량을 선택해 주세요.');
				
		}else{
			obj.action='../cart/storeCart.jsp';
			obj.submit();
		}
	}
	   function changeAmount(price){
	          var ol = content.amount.options[content.amount.selectedIndex].value;
	          var total = (price * ol);
	          var totals = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	          document.all.ad.innerText=totals;
	          
	   }
	function orderPage(obj){
		var ola = content.option_a.options[content.option_a.selectedIndex].value;
		var olb = content.option_b.options[content.option_b.selectedIndex].value;
		var olc = content.amount.options[content.amount.selectedIndex].value;
		var lo = '0';
		if(ola==lo){
			alert('제품을 선택해 주세요.');
			
		}else if(olb==lo){
				alert('사이즈를 선택해 주세요.');
				
		}else if(olc==lo){
				alert('수량을 선택해 주세요.');
				
		}else{
			obj.action='../cart/orderPage.jsp';
			obj.submit();
		}
	}
</script>
</head>
<body>
<%
DecimalFormat df1 = new DecimalFormat("#,##0");
%>
<%@include file="../header.jsp" %>
<section>
	<br>
	<table align="center" width="1200">
	<tr>
	<td>
	<article id="mainImg" align="center">
		<img src="../img/<%=mto.getGoods_imgpath() %>" alt="메인이미지">
	</article>
	</td>
	<td>
	<article id="mainMenu">
		<form name="content" action="myhomeStoreContent_ok.jsp" method="POST">
			<table align="center" width="400" id="store">
				<thead style="border-bottom: 5px solid #ddd">
					<tr>
						<td colspan="2"><strong><%=mto.getGoods_name() %></strong>
						<input type="hidden"name="hi_goods_idx" value="<%=mto.getGoods_idx()%>">
						</td>
					</tr>
					<tr><td></td></tr>
					<tr>
						<td>판매가</td>
						<td style="float:left"><strong><%=df1.format(mto.getGoods_price()) %>원</strong></td>
					</tr>
					<tr><td></td></tr>
					<tr>
						<td>배송비</td>
						<td style="float:left"><b>무료|업체택배배송</b></td>
					</tr>
					<tr><td></td></tr>
					<tr><td></td></tr>
				</thead>
				<br>
				<tbody>
					<tr>
						<td colspan="2">
							<select style="color:darkgray; width:300px;" name="option_a" style="float:left" id="sel">
								<option value="0">1.색상 선택</option>
								<option value="내츄럴-화이트">
                        내츄럴-화이트★Best
                    </option>
			                    <option value="내츄럴-아이보리">
                        내츄럴-아이보리★Best
                    </option>
			                    <option value="내츄럴-피치">
                        내츄럴-피치
                    </option>
			                    <option value="내츄럴-브라운">
                        내츄럴-브라운
                    </option>
			                    <option value="내츄럴-카라멜">
                        내츄럴-카라멜
                    </option>
			                    <option value="내츄럴-초콜렛">
                        내츄럴-초콜렛
                    </option>
			                    <option value="내츄럴-모카">
                        내츄럴-모카
                    </option>
			                    <option value="내츄럴-카키">
                        내츄럴-카키
                    </option>
			                    <option value="내츄럴-그린">
                        내츄럴-그린
                    </option>
			                    <option value="내츄럴-블루">
                        내츄럴-블루
                    </option>
			                    <option value="내츄럴-다크블루">
                        내츄럴-다크블루
                    </option>
			                    <option value="내츄럴-핑크">
                        내츄럴-핑크
                    </option>
			                    <option value="내츄럴-옐로우">
                        내츄럴-옐로우
                    </option>
			                    <option value="내츄럴-바이올렛">
                        내츄럴-바이올렛
                    </option>
			                    <option value="내츄럴-그레이">
                        내츄럴-그레이
                    </option>
			                    <option value="내츄럴-오렌지">
                        내츄럴-오렌지
                    </option>
			                    <option value="내츄럴-와인">
                        내츄럴-와인
                    </option>
			                    <option value="내츄럴-블랙">
                        내츄럴-블랙
                    </option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<select style="color:darkgray;width:300px;" name="option_b" id="sel">
								<option value="0">2.사이즈 선택</option>
								<option value="가로:30cmX세로:60cm">가로:30cmX세로:60cm</option>
								<option value="가로:30cmX세로:70cm">가로:30cmX세로:70cm</option>
								<option value="가로:40cmX세로:60cm">가로:40cmX세로:60cm</option>
								<option value="가로:40cmX세로:70cm">가로:40cmX세로:70cm</option>
								<option value="가로:40cmX세로:80cm">가로:40cmX세로:80cm</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<select name="amount" style="color:darkgray;width:300px;" onChange="changeAmount(<%=mto.getGoods_price() %>);" id="sel">
							<option value="0">3.수량 선택</option>
							<%
							for(int i=1;i<=10;i++){
								%>
								<option value="<%=i%>"><%=i%></option>
								<%
							}
							
							%>
							</select>
						</td>
					</tr>
					<tr>
						<td>
						<br>
						&nbsp;&nbsp;주문금액</td>
						<td Style="vertical-align:bottom;">

		                     <b id="ad">
		                     <%=df1.format(mto.getGoods_price()) %></b><b>원</b>
		                </td>
					</tr>
				</tbody>
				<tr>
					<td colspan="2">
						<br>
						<a href="storeLike.jsp?idx=<%=mto.getGoods_idx()%>"><img src="../img/like.jpg" width="110" height="40"></a>
					</td>	
				</tr>
				<tr>
					<td colspan="2">
					<br>
						<input type="button" value="주문하기" onclick="orderPage(this.form)" id="update">
						<input type="button" value="장바구니" onclick="cartOpen(this.form)" id="update">
					</td>	
				</tr>
				</table>
				</form>
				</article>
				</td>
					<td>
						<article id="Img">
							<a href="myhomeStoreEvent.jsp"><img src="../img/eventmain.jpg" width="192"height="400"></a>
					</td>
				</tr>
		</table>
	</article>
	<br><br><br>
	<article align="center" style="clear:both;">
		<img src="../img/<%=mto.getGoods_content() %>" width="900"height="3666">
	</article>
	<article align="center" style="clear:both;">
		<img src="../img/baesong.jpg" width="900"height="2855">
	</article>
	<div class="prd_info" width="800" align="center">
    <h3>교환 및 반품정보</h3>
    <p></p>
    <p>
    <font size="3">
    <strong>교환 및 반품이 가능한 경우</strong><br/>
    - 상품 불량/파손/누락건에 대해 100% 처리를 해드리고 있으며 상품을 공급 받으신 날로부터 7일이내로 고객센터로 연락주셔야 처리가 가능합니다.<br/>
    - 교환/반품 시 반드시 고객센터로 접수하신 후 지정택배를 이용하셔야 합니다. 타택배 이용 시 추가요금이 발생될 수 있습니다.<br/>
    - 맞교환 처리는 운영방침상 불가하오니 양해 부탁드립니다.<br/><br/><strong>교환 및 반품이 불가능한 경우</strong><br/>
    - 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우에는 교환/반품 불가합니다.<br/>
    - 가구전용 설치배송 상품의 경우 교환/반품 불가합니다.(상세페이지 상단 참조)<br/>
    - 주문제작 상품 (가구,패브릭상품 외) 제작상품으로 공지된 상품의 경우 교환/반품 불가합니다.(부득이 취소/교환/반품 해야하는 경우 소정의 위약금+배송비(왕복) 발생됩니다.<br/><br/>
      ※ 선금지불 후 물품배달 전 해약 시: 소비자 귀책사유로 인한 해약인 경우<br/>
         (주문 제작형 제품인 경우)<br/>
         -가구 제작작업 착수 이전: 총 제품금액의 10%를 위약금으로 가능<br/>
         -가구 제작작업 착수 이후: 실손해 배상<br/><br/>
        
    - 반조립 상품의 경우 조립이나 설치 후에는 교환/반품 불가합니다. 단, 조립전이라면 가능합니다.<br/>
    - 원목의 특성상 생길 수 있는 옹이무늬, 약간의 갈라짐, 벤딩, 미세한 사이즈 차이 및 모니터 색상차이로 인한 교환/반품 불가합니다.<br/>
    - 시즌상품은 (예: 크리스마스) 특성상 제품 불량 외 단순변심에 의한 교환/반품 불가합니다.<br/>
    - 고객님의 단순변심으로 인한 교환/반품 경우 상품 배송비는 고객님께서 부담하셔야 합니다.(주문오류, 색상 또는 사이즈 교환 등)<br/></p>
    </font>
</div>
<div class="prd_info" width="500" align="center">
    <h3>환불정보</h3>
    <p></p>
    <p>
    <font size="3">
    환불시 반품 확인여부를 확인한 후 3영업일 이내에 결제 금액을 환불해 드립니다.<br/>
    신용카드로 결제하신 경우는 신용카드 승인을 취소하여 결제 대금이 청구되지 않게 합니다.<br/>
    (단, 신용카드 결제일자에 맞추어 대금이 청구 될수 있으면 이경우 익월 신용카드 대금청구시 카드사에서 환급처리 됩니다.)
    </font>
    </p>
</div>
</section>
<br>
<%@include file="../footer.jsp" %>
</body>
</html>
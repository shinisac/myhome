<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
	request.setCharacterEncoding("utf-8");
%>    
<jsp:useBean id="odto" class="myhome.order.OrderDTO"/>
<jsp:useBean id="odao" class="myhome.order.OrderDAO"/>
<jsp:useBean id="cdao" class="myhome.cart.CartDAO"/>
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
	String[] cart_idx_s=null;
	if(request.getParameterValues("cart_idx")!=null){
		cart_idx_s=request.getParameterValues("cart_idx");
	}
	
	int idx=Integer.parseInt(request.getParameter("goodsidx"));
	odto.setOrder_member_id(request.getParameter("userid"));
	odto.setOrder_goods_idx(Integer.parseInt(request.getParameter("goodsidx")));
	odto.setOrder_amount(Integer.parseInt(request.getParameter("goods_amount")));
	odto.setOrder_price(Integer.parseInt(request.getParameter("totalprice")));
	odto.setOrder_addr(request.getParameter("useraddr"));
	odto.setOrder_pay(request.getParameter("se"));
	odto.setOrder_goods_name(request.getParameter("goods_name"));
	odto.setOrder_goods_price(Integer.parseInt(request.getParameter("goods_price")));
	odto.setOrder_imgpath(request.getParameter("goods_imgpath"));
	int result=odao.myhomeOrder(odto);
	if(result>0){
		if(request.getParameterValues("cart_idx")!=null){
			for(int i=0;i<cart_idx_s.length;i++){
				int cart_idx=Integer.parseInt(cart_idx_s[i]);
				cdao.cartListDel(cart_idx);
			}
		}
		odao.buyCount(idx);
	}
	String msg=result>0? "결제 되었습니다.":"결제를 실패했습니다.";
%>
<script>
	window.alert('<%=msg%>');
	
	location.href="/myhome/index.jsp";
</script>












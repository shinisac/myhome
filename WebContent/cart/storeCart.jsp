<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.goods.*" %>    
<%@ page import="java.util.*" %>
<%@ page import="myhome.member.*" %>     
<jsp:useBean id="cdao" class="myhome.cart.CartDAO"/>
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
<script>
    function openLogin() {
		window.open('/myhome/member/login.jsp','login','width=1000,height=550');
		history.back();
	}
</script> 
<% 
	
	String sid=(String)session.getAttribute("sid");
	
	if(sid==null||sid.equals("")){
		%>
		<script>
			window.alert('로그인 후 이용가능한 서비스입니다.');
			location.href='javascript:openLogin();';
		</script>
		<%
		return;
	}
%>
<%
	
	int idx = Integer.parseInt(request.getParameter("hi_goods_idx"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	String option_a=request.getParameter("option_a");
	String option_b=request.getParameter("option_b");
	
	String m_id = (String) session.getAttribute("sid");
	
	MemberDTO mdto = mdao.memberSearch(m_id);
	int member_idx= mdto.getMember_idx();
			
	GoodsDTO dto = cdao.cartGoods(idx);
	
	int count=cdao.cartInsert(dto, member_idx, amount, option_a, option_b);

%>
<script>
	location.href='cartPage.jsp?';
</script>


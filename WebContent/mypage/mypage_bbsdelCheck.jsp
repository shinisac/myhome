<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="myhome.bbs.*"%>
<%@ page import="myhome.rip.*"%>
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session"/>
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
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT ="-1">
<meta charset="UTF-8">
<title>Myhome</title>
<%
	int idx=Integer.parseInt(request.getParameter("idx"));
%>
<script>
	function delCel(){
		window.self.close();
		location.href="/myhome/mypage/mypage_bbsContent.jsp?idx=<%=idx%>";
	}
</script>
<script>
	function delOk(){
		location.href="/myhome/mypage/mypage_delbbs.jsp?idx=<%=idx%>";
	}
</script>
<style>
	fieldset{
		border:1px solid #999;
		box-shadow:0 0 3px #999;
	}
	.button{
		border: none; /*---테두리 정의---*/
	   background-Color: skyblue; /*--백그라운드 정의---*/
	   font: 12px 굴림; /*--폰트 정의---*/
	   font-weight: bold; /*--폰트 굵기---*/
	   color: white; /*--폰트 색깔---*/
	   width: 70px;
	   height: 30px; /*--버튼 크기---*/
	   margin-left: 10px;
	}
	label{
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
	margin-left: 10px;
	padding-bottom:10px;
	border-bottom:2px double skyblue;
	}
</style>
</head>
<body>
<section>
	<article>
		<fieldset>
			<form name="del" method="POST">
				<label>삭제 하시겠습니까?</label>
				<input class="button" type="button" value="삭제" onclick="delOk()">
				<input class="button" type="button" value="취소" onclick="delCel()">
			</form>
		</fieldset>
	</article>
</section>
</body>
</html>
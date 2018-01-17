<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.member.*" %>
<jsp:useBean id="mdto" class="myhome.member.MemberDTO"/>    
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="myhome.member.MemberDAO"/>
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
	response.setHeader("pragma", "no-cache");
	response.setHeader("cache-control", "no-cache");
	response.addHeader("cache-control", "no-store");
	response.setDateHeader("Expires", 0);
%>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
	table{
		text-align: center;
	}
</style>
<script>
	function delCel(){
		location.href="/myhome/mypage/memberUpdate.jsp";
	}
</script>
</head>
<body>
<%@include file="../header.jsp" %>
<section>
	<form name="memberDel_ok" action="memberDel_ok.jsp" method="POST">
	<h2 align="center">탈퇴하기</h2>
	<table align="center">
		<tr>
			<td colspan="2">
			정말 삭제하시겠습니까?
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
			<input type="password" name="member_pwd">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="탈퇴하기">
				<input type="button" value="취소" onclick="delCel()">
			</td>
		</tr>
	</table>
	</form>
</section>
<%@include file="../footer.jsp" %>
</body>
</html>
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
	window.self.close();
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
</head>
<body>
<section>
	<article>
		<fieldset>
			<legend>비밀번호 변경</legend>
			<form name="pwdUpdate_ok" action="pwdUpdate_ok.jsp" method="POST">
			<table>
				<tr>
					<th>현재 비밀번호</th>
					<td>
					
					<input type="password" name="now_pwd">
					<td>
				</tr>
				<tr>
					<th>새 비밀번호</th>
					<td>
					<input type="password" name="member_pwd">
					<td>
				</tr>
				<tr>
					<td colspan="2">
					<input type="submit" value="확인">
					<td>
				</tr>
			</table>
			</form>
		</fieldset>
	</article>
</section>
</body>
</html>
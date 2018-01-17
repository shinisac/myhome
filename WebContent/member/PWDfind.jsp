<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.member.*" %>
<jsp:useBean id="mdto" class="myhome.member.MemberDTO"/>    
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="myhome.member.MemberDAO"/>

<%
	String chk_name=request.getParameter("name");
	String chk_id=request.getParameter("id");
	
	int result=mdao.pwdCheck(chk_id,chk_name);
	
	if(result==1){//성공시
		%>
		<script>
		function pwdCheck(){
			if(document.PWDfind_ok.now_pwd.value==''){
				window.alert('비밀번호를 입력해주세요.');
				document.PWDfind_ok.now_pwd.focus();
				return false;
			}else if(document.PWDfind_ok.member_pwd.value==''){
				window.alert('비밀번호 확인을 입력해주세요.');
				document.PWDfind_ok.member_pwd.focus();
				return false;
			}else{
				return true;//submit 보내기
			}
		}
		</script>
		<%
	}else if(result==0){
		%>
		<script>
			window.alert('해당하는 아이디가 존재하지 않습니다.');
			location.href="PWDfind.jsp";
			window.self.close();
		</script>
		<%
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>

</head>
<body>
<section>
	<article>
		<fieldset>
			<legend>비밀번호 변경</legend>
			<form name="PWDfind_ok" action="PWDfind_ok.jsp" onsubmit='return pwdCheck()' method="POST">
			<input type="hidden" name="id" value="<%=chk_id%>">
			<table>
				<tr>
					<th>새 비밀번호</th>
					<td>
					<input type="password" name="now_pwd">
					<td>
				</tr>
				<tr>
					<th>새 비밀번호확인</th>
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta  charset=UTF-8">
<title>Myhome</title>
</head>
<body>
	<form name="login" action="admin_login_ok.jsp">
	<fieldset>
	<legend>관리자 정보</legend>
	
		<table>
		
			<tr>
				<td>아이디: <input type="text" name="admin_id" ></td>
			</tr>
			<tr>
				<td>비밀번호:<input type="password" name="admin_pwd"></td>
			</tr>
			<tr>
				<td>
				<input type="submit" value="확인">
				<input type="reset" value="취소"	>
				</td>
			</tr>
			
			
			
			
		</table>
		</fieldset>
	</form>
</body>
</html>
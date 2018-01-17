<%@page import="java.util.ArrayList"%>
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
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
	fieldset{
		margin: 0px auto;
	}
	th{
		text-align: left;
	}
	#update{
		border: none; /*---테두리 정의---*/
	   background-Color: skyblue; /*--백그라운드 정의---*/
	   font: 12px 굴림; /*--폰트 정의---*/
	   font-weight: bold; /*--폰트 굵기---*/
	   color: white; /*--폰트 색깔---*/
	   width: 70px;
	   height: 30px; /*--버튼 크기---*/
	}
</style>
<script>
	function pwdOpen(){
		window.open('/myhome/mypage/pwdUpdate.jsp','pwdup','width=500,height=150');
	}
	function memberDel(){
		location.href="/myhome/mypage/memberDel.jsp";
	}
</script>
</head>
<body>
<%@include file="../header.jsp"%>
<section>
	<article>
		<%
		String userid=(String)session.getAttribute("sid");
		ArrayList<MemberDTO> arr=mdao.memberList(userid);
		if(arr==null||arr.size()==0){
			%>
			
			<%
		}else{
		for(int i=0;i<arr.size();i++){
			
		%>
		<br>
		<fieldset style="border:1px solid lightgray;width:450px;height:390px">
		<legend><h2><font color="skyblue"><%=arr.get(i).getMember_name() %>님 정보</font></h2></legend>
		<form name="memberUpdate_ok" action="memberUpdate_ok.jsp" method="POST">
		<table align="center" width="320">
			<tr>
				<th>회원번호</th>
				<td><%=arr.get(i).getMember_idx() %></td>
				<input type="hidden" name="member_idx" value="<%=arr.get(i).getMember_idx()%>">
			</tr>
			<tr>
				<th>회원상태</th>
				<td><%=arr.get(i).getMember_state() %></td>
				<input type="hidden" name="member_state" value="<%=arr.get(i).getMember_state() %>">
			</tr>
			<tr>
				<th>회원등급</th>
				<td><%=arr.get(i).getMember_level()%></td>
				<input type="hidden" name="member_level" value="<%=arr.get(i).getMember_level() %>">
			</tr>
			<tr>
				<th>회원아이디</th>
				<td><%=arr.get(i).getMember_id()%></td>
				<input type="hidden" name="member_id" value="<%=arr.get(i).getMember_id()%>">
			</tr>
			<tr>
				<th>회원비밀번호</th>
				<td>
					<input type="button" name="member_pwd" value="수정" onclick="pwdOpen()" id="update">
				</td>
			</tr>
			<tr>
				<th>회원이름</th>
				<td><%=arr.get(i).getMember_name()%></td>
				<input type="hidden" name="member_name" value="<%=arr.get(i).getMember_name()%>">
			</tr>
			<tr>
				<th>회원생년월일</th>
				<td><%=arr.get(i).getMember_birthday()%></td>
				<input type="hidden" name="member_birthday" value="<%=arr.get(i).getMember_birthday()%>">
			</tr>
			<tr>
				<th>회원성별</th>
				<td><%=arr.get(i).getMember_gen()%></td>
				<input type="hidden" name="member_gen" value="<%=arr.get(i).getMember_gen()%>">
			</tr>
			<tr>
				<th>회원전화번호</th>
				<td><input type="text" name="member_phone" value="<%=arr.get(i).getMember_phone()%>"></td>
			</tr>
			<tr>
				<th>E-Mail</th>
				<td><input type="text" name="member_email" value="<%=arr.get(i).getMember_email()%>"></td>
			</tr>
			<tr>
				<th>회원주소</th>
				<td><input type="text" name="member_addr" value="<%=arr.get(i).getMember_addr()%>"></td>
			</tr>
			<%
		}
		}
			%>
			<tr>
				<td colspan="2" align="center">
					<br>
					<input type="submit" value="정보수정" id="update"> 
					<input type="button" value="탈퇴하기" onclick="memberDel()" id="update">
				</td>
			</tr>
		</table>
		</form>
		</fieldset>
		<br>
	</article>
</section>
<%@include file="../footer.jsp"%>
</body>
</html>
















<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.member.*" %>
<jsp:useBean id="mdto" class="myhome.member.MemberDTO"/>    
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="myhome.member.MemberDAO"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">

</head>
<body>
<%@include file="../header.jsp"%>
<section>
	<article>
		<%
		String userid=request.getParameter("ck");
		ArrayList<MemberDTO> arr=mdao.memberList(userid);
		if(arr==null||arr.size()==0){
			%>
			
			<%
		}else{
		for(int i=0;i<arr.size();i++){
			
		%>
		<h2 align="center">
		<%=arr.get(i).getMember_name() %>님 정보
		</h2>
		<form name="memberUpdate_ok" action="memberUpdate_ok.jsp" method="POST">
		<table align="center">
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
				<th>회원이름</th>
				<td><%=arr.get(i).getMember_name()%></td>
				<input type="hidden" name="member_name" value="<%=arr.get(i).getMember_name()%>">
			</tr>
			<tr>
				<th>회원생년월일</th>
				<td><%=arr.get(i).getMember_birthday()%></td>
				
			</tr>
			<tr>
				<th>회원성별</th>
				<td><%=arr.get(i).getMember_gen()%></td>
				
			</tr>
			<tr>
				<th>회원전화번호</th>
				<td><%=arr.get(i).getMember_phone()%></td>
			</tr>
			<tr>
				<th>E-Mail</th>
				<td><%=arr.get(i).getMember_email()%></td>
			</tr>
			<tr>
				<th>회원주소</th>
				<td><%=arr.get(i).getMember_addr()%></td>
			</tr>
			<%
			}
		}
			%>
		</table>
		</form>
	</article>
</section>
<%@include file="../footer.jsp"%>
</body>
</html>
















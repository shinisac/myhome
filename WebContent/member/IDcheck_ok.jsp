<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="myhome.member.MemberDAO"/>
<%@ page import="java.util.*"%>
<%
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
String userid=request.getParameter("userid");
boolean result=mdao.idCheck(userid);
if(result){
	%>
	<script>
	window.alert('<%=userid%>'+'는 이미 사용중입니다. 다른 아이디를 입력해주세요');
	location.href='/myhome/member/IDcheck.jsp';
	</script>
	<%
}
else
{
	%>
	<script>
	window.alert('<%=userid%>'+'는 사용가능합니다.');
	opener.join.member_id.value='<%=userid%>';
	window.self.close();
	</script>
	<%
}
%>
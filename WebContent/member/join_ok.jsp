<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");

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
<jsp:useBean id="mdto" class="myhome.member.MemberDTO"/>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="myhome.member.MemberDAO"/>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 

%>
<%
int result=mdao.memberJoin(mdto);
String msg=result>0?"회원가입 성공(로그인하세요)":"회원가입 실패(다시 가입)";
%>
<script>
window.alert('<%=msg%>');
location.href='/myhome/index.jsp';
</script>
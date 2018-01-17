<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myhome.member.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="mdto" class="myhome.member.MemberDTO"/>    
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="myhome.member.MemberDAO"/>
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
<%
	int result = mdao.memberUpdate(mdto);
	String msg = result > 0 ? "회원정보 수정 성공!" : "회원정보 수정 실패!";
%>
<script>
window.alert('<%=msg%>');
location.href = '/myhome/index.jsp';
</script>

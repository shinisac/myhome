<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
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
%>
<%
	String id=mdao.getserchInfo(mdto.getMember_name(), mdto.getMember_email());
	
	
	if(id==null||id.equals("")){
		%>
		<script>
		window.alert('찾으시는 아이디는 없습니다.');
		location.href="IDfind.jsp";
		</script>
		<%
	}else{
		%>
		<script>
		window.alert('<%=id%>'+'입니다.');
		location.href="login.jsp";
		</script>
		<%
	}
%>
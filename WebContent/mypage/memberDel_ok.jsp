<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	String userid=(String)session.getAttribute("sid");
	String userpwd=(String)session.getAttribute("spwd");
	String n_pwd=request.getParameter("member_pwd");
	String msg="";
	if(n_pwd.equals(userpwd)){
		int result=mdao.memberDel(userid);
		msg="탈퇴 성공!";
		%>
		<script>
		window.alert('<%=msg%>');	
		<%
		session.invalidate();
		%>
		location.href='/myhome/index.jsp';
		</script>
		<%
	}else{
		msg="비밀번호가 일치하지 않습니다!";
		%>
			<script>
			window.alert('<%=msg%>');
			location.href='/myhome/mypage/memberDel.jsp';
			</script>
		<%		
	}
%>














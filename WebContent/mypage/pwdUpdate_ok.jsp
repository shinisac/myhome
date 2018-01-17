<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="myhome.member.*" %>
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
	window.self.close();
</script>
<%	
	return;
}

%>
<%
	String userid=(String)session.getAttribute("sid");
	String n_pwd=request.getParameter("now_pwd");
	String userpwd=(String)session.getAttribute("spwd");
	String new_pwd=request.getParameter("member_pwd");
	
	String msg="";
	if(n_pwd.equals(userpwd)){
		int result = mdao.memberPwdUpdate(userid,mdto.getMember_pwd());
		msg = "비밀번호 수정 성공!";
		session.setAttribute("spwd",new_pwd);
	}else{
		msg = "비밀번호가 맞지 않습니다!";
	}
	
%>
<script>
window.alert('<%=msg%>');
window.self.close();
</script>








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
	String userid=request.getParameter("id");
	
	String n_pwd=request.getParameter("now_pwd");//새 비밀번호
	String new_pwd=request.getParameter("member_pwd");//새 비밀번호확인
	
	String msg="";
	if(n_pwd.equals(new_pwd)){
		int result = mdao.memberPwdUpdate(userid,new_pwd);
		msg = "비밀번호 수정 성공!";
		%>
		<script>
		window.alert('<%=msg%>');
		window.self.close();
		opener.location.replace("/myhome/index.jsp");
		</script>
		<% 
	}else{
		msg = "비밀번호가 일치하지않습니다!";
		%>
		<script>
		window.alert('<%=msg%>');
		history.back();
		</script>
		<%
	}
	
%>

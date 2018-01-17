<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.sql.*" %>
<%@page  import="myhome.admin.*" %>
<jsp:useBean id="admindao" class="myhome.admin.adminDAO" scope="session"/>
    
<%
String idx_s[]=request.getParameterValues("ckbox");
String state[]=request.getParameterValues("sel_bbs_state");
if(request.getParameter("ckbox")==null){
	%>
	<script>
	window.alert('선택된값이 없습니다');
	location.href='admin_bbslist.jsp';
	</script>
	
	<%
	return;
}
int result=0;
for(int i=0; i<idx_s.length;i++){
	int idx=Integer.parseInt(idx_s[i]);
	int count=admindao.bbs_state_modify(state[i],idx);
	result=result+count;
}



String msg=result>0?"상태변경 성공":"상태변경 실패";
if(result>0){
%>
<script>
window.alert('<%=msg%>');
window.location.href="admin_bbslist.jsp";

</script>
<%
}else{
%>
<script>
window.alert('<%=msg%>');
window.self.close();
</script>
<%
}
%>


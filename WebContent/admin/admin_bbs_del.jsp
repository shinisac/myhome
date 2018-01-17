<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page  import="myhome.admin.*" %>
<jsp:useBean id="admindao" class="myhome.admin.adminDAO" scope="session"/>
    

<%
String idx_s[] = request.getParameterValues("ckbox");
if(request.getParameter("ckbox")==null){
	%>
	<script>
	window.alert('선택된값이 없습니다');
	location.href='admin_bbsdellist.jsp';
	</script>
	
	<%
	return;
}
int result=0;
for(int i=0;i<idx_s.length;i++){
	int idx=Integer.parseInt(idx_s[i]);
	int count=admindao.bbsdel(idx);
	result=result+count;
}



String msg=result>0?"게시글 삭제성공":"게시글 삭제실패";
if(result>0){
%>
<script>
window.alert('<%=msg%>');

window.location.href="admin_bbsdellist.jsp";
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



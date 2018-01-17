<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<jsp:useBean id="bdto" class="myhome.bbs.bbsDTO"/>
<jsp:setProperty property="*" name="bdto"/>
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO"/>
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
	int d_idx=Integer.parseInt(request.getParameter("idx"));
	int result=bdao.delbbs(d_idx);
	String msg=result>0?"게시글 삭제성공":"게시글 삭제실패";
	if(result>0){
	%>
	
	<script>
	window.self.close();
	opener.location.href="mystory.jsp";
	</script>
	<%
	}else{
	%>
	<script>
	window.self.close();
	</script>
	<%
	}
%>

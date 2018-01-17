<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
    <%
request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="rdto" class="myhome.rip.ripDTO" scope="session"/>
<jsp:setProperty property="*" name="rdto" />
<jsp:useBean id="rdao" class="myhome.rip.ripDAO"/>

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

String mode=request.getParameter("mode");

int result=0;
String msg="";

if(mode.equals("add")){ %>


<%  
	result=rdao.ripWrite(rdto);

	msg=result>0?"댓글등록성공":"등록실패";
	
}

else if(mode.equals("del")){
	String rip_idx_s=request.getParameter("rip_idx2");
	int rip_idx=Integer.parseInt(rip_idx_s);
	result=rdao.ripDel(rip_idx);
	
	msg=result>0?"댓글삭제성공":"삭제실패";
	
}else if(mode.equals("modify")){
	String rip_idx_s=request.getParameter("rip_idx2");
	int rip_idx=Integer.parseInt(rip_idx_s);
	
	String rip_modify_s=request.getParameter("rip_modify"+rip_idx);
	
	
	
	
	result=rdao.ripModify(rip_modify_s,rip_idx);
	
	msg=result>0?"댓글 수정성공":"수정실패";
}


%>
<script>
window.alert('<%=msg%>');
if(<%=result%>>0){
	location.href="/myhome/bbs/content.jsp?idx2=<%=rdto.getRip_bbs_idx()%>";
}else{
	location.href="/myhome/bbs/bbslist.jsp";
}

</script>


    
    
   
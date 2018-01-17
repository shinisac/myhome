<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<!-- 임포트! -->
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<jsp:useBean id="adao" class="myhome.admin.adminDAO"/>

<%
request.setCharacterEncoding("UTF-8");
String savefolder="img";
String savepath="";
ServletContext context=getServletContext();
savepath=context.getRealPath(savefolder);

int maxsize = 1024 * 1024 * 5;
try {
	MultipartRequest mr=new MultipartRequest(request, savepath, maxsize, "utf-8", new DefaultFileRenamePolicy());
	String cimg=mr.getFilesystemName("cimg");
	String cname=mr.getParameter("cname");
	
	int result=adao.addcategory(cimg, cname);
	String msg=result>0?"카테고리등록 성공":"등록 실패";
%>
<script>
window.alert('<%=msg%>');
window.self.close();
window.opener.location.reload();
location.href = "/myhome/admin/category.jsp";
</script>
<%
	} catch (Exception e) {
%>
<script>
	window.alert("용량이 크거나 알수없는 오류가 발생하였습니다.");
	history.back();

</script>

<%
	return;
	}
%>



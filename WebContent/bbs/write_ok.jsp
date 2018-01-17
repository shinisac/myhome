<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
    <!-- 임포트! -->
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<jsp:useBean id="bdto" class="myhome.bbs.bbsDTO"/>
<jsp:setProperty property="*" name="bdto"/>
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO"/>
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

	
	
	String savefolder="img/test/"+userid; //파일이 저장될 폴더명
	String savepath=request.getSession().getServletContext().getRealPath("/")+"img/test/"+userid;
	
	ServletContext context = getServletContext();
	savepath = context.getRealPath(savefolder);
	
	int maxsize=1024*1024*5;
		try{
	MultipartRequest mr=new MultipartRequest(request,savepath,maxsize,"utf-8",new DefaultFileRenamePolicy());
	String writer=mr.getParameter("bbs_writer");
	String subject=mr.getParameter("bbs_subject");
	String imgpath=mr.getFilesystemName("bbs_imgpath");
	String content=mr.getParameter("bbs_content");	
	
	int result=bdao.bbsWrite(writer,subject,imgpath,content);
	String msg=result>0?"게시글등록성공":"등록실패";
	%>
	<script>
	window.alert('<%=msg%>');
	if(<%=result%>>0){
		location.href="/myhome/bbs/bbslist.jsp";
	}else{
		location.href="/myhome/bbs/write.jsp";
	}
	
	</script>
	
	
	<%
}catch(Exception e){
	
 	%>
 	<script>
 	window.alert("용량이 크거나 알수없는 오류가 발생하였습니다.");	
 	
 	</script>
 	
 <%	return;
		}
%> 







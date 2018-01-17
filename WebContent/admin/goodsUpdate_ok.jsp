<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<!-- 임포트! -->
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>


<jsp:useBean id="adao" class="myhome.admin.adminDAO" />


<%
	int goods_idx=Integer.parseInt(request.getParameter("idx"));
	String savefolder = "img"; //파일이 저장될 폴더명
	String savepath = "";
	ServletContext context = getServletContext();
	savepath = context.getRealPath(savefolder);

	int maxsize = 1024 * 1024 * 5;
	try {
		MultipartRequest mr = new MultipartRequest(request, savepath, maxsize, "utf-8",
		new DefaultFileRenamePolicy());
		int category = Integer.parseInt(mr.getParameter("category"));
		String name = mr.getParameter("name");
		String img="";
		
		if(mr.getFilesystemName("img2")==null||mr.getFilesystemName("img2").equals("")){
			img= mr.getParameter("imgpath2");
		}else {
			img=mr.getFilesystemName("img2");
		}
		int price = Integer.parseInt(mr.getParameter("price"));
		int amount = Integer.parseInt(mr.getParameter("amount"));
		String content ="";
		if(mr.getFilesystemName("content")==null||mr.getFilesystemName("content").equals("")){
			content= mr.getParameter("imgpath");
		}else {
			content=mr.getFilesystemName("content");
		}
		String state = mr.getParameter("sl");
		
		int result = adao.updategoods(category, name, img, price, amount, content, state, goods_idx);
		String msg = result > 0 ? "상품수정성공" : "상품수정실패";
%>
<script>
	window.alert('<%=msg%>');
	if (<%=result%> > 0) {
		window.self.close();
		window.opener.location.href='/myhome/admin/admin_goods.jsp';
	} else {
		history.back();
	}
</script>


<%
	} catch (Exception e) {
%>
<script>
	window.alert("용량이 크거나 알수없는 오류가 발생하였습니다.");
	window.self.close();
	window.opener.location.href='/myhome/admin/admin_goods.jsp';
</script>

<%
	return;
	}
%>







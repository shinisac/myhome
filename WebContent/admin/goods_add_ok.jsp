<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<!-- 임포트! -->
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>


<jsp:useBean id="adao" class="myhome.admin.adminDAO" />


<%
	request.setCharacterEncoding("UTF-8");
	String savefolder = "img"; //파일이 저장될 폴더명
	String savepath = "";
	ServletContext context = getServletContext();
	savepath = context.getRealPath(savefolder);

	int maxsize = 1024 * 1024 * 5;
	try {
		MultipartRequest mr = new MultipartRequest(request, savepath, maxsize, "utf-8", new DefaultFileRenamePolicy());
		int category = Integer.parseInt(mr.getParameter("category"));
		String name = mr.getParameter("name");
		String img = mr.getFilesystemName("img");
		int price = Integer.parseInt(mr.getParameter("price"));
		int amount = Integer.parseInt(mr.getParameter("amount"));
		String content = mr.getFilesystemName("content");
		String state = mr.getParameter("state");
		
		int result = adao.addgoods(category, name, img, price, amount, content, state);
		String msg = result > 0 ? "상품등록성공" : "상품등록실패";
%>
<script>
	window.alert('<%=msg%>');
	if (<%=result%> > 0) {
		window.self.close();
		location.href = "/myhome/admin/admin_goods.jsp";
	} else {
		history.back();
	}
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







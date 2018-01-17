<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="myhome.Sfind.*" %>
<%request.setCharacterEncoding("utf-8"); %> <!-- 검색페이지의 인코딩 박식을 바꿈 -->    
<jsp:useBean id="fdao" class="myhome.Sfind.bbsFindDAO"/>
<%
String fkey=request.getParameter("fkey");
String fvalue=request.getParameter("fvalue");

ArrayList<bbsFindDTO> arr=fdao.bbsFind(fkey, fvalue);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
</head>
<body>
<table border="1" cellspacing="0" width="450">
<thead>
<tr>
<th>스토리 번호</th>
<th>스토리 아이디</th>
<th>이미지</th>
<th>스토리 제목</th>
</tr>
</thead>
<tbody>
<%
if(arr==null||arr.size()==0){
	%>
	<tr>
	<td colspan="3" align="center">
	검색된 상품이 없습니다.
	</td>
	</tr>
<%
}else{
	for(int i=0;i<arr.size();i++){
		%>
		<tr>
		<td><%=arr.get(i).getBbs_idx() %></td>
		<td><%=arr.get(i).getBbs_writer() %></td>
		<td>
		<a href="/myhome/bbs/content.jsp?idx2=<%=arr.get(i).getBbs_idx() %>">
		<img src="/myhome/img/test/<%=arr.get(i).getBbs_writer()%>/<%=arr.get(i).getBbs_imgpath() %>" alt="이미지"></a></td>
		<td><%=arr.get(i).getBbs_subject() %></td>
		</tr>
		<%
	}
} 
%>
</tbody>

</table>
</body>
</html>
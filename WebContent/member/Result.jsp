<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="myhome.find.*" %>
<%request.setCharacterEncoding("utf-8"); %> <!-- 검색페이지의 인코딩 박식을 바꿈 -->    
<jsp:useBean id="fdao" class="myhome.find.goodsFindDAO"/>
<%
String fkey=request.getParameter("fkey");
String fvalue=request.getParameter("fvalue");

ArrayList<goodsFindDTO> arr=fdao.goodsFind(fkey, fvalue);
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
<th>상품번호</th>
<th>제품이름</th>
<th>제품설명</th>
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
		<td><%=arr.get(i).getGoods_idx() %></td>
		<td><%=arr.get(i).getGoods_name() %></td>
		</tr>
		<%
	}
}
%>
</tbody>

</table>
</body>
</html>
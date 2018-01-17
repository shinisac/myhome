<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="myhome.find.*" %>
<%@page import="myhome.Sfind.*" %>
<%@ page import="myhome.store.*" %>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="fdao" class="myhome.find.goodsFindDAO"/>
<jsp:useBean id="bdao" class="myhome.Sfind.bbsFindDAO"/>
<jsp:useBean id="mdao" class="myhome.store.MyhomeDAO" scope="session"/>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 
%>
 	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>Myhome</title>
	<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
	</head>
<%
String sel_search = request.getParameter("sel_search");
String search = request.getParameter("search");

if(sel_search.equals("goods_name")){
	ArrayList<goodsFindDTO> arr=fdao.goodsFind(sel_search,search);
	%>
	<body>
	<%@include file="../header.jsp" %>
	<table width="1000" align="center">
		<tr>
			<td><h2><font color="skyblue">'<%=search %>'에 대한 검색결과</font></h2></td>
		</tr>
	</table>
	<table align="center">
	<tbody>
	<%
		if(arr==null||arr.size()==0){
		%>
		<tr>
			<td colspan="4" align="center">
				검색된 상품이 없습니다.
			</td>
		</tr>
	<%
	}else{
		%>
		<tr>
		<%
		for(int i = 0; i < arr.size(); i++){
			
		if(i%4==0){
			%></tr><tr><% 	}
			%>
	
		<td>
		 		<a href="/myhome/store/myhomeStoreContent.jsp?goods_idx=<%=arr.get(i).getGoods_idx()%>"><img src="../img/<%=arr.get(i).getGoods_imgpath()%>" width="200"height="200" onError="this.src='../img/defaultimg.jpg';"><br><font size="1" ><%=arr.get(i).getGoods_name() %><br><%=arr.get(i).getGoods_price() %>원</font></a>
		 	</td>
		<%		
		}%>
		</tr>			
	<% }
	%>
		
	</tbody>
	<%
}else{
	ArrayList<bbsFindDTO> arr2=bdao.bbsFind(sel_search,search);
%>
<body>
<%@include file="../header.jsp" %>
<table width="1000" align="center">
	<tr>
		<td><h2><font color="skyblue">'<%=search %>'에 대한 검색결과</font></h2></td>
	</tr>
</table>
<table align="center">
<tbody>
<%
	if(arr2==null||arr2.size()==0){
	%>
	<tr>
	<td colspan="4" align="center">
	등록된 게시글이 없습니다.
	</td>
	</tr>
<%
	}else{
		%>
		<tr>
		<%
		for(int i = 0; i < arr2.size(); i++){
			
		if(i%3==0){
			%></tr><tr><% 	}
			%>
	
		<td><a href="../bbs/content.jsp?idx2=<%=arr2.get(i).getBbs_idx()%>">
		<img src="/myhome/img/test/<%=arr2.get(i).getBbs_writer()%>/<%=arr2.get(i).getBbs_imgpath()%>"  width="350" height="200" onError="this.src='../img/defaultimg.jpg';"><br>
		좋아요 <%=arr2.get(i).getBbs_like() %>&nbsp;조회수 <%=arr2.get(i).getBbs_readnum()%><br>
		BoardNumber:<%=arr2.get(i).getBbs_idx() %><br>
		<%=arr2.get(i).getBbs_subject() %></a></td>
		<%		
		}%>
		</tr>			
	<% }
	%>
</tbody>
<%
}
%>
</table>
<%@include file="../footer.jsp" %>
</body>
</html>

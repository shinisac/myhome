<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="myhome.store.*" %>
<%@ page import="myhome.category.*" %>
<%@ page import="java.text.*" %> 
<jsp:useBean id="mdao" class="myhome.store.MyhomeDAO" scope="session"/>
<jsp:useBean id="cdao" class="myhome.category.CategoryDAO" scope="session"/>
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
<style>
	h2{
		text-align: center;
		color: skyblue;
	}
	nav{
	text-align: center;
	}
	nav li{
	list-style-type: none;
	display: inline;
	margin-left: 45px;
	}
	section{
		text-align: center;
	}
	a:link{
		color:black;
		font-size:13px;
		text-decoration:none;
	}
	a:visited{
		color:black;
		font-size:13px;
		text-decoration:none;
	}
	a:hover{
		color:skyblue;
		font-size:15px;
	}
	.dropdowns{
	    width:200px;
	    height:200px;
	    margin:10px auto;
	    overflow:hidden;
    }
	.dropdowns:hover{
    	cursor:pointer;
        -webkit-transform:scale(1.1); /*  크롬 */
        -moz-transform:scale(1.1); /* FireFox */
        -o-transform:scale(1.1); /* Opera */
        transform:scale(1.1);
        transition: transform .35s;
        -o-transition: transform .35s;
        -moz-transition: transform .35s;
        -webkit-transition: transform .35s;
    }
	.names{
    padding: 15px;
    text-align: center;
	}
</style>
</head>
<body>
<%
DecimalFormat df1 = new DecimalFormat("#,##0");
%>
<%@include file="../header.jsp" %>
<form method="POST">
<section>
	<a href="/myhome/store/myhomeStoreList.jsp"><h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;전 체 상 품</h2></a>
	<nav align="center">
		<ul>
		<%
		ArrayList<CategoryDTO> arr2=cdao.categoryList();
		
		for(int i=0;i<arr2.size();i++){
			%>
			<li>
			<a href="/myhome/store/myhomeStoreList.jsp?category=<%=arr2.get(i).getCategory_goods_num()%>">
				<img src="../img/<%=arr2.get(i).getCategory_goods_imgpath()%>" width="82"height="100">
			</a>
			</li>
			<%
		}
		
		%>	
		</ul>
	</nav>
</section>
<section>
	<table align="center" width="1000">
		<tbody>
		<%
		String category=request.getParameter("category");
		ArrayList<MyhomeDTO> arr = null;
		if(category==null||category.equals("")){
			
			arr=mdao.myhomeStoreList();
		}else{
			int idxs = Integer.parseInt(category);
			arr=cdao.myhomeCategoryList(idxs);
		}
		if(arr==null||arr.size()==0){
			%>
			<tr>
				<td colspan="4" align="center">
				등록된 게시글이 없습니다.
				</td>
			<tr>
			<%
		}else{
			%>
			<tr>
			<%
			for(int i=1;i<=arr.size();i++){
				int j=i-1;
			%>
		 	<td>
		 		<a href="/myhome/store/myhomeStoreContent.jsp?goods_idx=<%=arr.get(j).getGoods_idx()%>">
		 		<img src="../img/<%=arr.get(j).getGoods_imgpath()%>" width="250"height="250" class="dropdowns">
		 		<br>
		 		<font size="3" color="#323232"><%=arr.get(j).getGoods_name() %></font>
		 		<br>
		 		<font size="2"><b><%=df1.format(arr.get(j).getGoods_price()) %>원</b></font></font>
		 		</a>
		 	</td>
			 <%
				 if(i%4==0&&i!=arr.size()){
						%></tr>
			<tr><%
				}
		 	}
			%>
			</tr>
			<%
		}
			 %>
		</tbody>
	</table>
</section>
</form>
<%@include file="../footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="myhome.store.*" %>
<%@ page import="myhome.beans.*" %>
<%@ page import="myhome.category.*" %>
<%@ page import="myhome.bbs.*" %>
<%@ page import="java.text.*" %> 
<jsp:useBean id="mdao" class="myhome.store.MyhomeDAO" scope="session"/>
<jsp:useBean id="rdao" class="myhome.beans.myhomeDAO" scope="session"/>
<jsp:useBean id="cdao" class="myhome.category.CategoryDAO" scope="session"/>
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session"/>
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
<link rel="styLesheet" type="text/css" href="css/myhomeLayout.css">
<style type="text/css">
	#adimg{
		margin: 0px auto; 
	}
</style>
<script>
window.onload = function ad(){
	   
    var myImage=document.getElementById("adimg");
    var imageArray=["img/mainimg2.jpg","img/mainimg3.jpg","img/mainimg4.jpg"];
    var imageIndex=0;
 
    function changeImage(){
       myImage.setAttribute("src",imageArray[imageIndex]);
       imageIndex++;
       if(imageIndex>=imageArray.length){
          imageIndex=0;
       }
    }
    setInterval(changeImage,2000);
}
</script>
</head>
<body>
<%
DecimalFormat df1 = new DecimalFormat("#,##0");
%>
<%@include file="header.jsp" %>
<form method="POST">
<article>
		<a href="/myhome/store/myhomeStoreList.jsp"><img id="adimg" src="img/mainimg1.jpg" alt="메인이미지" width="100%" height="500"></a>
</article>
<div>
	<table width="1020" align="center">
	<tr>
		<td><h2><font color="skyblue" size="5">오늘의 상품</font></h2></td>
	</tr>
	<tr>
		<td><h3><font style=float:right size="5"> <a href="/myhome/store/myhomeStoreList.jsp">더보기</a></font></h3></td>
	</tr>
	</table>
	<table align="center" width="1000">
	<%   
	   String sl="goods_like";
	   ArrayList<MyhomeDTO> arr=mdao.myhomeStoreList();
	%>
	<tr>
	<%
	      for(int i=0;i<=4;i++){
	    	  if(i==arr.size()){
	    		  break;
	    	  }
	         %>
	         <td>
	         <a href="/myhome/store/myhomeStoreContent.jsp?goods_idx=<%=arr.get(i).getGoods_idx()%>"><img src="img/<%=arr.get(i).getGoods_imgpath()%>" width="200"height="200"><br><font size="2" color="darkgray"><b><%=arr.get(i).getGoods_name() %><br><%=df1.format(arr.get(i).getGoods_price())  %>원</b></font></a>
	         </td>
	          <%
	      }
	      %>
	</tr>   
	</table>
</div>
<table width="1020" align="center">
<tr>   
	<td><h2><font color="skyblue" size="5">오늘의 스토리</font></h2></td>
</tr>
<tr>
	<td><h3><font style=float:right size="5"> <a href="/myhome/bbs/bbslist.jsp" >더보기</a></font></h3></td>
</tr>
<table align="center" width="1000">
<%

   ArrayList<bbsDTO> barr=bdao.bbsListMain();
%>

<tr>
<%
      for(int i=0;i<=2;i++){
    	  if(i==barr.size()){
    		  break;
    	  }
         %>
         <td>
            <a href="/myhome/bbs/content.jsp?idx2=<%=barr.get(i).getBbs_idx()%>">
            <img src="/myhome/img/test/<%=barr.get(i).getBbs_writer()%>/<%=barr.get(i).getBbs_imgpath()%>" width="335"height="185" onError="this.src='/myhome/img/defaultimg.jpg';"><br>
            <font size="4" color="darkgray"><b>
            조회수&nbsp;<%=barr.get(i).getBbs_readnum() %> <img src="img/liketwo.jpg" width="13" height="13"> &nbsp;<%=barr.get(i).getBbs_like() %><br>
            <%=barr.get(i).getBbs_subject() %>
            </b></font></a>
         </td>
          <%
      }
      %>
</tr>
</table>
<table width="1020" align="center">
<tr>
	<td><h2><font color="skyblue" size="5">오늘의 판매랭킹</font></h2></td>
</tr>
<tr>
	<td><h3><font style=float:right size="5"> <a href="/myhome/beans/goods_rank.jsp?sl=goods_like">더보기</a></font></h3></td>
</tr>
<table align="center" width="1000">
<%

   ArrayList<myhomeDTO> rarr=rdao.index_goodsList();
%>
<tr>
<%
      for(int i=0;i<=2;i++){
    	  if(i==rarr.size()){
    		  break;
    	  }
         %>
               
               
                  <td>
                     <a href="/myhome/store/myhomeStoreContent.jsp?goods_idx=<%=rarr.get(i).getGoods_ranking_idx()%>">
                        <img src="/myhome/img/<%=rarr.get(i).getGoods_ranking_imgpath()%>" width="335"height="185">
                     </a>
                     <font size="4" color="skyblue"><strong><%=rdao.rownum(sl, rarr.get(i).getGoods_ranking_idx())%>위</strong></font>
                  
                     <a href="/myhome/store/myhomeStoreContent.jsp?goods_idx=<%=rarr.get(i).getGoods_ranking_idx()%>">
                        <font size="2" color="darkgray"><strong><%=rarr.get(i).getGoods_ranking_name()%></strong></font>
                     </a>
                  </td>
          <%
      }
      %>
</tr>
</table>
<br>
</form>
<%@include file="footer.jsp" %>
</body>
</html>
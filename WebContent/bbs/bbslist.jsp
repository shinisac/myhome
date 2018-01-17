<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
        <%@ page import="java.sql.*" %>
    <%@ page import="myhome.bbs.*"%>
  <jsp:useBean id="bdto" class="myhome.bbs.bbsDTO" scope="session"/>
		<jsp:setProperty property="*" name="bdto" />
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
<meta  charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
table{
width:900px;
height: 100px;
margin: auto;
text-align: center;
}
.dropdowns{
	    width:300px;
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
</style>
</head>
<%
    
    String userid=(String)session.getAttribute("sid");
%>
<%	
int totalCnt=bdao.getbbsTotalCnt();//총게시물수
int listSize=9; //보여줄 리스트수
int pageSize=5; //보여줄 페이지수

String cp_s=request.getParameter("cp");
if(cp_s==null||cp_s.equals("")){
	cp_s="1";
}
int cp=Integer.parseInt(cp_s);  //현재사용자위치

int totalPage=totalCnt/listSize+1;{
if(totalCnt%listSize==0)totalPage--;
}
int userGroup=cp/pageSize;{
if(cp%pageSize==0) userGroup--;
}
	
%>
	<%
	ArrayList<bbsDTO> arr=bdao.bbsList(cp, listSize);
	%>
<body>
<%@include file="../header.jsp" %>
<h2 align="center" size="5"><font color="skyblue">스토리</font></h2>
<section>
	<article>
		<form name="bbslist" method="POST">
			<table>
		
		<%
						if (arr == null || arr.size() == 0) {
					%>
					<tr>
						<td colspan="4" align="center">등록된 게시글이 없습니다.</td>
					</tr>
					
		<%	}else{
			%>
			<tr>
			<%
			for(int i = 0; i < arr.size(); i++)
				{
			if(i%3==0){
				%></tr><tr><% 	
					  }
				%>
		
		<td><a href="content.jsp?idx2=<%=arr.get(i).getBbs_idx()%>">
		<img src="/myhome/img/test/<%=arr.get(i).getBbs_writer()%>/<%=arr.get(i).getBbs_imgpath()%>" class="dropdowns"  width="300" height="200" onError="this.src='../img/defaultimg.jpg';"><br>
		<%=arr.get(i).getBbs_subject() %><br>
		<img src="../img/liketwo.jpg" width="10" height="10"> <%=arr.get(i).getBbs_like() %>&nbsp;조회수 <%=arr.get(i).getBbs_readnum()%><br>
		
		<img src="../img/user.jpg" width="10" height="14">&nbsp;&nbsp;<%=arr.get(i).getBbs_writer()%>님</a></td>
		
			<%		
					 
				}%>
			</tr>			
		<% }
		%>	

			</table>
											<!-- -------------------------- -->
	
	<p align="center">	<% //왼쪽 << 표시
	if(userGroup!=0){
		%><a href="bbslist.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a><%
	}
		%>

	<% //페이지 보여주기   1,2,3,4,5 
	for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
	%>&nbsp;&nbsp;<a href="bbslist.jsp?cp=<%=i%>"><%=i %></a>&nbsp;&nbsp;<%  
		if(i==totalPage) break;  //브레이크 건이유는 총페이지수가 13페이지인데 그룹때문에 15페이지까지나올때 브레이크걸어줌
	}
	%>
	<% //오른쪽 >>표시
		if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
		%><a href="bbslist.jsp?cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a><%
	}
	%> </p>
						<!-- -------------------------- -->
		</form>
	</article>
</section>
<%@include file="../footer.jsp" %>
</body>
</html>
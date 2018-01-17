<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="myhome.bbs.*"%>
 <%@ page import="java.sql.*" %>
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
<meta  charset=UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
	table{
			text-align: center;
			width:900px;
	}
	#bbslist{
			text-align: center;
			width:900px;
	}
	#bbslist th{
		border-bottom: 1px solid skyblue;
		background-color: skyblue;
		font-color:gray;
	}
	#bbslist td{
		border-bottom:1px solid #bbb;
		height: 30px;
	}	
	#bbslist a{
		font-weight: bold;
		font-size:15px;
	}
</style>
</head>

<%	
String writer=request.getParameter("writer");

int totalCnt=bdao.getUserTotalCnt(writer);//아이디의 게시물수
int listSize=5; //보여줄 리스트수
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


ArrayList<bbsDTO> member_arr=bdao.member_content(writer,cp,listSize);

%>	

<body>
<%@include file="../header.jsp" %>
<section>
	<article>
		<table width="1000" align="center">
			<tr>
				<td>
				<% for(int i=0;i<1;i++){
				%>
				<h2><font color="skyblue">'<%=member_arr.get(i).getBbs_writer() %>'님이 작성한 게시글</font></h2>
				<%
				}
				 %>
				</td>
			</tr>
		</table>
		<form method="POST">
			<table align="center" width="750"  id="bbslist">
			<tr>
				<th>번호</th>
				<th colspan="4" width="500" height="30">제목</th>
				<th>작성일</th>
				<th>조회</th>
			</tr>
			<% for(int i=0;i<member_arr.size();i++){
				%>
				<tr>
					<td><%=member_arr.get(i).getBbs_idx()%></td>
					<td colspan="4"><a href="content.jsp?idx2=<%=member_arr.get(i).getBbs_idx()%>"><%=member_arr.get(i).getBbs_subject() %></a></td>
					<td><%=member_arr.get(i).getBbs_writedate() %></td>
					<td><%=member_arr.get(i).getBbs_readnum() %></td>
				</tr>
				
			<%	
			}
			%>			
						<tfoot>	
					<tr>
						<td colspan="7" align="center">
						<!-- -------------------------- -->
						<% //왼쪽 << 표시
	if(userGroup!=0){
		%><a href="member_content.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a><%
	}
		%>

	<% //페이지 보여주기   1,2,3,4,5 
	for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
	%>&nbsp;&nbsp;<a href="member_content.jsp?cp=<%=i%>&writer=<%=writer%>"><%=i %></a>&nbsp;&nbsp;<%  
		if(i==totalPage) break;  //브레이크 건이유는 총페이지수가 13페이지인데 그룹때문에 15페이지까지나올때 브레이크걸어줌
	}
	%>
	<% //오른쪽 >>표시
		if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
		%><a href="member_content.jsp?cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a><%
	}
	%>
						<!-- -------------------------- -->
		</td>
			</tr>
							
			
			</tfoot>
			</table>
		</form>
	</article>

</section>
<%@include file="../footer.jsp" %>
</body>
</html>
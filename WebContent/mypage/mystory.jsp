<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="myhome.bbs.*"%>
<jsp:useBean id="bdto" class="myhome.bbs.bbsDTO" scope="session" />
<jsp:setProperty property="*" name="bdto" />
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session" />
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
%>	
<%	

int totalCnt=bdao.getUserTotalCnt(userid);//아이디의 게시물수
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


ArrayList<bbsDTO> arr=bdao.member_content(userid,cp,listSize);

%>	


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT ="-1">
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
</head>
<body>
	<%@include file="../header.jsp"%>
	<h2 align="center"><font color="skyblue"><%=sname%>님 스토리</font></h2>
	<section>
		<article>

			<form name="mystory" action="" method="POST">
				<table style="width: 900px; height: 300px;" align="center"
					cellspacing="2">

					<%
						if (arr == null || arr.size() == 0) {
					%>
					<tr>
						<td colspan="4" align="center">등록된 게시글이 없습니다.</td>
					</tr>

					<%
						} else {
					%>
					<tr>
						<%
							for (int i = 0; i < arr.size(); i++) {
								if(arr.get(i).getBbs_writer().equals(userid)){
									if (i % 3 == 0&&i!=arr.size()) {
						%>
					</tr>
					<tr>
						<%
									}		
						%>

						<td><a href="/myhome/mypage/mypage_bbsContent.jsp?state=mylist&idx2=<%=arr.get(i).getBbs_idx()%>">
							<img src="/myhome/img/test/<%=arr.get(i).getBbs_writer()%>/<%=arr.get(i).getBbs_imgpath()%>"
								 width="300"height="200" onError="this.src='../img/defaultimg.jpg';"><br> 좋아요 <%=arr.get(i).getBbs_like()%>&nbsp;조회수
								<%=arr.get(i).getBbs_readnum()%><br> BoardNumber:<%=arr.get(i).getBbs_idx()%><br>
								<%=arr.get(i).getBbs_subject()%></a></td>

						<%
									
								
							}
						}
						%>

					</tr>

					<%
						}
					%>

					<tr>

					</tr>


				</table>
			</form>
		</article>
	</section>




	<%@include file="../footer.jsp"%>
</body>
</html>
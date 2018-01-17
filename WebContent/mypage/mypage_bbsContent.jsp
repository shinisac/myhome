<%@page import="myhome.rip.ripDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %>
<%@ page import="myhome.bbs.*"%>
<%@ page import="myhome.rip.*"%>
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session"/>
<jsp:useBean id="rdto" class="myhome.rip.ripDTO" scope="session"/>
<jsp:setProperty property="*" name="rdto" />
<jsp:useBean id="rdao" class="myhome.rip.ripDAO"/>
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
	if(application.getAttribute("likeidx")==null){
		application.setAttribute("likeidx", null);
	}
	String m_id= request.getRemoteAddr();
	if(application.getAttribute("bbsreadidx")==null){
		ArrayList<String> list = new ArrayList<String>();
		HashMap<String,ArrayList> like = new HashMap<String,ArrayList>();
		like.put(m_id, list);
		application.setAttribute("bbsreadidx", like);
	}

	String idx_s=request.getParameter("idx2");
	
	HashMap<String,ArrayList> maps = new HashMap<String,ArrayList>();
	 maps = (HashMap)application.getAttribute("bbsreadidx");
	 boolean chk=false;
	 
	 if(!(maps.containsKey(m_id))){
	    	
	    	chk = true;
		    ArrayList<String> arr = new ArrayList<String>();
		   	arr.add(idx_s);
		    maps.put(m_id, arr);
		    application.setAttribute("bbsreadidx", maps);
		    
	   }else{
	   	ArrayList<String> list=maps.get(m_id);
	   	if(list.contains(idx_s)){
	   		chk=false;
 	}else{
	   		chk=true;
	   		list.add(idx_s);
	   		maps.put(m_id,list);
	   		application.setAttribute("bbsreadidx", maps);
 	}
	   }
	 int bbsread=Integer.parseInt(idx_s);
	 
	 if(chk){
	       bdao.readNum(bbsread);
	    }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT ="-1">
<meta  charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
	fieldset{
		border:1px solid #999;
		box-shadow:0 0 3px #999;
	}
	#mainImg{
		width: 670px;
		float: left;
	}
	#mainImg img{
		width: 670px;
	}
	#mainMenu{
		float: left;
	}
	#update{
		border: none; /*---테두리 정의---*/
	   background-Color: skyblue; /*--백그라운드 정의---*/
	   font: 12px 굴림; /*--폰트 정의---*/
	   font-weight: bold; /*--폰트 굵기---*/
	   color: white; /*--폰트 색깔---*/
	   width: 70px;
	   height: 30px; /*--버튼 크기---*/
	}
</style>
<%
	String userid=(String)session.getAttribute("sid");
%>	
<%	
	int count=0;
	String count_s="";

	int idx=Integer.parseInt(request.getParameter("idx2"));
	bbsDTO dto=bdao.bbsContent(idx);
	ArrayList<ripDTO> rarr=rdao.ripList(idx);
	
	if(dto==null){
	%>
	<script>
	window.alert('삭제된 게시글 또는 잘못된 접근입니다');
	window.href='bbslist.jsp';
	</script>
	<%
	return;
}
	%>
	<script>
	function ripButton(mode,rip_idx2){
	
		document.getElementById("mode").value=mode;
		document.getElementById("rip_idx2").value=rip_idx2;
		
		document.bbscontent.submit();
	}
	</script>
	<script>
	function delCheck(){
	
	window.open('mypage_bbsdelCheck.jsp?idx=<%=idx%>','delCheck','width=400 height=100');
	
	}
	</script>
</head>
<body>
<%@include file="../header.jsp" %>
<h2 align="center" size="5"><font color="skyblue">스토리</font></h2>
<section>
	<table align="center">
	<tr>
	<td>
	<article align="center" id="mainImg">
		<img src="/myhome/img/test/<%=dto.getBbs_writer()  %>/<%=dto.getBbs_imgpath() %>" width="600" height="400" onError="this.src='/myhome/img/defaultimg.jpg';">
	</article>
	<article id="mainMenu">
		<fieldset style="border:1px solid lightgray;width:300px;height:200px">
		<form name="bbscontent" action="ripwrite_ok.jsp" method="POST">
			<table width="290">
			<tr>
				<td>
				No.<%=dto.getBbs_idx()%> story
				<input type="hidden" name="rip_bbs_idx" value=<%=dto.getBbs_idx() %>>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<%=dto.getBbs_writer()%>님의 게시물
				</td>
			</tr>
			<tr >
				<td>
				<%=dto.getBbs_subject()%>
				<hr>
				</td>
			</tr>
			<tr>
				<td colspan="4" style="font-size:7;"><%=dto.getBbs_writedate()%></td>
			</tr>
			<tr>
				<td>
					<div>
					조회수:<%=dto.getBbs_readnum() %>
					<a href="like_ok.jsp?idx=<%=dto.getBbs_idx()%>&bbslike=<%=dto.getBbs_idx()%>">좋아요<img src="../img/like.jpg" width="10" height="10"></a><%=dto.getBbs_like()%>
				 	</div>
				 </td>
			</tr>
			<tr>
				<td colspan="4">
					<a href="/myhome/bbs/member_content.jsp?writer=<%=dto.getBbs_writer() %>" >이 작성자의 게시글더보기</a>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<img src="../img/share.jpg" width="130" height="30" usemap="#im">
					 <map name="im" border="0">
						<area shape="rect" coords="1,1,40,27" href="https://www.facebook.com/login.php?skip_api_login=1&api_key=966242223397117&signed_next=1&next=https%3A%2F%2Fwww.facebook.com%2Fsharer.php%3Fu%3Dhttps%253A%252F%252Fohou.se%252Fadvices%252F1616&cancel_url=https%3A%2F%2Fwww.facebook.com%2Fdialog%2Freturn%2Fclose%3Ferror_code%3D4201%26error_message%3DUser%2Bcanceled%2Bthe%2BDialog%2Bflow%23_%3D_&display=popup&locale=ko_KR">
						<area shape="rect" coords="41,1,84,27" href="https://story.kakao.com/s/login?continue=https%3A%2F%2Fstory.kakao.com%2Fs%2Fshare%3Furl%3Dhttps%253A%252F%252Fohou.se%252Fadvices%252F1616%26text%3D%25EA%25B0%2580%25EC%259E%25A5%2520%25EC%2589%25AC%25EC%259A%25B4%2520%25EC%259D%25B8%25ED%2585%258C%25EB%25A6%25AC%25EC%2596%25B4%2520%25EB%25A0%2588%25EC%258B%259C%25ED%2594%25BC%252C%2520%25EC%2598%25A4%25EB%258A%2598%25EC%259D%2598%25EC%25A7%2591%25EC%2597%2590%25EC%2584%259C%2520%25EC%2598%25A4%25EB%258A%2598%25EC%259D%2598%25EC%25A7%2591%2520%25EB%258B%2598%25EC%259D%2598%2520%25EA%25BE%25B8%25EB%25AF%25B8%25EA%25B8%25B0%25ED%258C%2581%2520%25EB%2585%25B8%25ED%2595%2598%25EC%259A%25B0%25EB%25A5%25BC%2520%25EA%25B3%25B5%25EC%259C%25A0%25ED%2595%25B4%25EC%259A%2594!%250A%250A%255B26%25EC%25B0%25A8%2520%25EC%25A3%25BC%25EA%25B0%2584%2520%25EC%259D%25B8%25EA%25B8%25B0%2520%25EC%2582%25AC%25EC%25A7%2584%2520BEST%25EB%25A5%25BC%2520%25EC%2586%258C%25EA%25B0%259C%25ED%2595%25A9%25EB%258B%2588%25EB%258B%25A4!%255D%250A%250A%25EC%2595%2588%25EB%2585%2595%25ED%2595%2598%25EC%2584%25B8%25EC%259A%2594!%2520%25EC%2598%25A4%25EB%258A%2598%25EC%259D%2598%25EC%25A7%2591%2520%25EA%25B0%2580%25EC%25A1%25B1%2520%25EC%2597%25AC%25EB%259F%25AC%25EB%25B6%2584!%250A%250A%25EC%2598%25A4%25EB%258A%2598%25EC%259D%2598%25EC%25A7%2591%25EC%2597%2590%2520%25EC%2598%25AC%25EB%259D%25BC%25EC%2598%25A8%2520%25EC%2582%25AC%25EC%25A7%2584%2520%25EC%25A4%2591%2520%25EC%259D%25B8%25EA%25B8%25B0%25EC%259E%2588%25EB%258A%2594%2520%25EC%2582%25AC%25EC%25A7%2584%25EC%259D%2584%2520%25EB%25B3%25B4%25EC%2597%25AC%25EB%2593%259C%25EB%25A6%25AC%25EA%25B3%25A0%250A%250A%25ED%258F%25AC%25EC%259D%25B8%25ED%258A%25B8%25EB%258F%2584%2520%25EC%2584%25A0%25EB%25AC%25BC%25EB%25A1%259C%2520%25EC%25A0%2584%25EB%258B%25AC%25ED%2595%2598%25EB%258A%2594%2520%25EC%258B%259C%25EA%25B0%2584%25EC%259E%2585%25EB%258B%2588%25EB%258B%25A4!%250A%250A%25EB%258D%2594%2520%25EB%25A7%258E%25EC%259D%2580%2520%25EC%25A0%2595%25EB%25B3%25B4%25EB%258A%2594%2520%25EC%2598%25A4%25EB%258A%2598%25EC%259D%2598%25EC%25A7%2591%25EC%2597%2590%25EC%2584%259C!%26kakao_agent%3Dsdk%252F1.16.0%2520os%252Fjavascript%2520lang%252Fko%2520device%252FWin32%2520origin%252Fhttps%25253A%25252F%25252Fohou.se%26app_key%3D3019c756ec77dd7e0a24e56d9d784f77&display=popup&referrer=https://ohou.se/advices/1616">
						<area shape="rect" coords="85,1,127,27" href="http://share.naver.com/web/shareView.nhn?url=https://ohou.se/advices/1616&title=%EC%98%A4%EB%8A%98%EC%9D%98%EC%A7%91%20%EC%A0%9C%ED%92%88%EC%9D%84%20%EA%B3%B5%EC%9C%A0%ED%95%A9%EB%8B%88%EB%8B%A4.">
						<!--circle,poly-->
					 </map>
				</td>
			</tr>
		</table>
	</fieldset>
	</article>
	</td>
	</tr>
	</table>	
</section>
<table width="1000" align="center">
	<tr >
		<td>
			<%
			if(dto.getBbs_content()==null||dto.getBbs_content().equals("")){
				%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 입력한 내용이 없습니다</td><% 
			}else{
				
			%>
			<%=dto.getBbs_content().replaceAll("\n", "<br>")%>
			</td>
		</tr>
		<%} %>
</table>
<hr color="lightgray">
<input type="hidden" id="mode" name="mode" >
<input type="hidden" id="rip_idx2" name="rip_idx2" >
<table align="center">
		<tr>
		<%
			if(userid==null||userid.equals("")){
				userid="비회원 로그인중";
				%><td><%=userid%></td>
				<td colspan="2" >
				<input type="text" name="rip_content_notlogin" placeholder="로그인후 이용가능합니다" size="80" readonly></td>
		<% 
		}else{
		%>
		<td><input type="hidden"  name="rip_member_id" value="<%=userid%>" readonly>
		<%=userid%></td>
		<td colspan="2"height="40"><input type="text" name="rip_content" placeholder="댓글을 입력하세요" size="85"></td>
		

		<td colspan="2"><input type="button" value="확인" onclick="javascript:ripButton('add')"></td>
		</tr>
		<%
		}
		%>
			<% 
			if (rarr == null || rarr.size() == 0) {
			%>
	<tr>
		<td colspan="4" align="center">등록된 댓글이 없습니다.</td>
	</tr>
	
		<%	}else{
			for(int i = 0; i < rarr.size(); i++){
			%> <tr><td>
			<%

				if(rarr.get(i).getRip_member_id().equals(userid)){
				%>
					<%=rarr.get(i).getRip_member_id()%></td>
			
				<td colspan="2">
					<input type="text" style="background-color:transparent;border:0 solid black;text-align:center;" name="rip_modify<%=rarr.get(i).getRip_idx()%>" value="<%=rarr.get(i).getRip_content()%>"size="85" >
				</td>
			
				<td colspan="">
					<input type="button" value="삭제" onclick="javascript:ripButton('del','<%=rarr.get(i).getRip_idx()%>')">
					<input type="button" value="수정" onclick="javascript:ripButton('modify','<%=rarr.get(i).getRip_idx()%>')">
				</td>
				<td style=float:right;>
					<%=rarr.get(i).getRip_bbs_writedate() %>
				<%
					}else {
				%>
				<%=rarr.get(i).getRip_member_id()%></td>
				<td colspan="3"><%=rarr.get(i).getRip_content()%></td>
				<td><%=rarr.get(i).getRip_bbs_writedate() %>
				<% 
					}			
			%></td></tr>
			<%
				}
			}	
				%>	
		</table>
</form>
<hr color="lightgray">
<table align="center">
	<tr>
		<td colspan="4">
			<input type="button" value="목록" id="update" onclick="location.href='bbslist.jsp'">
			<%
				if(dto.getBbs_writer().equals(userid)){
			%>
			<input type="button" value="수정" id="update" onclick="location.href='rewrite.jsp?idx=<%=dto.getBbs_idx()%>'" >
			<input type="button" value="삭제" id="update" onclick="delCheck()">
		
		<% }%>
		</td>
	</tr>
</table>
<%@include file="../footer.jsp" %>
</body>
</html>
<%@page import="myhome.rip.ripDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %>
<%@ page import="myhome.bbs.*"%>
<%@ page import="myhome.rip.*"%>
<%@ page import="java.text.*" %>
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session"/>
<jsp:useBean id="rdto" class="myhome.rip.ripDTO" scope="session"/>
<jsp:setProperty property="*" name="rdto" />
<jsp:useBean id="rdao" class="myhome.rip.ripDAO"/>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=UTF-8");


response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 
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
	 
	 SimpleDateFormat sdfdate = new SimpleDateFormat("MM/dd HH:mm:ss");
%>
<!DOCTYPE html>
<html>
<head>
<meta  charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
	#fsty{
		border:1px solid #999;
		box-shadow:0 0 3px #999;
	}
	.mainImg{
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
	.blue {
   -moz-box-shadow:inset 0px 1px 25px 0px #bbdaf7;
   -webkit-box-shadow:inset 0px 1px 25px 0px #bbdaf7;
   box-shadow:inset 0px 1px 25px 0px #bbdaf7;
   background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #79bbff), color-stop(1, #378de5) );
   background:-moz-linear-gradient( center top, #79bbff 5%, #378de5 100% );
   filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#79bbff', endColorstr='#378de5');
   background-color:#79bbff;
   -webkit-border-top-left-radius:20px;
   -moz-border-radius-topleft:20px;
   border-top-left-radius:20px;
   -webkit-border-top-right-radius:20px;
   -moz-border-radius-topright:20px;
   border-top-right-radius:20px;
   -webkit-border-bottom-right-radius:20px;
   -moz-border-radius-bottomright:20px;
   border-bottom-right-radius:20px;
   -webkit-border-bottom-left-radius:20px;
   -moz-border-radius-bottomleft:20px;
   border-bottom-left-radius:20px;
   text-indent:0;
   border:1px solid #84bbf3;
   display:inline-block;
   color:#ffffff;
   font-family:Malgun Gothic;
   font-size:12px;
   font-weight:bold;
   font-style:normal;
   height:25px;
   line-height:23px;
   width:45px;
   text-decoration:none;
   text-align:center;
   text-shadow:1px 1px 0px #528ecc;
}
.blue:hover {
   background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #378de5), color-stop(1, #79bbff) );
   background:-moz-linear-gradient( center top, #378de5 5%, #79bbff 100% );
   filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#378de5', endColorstr='#79bbff');
   background-color:#378de5;
}.blue:active {
   position:relative;
   top:1px;
}
	.edit{
		display: none;
	}
	.look{
		float:left;
		border:0px;
		font-size: 13px;
		height: 20px;
	}
	.lookt{
		float:left;
		border:0px;
		font-size: 13px;
		height: 20px;
	}	
	.editt{
		float:left;
		font-size: 13px;
		height: 20px;
	}
	div{
		float:left;
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
	
	window.open('delCheck.jsp?idx=<%=idx%>','delCheck','width=400 height=100');
	
	}
	function ripedit(idx){
		if(document.getElementById("look_"+idx).style.display == ''){
			document.getElementById("edit_"+idx).style.display='block';
			document.getElementById("look_"+idx).style.display = 'none';
			document.getElementById("bedit_"+idx).style.display='block';
			document.getElementById("blook_"+idx).style.display = 'none';			
			document.getElementById("editt_"+idx).focus();
		}else{
			document.getElementById("edit_"+idx).style.display='none';
			document.getElementById("look_"+idx).style.display = '';		
			document.getElementById("bedit_"+idx).style.display='none';
			document.getElementById("blook_"+idx).style.display = '';
			
		}	
		
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
	<article align="center" class="mainImg">
		<img src="/myhome/img/test/<%=dto.getBbs_writer()  %>/<%=dto.getBbs_imgpath() %>" width="600" height="400" alt="메인이미지" onError="this.src='../img/defaultimg.jpg';">
	</article>
	<article id="mainMenu">
		<fieldset id="fsty" style="border:1px solid lightgray;width:300px;height:230px">
		<form name="bbscontent" action="ripwrite_ok.jsp" >
			<table width="290">
			<tr>
				<td>
				<strong>No.<%=dto.getBbs_idx()%> Story</strong>
				<input type="hidden" name="rip_bbs_idx" value=<%=dto.getBbs_idx() %>>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<img src="../img/user.jpg" width="10" height="14"><strong><font size="2">&nbsp;&nbsp;<%=dto.getBbs_writer()%></strong>님의 게시물</font>
				</td>
			</tr>
			<tr >
				<td>
				<%=dto.getBbs_subject()%>
				<hr>
				</td>
			</tr>
			<tr>
				<td colspan="4"><font size="2"><%=dto.getBbs_writedate()%></font></td>
			</tr>
			<tr>
				<td>
					<a href="like_ok.jsp?idx=<%=dto.getBbs_idx()%>&bbslike=<%=dto.getBbs_idx()%>"><img src="../img/like.jpg" width="110" height="40"></a>
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
<table style="margin: 0px auto">
<tr>
<td>

<table width="550" style="margin: 0px auto; padding: 10px 30px 0px 30px" class="mainImg">
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
<fieldset style="border: 0;width:300px;height:230px">
</fieldset>
</td>
</tr>
</table>
<hr color="lightgray">
<input type="hidden" id="mode" name="mode" >
<input type="hidden" id="rip_idx2" name="rip_idx2" >
<table align="center">

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
					<div class="look" id="look_<%=rarr.get(i).getRip_idx()%>"><input class="lookt" type="text" name="rip<%=rarr.get(i).getRip_idx()%>" value="<%=rarr.get(i).getRip_content()%>"size="85" readOnly></div>
			        <div class="edit" id="edit_<%=rarr.get(i).getRip_idx()%>"><input class="editt" id="editt_<%=rarr.get(i).getRip_idx()%>" type="text" name="rip_modify<%=rarr.get(i).getRip_idx()%>" value="<%=rarr.get(i).getRip_content()%>"size="85"></div>
			  	</td>
			
				<td colspan="">
				<div id="blook_<%=rarr.get(i).getRip_idx()%>">
					<input type="button" value="수정" onClick="ripedit('<%=rarr.get(i).getRip_idx()%>')" class="blue">
					<input type="button" value="삭제" onclick="javascript:ripButton('del','<%=rarr.get(i).getRip_idx()%>')" class="blue">
				</div>	
				<div id="bedit_<%=rarr.get(i).getRip_idx()%>" style="display: none;">
					<input type="button" value="수정" onclick="javascript:ripButton('modify','<%=rarr.get(i).getRip_idx()%>')" class="blue">
					<input type="button" value="취소" onClick="ripedit('<%=rarr.get(i).getRip_idx()%>')" class="blue">
				</div>
				</td>
				<td style=float:right;>
					<%=sdfdate.format(rarr.get(i).getRip_bbs_writedate()) %>
				<%
					}else {
				%>
				<%=rarr.get(i).getRip_member_id()%></td>
				<td colspan="3"><%=rarr.get(i).getRip_content()%></td>
				<td><%=sdfdate.format(rarr.get(i).getRip_bbs_writedate()) %>
				<% 
					}			
			%></td></tr>
			<%
				}
			}	
				%>	
						<tr>
		<%
			if(userid==null||userid.equals("")){
				userid="Guest";
				%><td><%=userid%></td>
				<td colspan="2" >
				<input type="text" name="rip_content_notlogin" placeholder="로그인후 이용가능합니다" size="80" readonly></td>
		<% 
		}else{
		%>
		<td><input type="hidden"  name="rip_member_id" value="<%=userid%>" readonly>
		<%=userid%></td>
		<td colspan="2"height="40"><input type="text" name="rip_content" placeholder="댓글을 입력하세요" size="85"></td>
		

		<td colspan="2"><input type="button" value="확인" onclick="javascript:ripButton('add')" class="blue"></td>
		</tr>
		<%
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
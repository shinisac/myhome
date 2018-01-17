<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="myhome.bbs.*"%>
<%@ page import="myhome.rip.*"%>
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta  charset=UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
<style>
#main{
	width:600px;
	padding:0px 0px 0px 0px;
	margin:50px auto;
	border-top: 2px solid #ddd;
	border-left:  2px solid #ddd;
	border-right:  2px solid #ddd;
	border-bottom:  2px solid #ddd;
}
#main tbody{
 	text-align: center;
}
#main img{
	width:100%;
	height:400px;
	margin:0px auto;
}
#main tbody th{
	width:100px;
	height:40px;
	border-bottom: 2px solid #ddd;
	background-color: #EAEAEA;
}
#main td{
	border-bottom: 2px solid #ddd;
 	height:40px;
}
#main tfoot td{
	padding:0px 0px 0px 5px;
	border-bottom: 0px solid #ddd;
}
#main thead td{
	height:35px;
	padding:0px 0px 0px 5px;
	font-weight: bold;
	font-size: 18px;
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
String idx_s = request.getParameter("idx");
int idx=Integer.parseInt(idx_s);
bbsDTO dto=bdao.bbsContent(idx);
%>
</head>
<body>
<header>
	<div id="mainheader">
		
		<!-- 각 메뉴의 글자를 이미지로 대체하면 좋을 것으로 예상-->
		<div id="mainmenu">
			<a id="mainimg" href="/myhome/admin/admin_main.jsp">
				<img alt="마이홈 이미지로고" src="/myhome/img/mainhomeR.jpg" width="200" height="65">
			</a>
			
			<ul>
				<li class="dropmenu">
					<a href="javascript:void(0)" class="dropbtn">상품</a>
					<div class="dropmenu-content">
						<a href="javascript:location.href='admin_goods.jsp'">상품 리스트</a>
						<a href="javascript:location.href='goods_add.jsp'">상품 등록</a>
						<a href="javascript:location.href='goods_display.jsp'">상품 진열</a>
					</div>
				</li>
				
				<li class="dropmenu">
					<a href="javascript:void(0)" class="dropbtn">주문</a>
					<div class="dropmenu-content">
						<a href="goods_oreder.jsp">입금 현황</a>
						<a href="goods_oreder2.jsp">배송 현황</a>
						<a href="javascript:location.href='admin_sales.jsp'">매출 확인</a>
					</div>
				</li>
				
				<li class="dropmenu">
					<a href="javascript:void(0)" class="dropbtn">게시판</a>
					<div class="dropmenu-content">
						<a href="admin_bbslist.jsp">게시글 리스트</a>
						<a href="admin_bbsdellist.jsp">게시글 분류</a>
					</div>
				</li>
				
				<li class="dropmenu">
					<a href="javascript:void(0)" class="dropbtn">회원</a>
					<div class="dropmenu-content">
						<a href="admin_memberlist.jsp">회원 정보</a>
					</div>				
				</li>
				
				<li class="dropmenu">
					<a href="javascript:void(0)" class="dropbtn">분류</a>
					<div class="dropmenu-content">
						<a href="category.jsp">카테고리 등록</a>
					</div>				
				</li>
			</ul>
		</div>
	</div>
</header>
<div style="margin:0px auto;width:1000px">
<form name="fmgoodsimfo" method="POST">
<table	align="center" id="main">
			<thead>
				<tr>
					<td colspan="4" align="center">
						회원 스토리
					</td>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan="4" align="center">
						<input type="button" value="목록" onclick="location.href='admin_bbslist.jsp'" id="update">
					</td>
				</tr>	
			<tfoot>
			<tbody>
				<tr>
					<th>번호</th>
						<td align="left"><%=dto.getBbs_idx()%> 
							<input type="hidden" name="rip_bbs_idx" value=<%=dto.getBbs_idx() %>>
						</td>
					<th>조회수</th>
					<%
					%>
					<td align="left"><%=dto.getBbs_readnum()%></td>
				</tr>
				<tr>
					<th>글쓴이</th>
					<td align="left"><%=dto.getBbs_writer()%></td>
					<th>날짜</th>
					<td align="left"><%=dto.getBbs_writedate()%></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3" align="left">
					<%=dto.getBbs_subject()%></td>
				</tr>
				<tr >
					<td colspan="4">
						<img src="/myhome/img/test/<%=dto.getBbs_writer()  %>/<%=dto.getBbs_imgpath() %>" width="600" height="400" id="main"><br>
					</td>
				<tr >
					<td colspan="4" align="left" valign="top" >
					<%
					if(dto.getBbs_content()==null||dto.getBbs_content().equals("")){
						%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 입력한 내용이 없습니다</td><% 
					}else{
					%>
					<%=dto.getBbs_content().replaceAll("\n", "<br>")%>
					</td>
				</tr>
					<%
					} 
					%>
			</tbody>
		</table>
	</form>
</div>
</body>
</html>
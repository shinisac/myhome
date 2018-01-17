<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="myhome.bbs.*"%>
 
 <%@ page import="myhome.rip.*"%>
 <%@ page import="myhome.admin.*"%>
 <%@ page import="java.text.*" %>
<jsp:useBean id="rdto" class="myhome.rip.ripDTO" scope="session"/>
<jsp:setProperty property="*" name="rdto" />
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session"/>
<jsp:useBean id="rdao" class="myhome.rip.ripDAO"/>
<jsp:useBean id="admindao" class="myhome.admin.adminDAO" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta  charset=UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
<style>
article table{
	margin:40px auto;
	width:850px;
	text-align: center;
	border-collapse: collapse;

 	

}

article table th{
	height:35px;
	background-color: #EAEAEA;
	border-bottom: 2px solid #ddd;

}
article table td{
	border-bottom: 2px solid #ddd;
}
article table th a{
	color:black;
	text-decoration: none;
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
</head>

<%
String rip_membrer_id=request.getParameter("id");



int totalCnt=admindao.getUserRipTotalCnt(rip_membrer_id);//아이디의 리플수
int listSize=10; //보여줄 리스트수
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
SimpleDateFormat sdfdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>

<%


ArrayList<ripDTO> arr=admindao.adminRipList(rip_membrer_id,cp,listSize);

%>	

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
<section>
	<article>
		<form method="POST">
			<table>
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th colspan="4" width="500" height="30">제목</th>
				<th>작성일</th>
				<th>조회</th>
			</tr>
			<% for(int i=0;i<arr.size();i++){
				%>
				<tr>
					<td><%=arr.get(i).getRip_bbs_idx()%></td>
					<td><%=arr.get(i).getRip_member_id()%> </td>
					<td colspan="4"><a href="/myhome/admin/admin_rip_info.jsp?idx=<%=arr.get(i).getRip_bbs_idx()%>&id=<%=arr.get(i).getRip_member_id()%>"><%=arr.get(i).getRip_content() %></a></td>
					<td><%=sdfdate.format(arr.get(i).getRip_bbs_writedate())  %></td>
					<td>빈칸</td>
				</tr>
				
			<%	
			}
			%>			
						<tfoot>	
					<tr>
						<td colspan="8" align="center">
						<!-- -------------------------- -->
						<% //왼쪽 << 표시
	if(userGroup!=0){
		%><a href="admin_rip_detail.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a><%
	}
		%>

	<% //페이지 보여주기   1,2,3,4,5 
	for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
	%>&nbsp;&nbsp;<a href="admin_rip_detail.jsp?cp=<%=i%>&id=<%=rip_membrer_id%>"><%=i %></a>&nbsp;&nbsp;<%  
		if(i==totalPage) break;  //브레이크 건이유는 총페이지수가 13페이지인데 그룹때문에 15페이지까지나올때 브레이크걸어줌
	}
	%>
	<% //오른쪽 >>표시
		if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
		%><a href="admin_rip_detail.jsp?cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a><%
	}
	%>
						<!-- -------------------------- -->
		</td>
			</tr>
							
			
			</tfoot>
			</table>
		</form>
		<article align="center">
			<input type="button" value="목록으로" onClick="history.back();" id="update">
		</article>
	</article>
</section>
</body>
</html>
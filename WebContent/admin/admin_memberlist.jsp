<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="myhome.member.*"%>
<%@ page import="myhome.admin.*"%>
<%@ page import="java.text.*" %>
<jsp:useBean id="mdto" class="myhome.member.MemberDTO" scope="session"/>
<jsp:setProperty property="*" name="mdto" />
<jsp:useBean id="adto" class="myhome.admin.adminDTO" scope="session"/>
<jsp:setProperty property="*" name="adto" />
<jsp:useBean id="adao" class="myhome.admin.adminDAO" scope="session"/>
<!DOCTYPE html>
<%request.setCharacterEncoding("UTF-8"); %> 
<%
	String searchsel="";
	String searchtext="";
	String year="";
	String datemonth="";
	String dateday="";
	if(request.getParameter("searchsel")!=null){
		searchsel=request.getParameter("searchsel");

		if(request.getParameter("searchtext")!=null){
			if(!request.getParameter("searchtext").equals("")){
			searchtext=request.getParameter("searchtext");
			}	
		}
		if(request.getParameter("year")!=null){
			year=request.getParameter("year");
			datemonth=request.getParameter("month");
			dateday=request.getParameter("days");
			if(!(request.getParameter("year").equals(""))){
				int month = Integer.parseInt(request.getParameter("month"));
				int months = 1000+month;
				int day = Integer.parseInt(request.getParameter("days"));
				int days = 1000+day;
				datemonth =""+months;
				dateday = ""+days;
				searchtext=request.getParameter("year")+datemonth.substring(2,4)+dateday.substring(2,4);
			}
		}
	}	
	int totalCnt = adao.member_getmemberTotalCnt(searchsel,searchtext);//총게시물수
	int listSize = 7; //보여줄 리스트수
	int pageSize = 5; //보여줄 페이지수

	String cp_s = request.getParameter("cp");
	if (cp_s == null || cp_s.equals("")) {
		cp_s = "1";
	}
	int cp = Integer.parseInt(cp_s); //현재사용자위치

	int totalPage = totalCnt / listSize + 1;
	{
		if (totalCnt % listSize == 0)
			totalPage--;
	}
	int userGroup = cp / pageSize;
	{
		if (cp % pageSize == 0)
			userGroup--;
	}
%>
<html>
<head>
<meta  charset=UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
<style>
.dates{
	border:0px;
    width:30px;
    margin:0px 0px 0px 0px;
    text-align:center;
    
}
.date2{
	border:0px;
    width:15px;
    margin:0px 0px 0px 0px;
    
}
#di{
	display:none;
    width:80px;
    text-align:center;
    border: 1px solid gray;
    height:22px;
    padding:0px 0px 0px 0px;
    box-shadow:0px 0px 1px 0px inset;
    float:left;
}
.search{
	float:left;
	padding:0px 5px 0px 5px;
}
article table{
	margin:40px auto;
	width:850px;
	text-align: center;
	border-collapse: collapse;

 	

}

article table th{
	height:40px;
	background-color: #EAEAEA;
	border-bottom: 2px solid #ddd;

}
article table td{
	border-bottom: 2px solid #ddd;
	height:35px;
}
article table th a{
	color:black;
	text-decoration: none;
}
#cur:hover{
	cursor: pointer;
	
	
}
#main tr:hover{
 	background-color: #E6FFFF;
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

<script>
function displaydiv(value){
	if(value=='member_date'){
		document.getElementById('searchtext').style.display = 'none';
		document.getElementById('di').style.display='block';
	}else{
		document.getElementById('searchtext').style.display='block';
		document.getElementById('di').style.display = 'none';
	}
	
}
function memberlevel(obj,id,level){
	
	location.href='admin_member_ok.jsp?idx='+id+'&level='+level;
}
function memberimfo(idx){
	location.href='member_imfo.jsp?idx='+idx;
}
</script>
</head>
<%
	ArrayList<MemberDTO> arr=adao.member_admin(searchsel,searchtext,cp, listSize);
	SimpleDateFormat sdfCurrent = new SimpleDateFormat ("YYYY/MM/dd");
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
<h2 align="center">회원관리</h2>
	<form name="fmmember" action="admin_memberlist.jsp" method="POST">
		<table >
			<tr>
				<td >
					<div class="search">
						<select name="searchsel" onchange="displaydiv(this.value);">
							<option value=""<%if(searchsel.equals("")){%>selected<%} %>>검색조건</option>
							<option value="member_id"<%if(searchsel.equals("member_id")){%>selected<%} %>>ID</option>
							<option value="member_name"<%if(searchsel.equals("member_name")){%>selected<%} %>>가입자명</option>
							<option value="member_phone"<%if(searchsel.equals("member_phone")){%>selected<%} %>>전화번호</option>
							<option value="member_email"<%if(searchsel.equals("member_email")){%>selected<%} %>>e-mail</option>
							<option value="member_date"<%if(searchsel.equals("member_date")){%>selected<%} %>>가입날짜</option>
						</select>
					</div>
					<div class="search" id="searchtext"><input type="text" name="searchtext" ></div>
					<div id="di"><input class="dates" type="text" maxlength="4" name="year" >/<input class="date2" maxlength="2" type="text" name="month" >/<input class="date2" maxlength="2" type="text" name="days"></div>
					<div class="search"><input type="submit" value="검색" id="update"></div>	
				</td>
			</tr>
		</table>
	
		<table id="main">
			<tr>
				<th>회원번호</th>
				<th>등급</th>	
				<th>ID</th>
				<th>가입자명</th>
				<th>전화번호</th>
				<th>e-mail</th>
				<th>가입일</th>

			</tr>
			
			<%
				if(arr==null||arr.size() == 0){
					%>
					<tr>
					<td colspan="6">등록된 회원이 없습니다.</td>
					</tr>
					<%
				}else{
					
					for(int i=0; i<arr.size(); i++){
						%>
						<tr align="center">
							<td><%=arr.get(i).getMember_idx() %></td>
							
							<td>
								<input type="hidden" name="hi_idx" value="<%=arr.get(i).getMember_idx()%>">
								<select name="levelsel" onchange="memberlevel(this.form,'<%=arr.get(i).getMember_id()%>',this.value)">
									<option value="브론즈" <% if(arr.get(i).getMember_level().equals("브론즈")){%> selected<%}%>>브론즈</option>
									<option value="실버" <% if(arr.get(i).getMember_level().equals("실버")){%> selected<%}%>>실버</option>
									<option value="마스터" <% if(arr.get(i).getMember_level().equals("마스터")){%> selected<%}%>>마스터</option>
								</select>
							</td>	
													
							<td id="cur" onClick="memberimfo('<%=arr.get(i).getMember_idx()%>')"><%=arr.get(i).getMember_id() %></td>
							<td id="cur" onClick="memberimfo('<%=arr.get(i).getMember_idx()%>')"><%=arr.get(i).getMember_name() %></td>							
							<td id="cur" onClick="memberimfo('<%=arr.get(i).getMember_idx()%>')"><%=arr.get(i).getMember_phone() %></td>
							<td id="cur" onClick="memberimfo('<%=arr.get(i).getMember_idx()%>')"><%=arr.get(i).getMember_email() %></td>
							<td id="cur" onClick="memberimfo('<%=arr.get(i).getMember_idx()%>')"><%=sdfCurrent.format(arr.get(i).getMember_date()) %></td>

						</tr>
						<%
					}
				}
			%>
		
		</table>
		<p align="center">	
		<% //왼쪽 << 표시
		if(userGroup!=0){
			%><a href="admin_memberlist.jsp?searchsel=<%=searchsel%>&searchtext=<%=searchtext%>&year=<%=year%>&month=<%=datemonth%>&days=<%=dateday%>&cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a><%
		}
			%>
	
		<% //페이지 보여주기   1,2,3,4,5 
		for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
		%>&nbsp;&nbsp;<a href="admin_memberlist.jsp?searchsel=<%=searchsel%>&searchtext=<%=searchtext%>&year=<%=year%>&month=<%=datemonth%>&days=<%=dateday%>&cp=<%=i%>"><%=i %></a>&nbsp;&nbsp;<%  
			if(i==totalPage) break;  //브레이크 건이유는 총페이지수가 13페이지인데 그룹때문에 15페이지까지나올때 브레이크걸어줌
		}
		%>
		<% //오른쪽 >>표시
			if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
			%><a href="admin_memberlist.jsp?searchsel=<%=searchsel%>&searchtext=<%=searchtext%>&year=<%=year%>&month=<%=datemonth%>&days=<%=dateday%>&cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a><%
		}
		%> 
		</p>
		
		<div align="center">
			<input type="button" value="목록으로" onclick="location.href='admin_main.jsp'" id="update">
			<input type="button" value="탈퇴관리" onclick="location.href='admin_delmemlist.jsp'" id="update">
		</div>
		
	
	</form>
	</article>
	</section>
</body>
</html>
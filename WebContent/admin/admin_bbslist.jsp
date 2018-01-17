<%@page import="myhome.admin.adminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="myhome.bbs.*"%>
<%@ page import="myhome.admin.*"%>
<jsp:useBean id="bdto" class="myhome.bbs.bbsDTO" scope="session"/>
<jsp:setProperty property="*" name="bdto" />
<jsp:useBean id="admindao" class="myhome.admin.adminDAO" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta  charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="/myhome/css/adminmainmenu.css">
</head>
<style>
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

#title{
	padding:0px 0px 0px 20px;
}
#look{
	padding:0px 5px 0px 0px;
}
#tdline{
	border-right: 2px solid #ddd;
}
a{
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

<script>
//선택시 체크박스 전체선택
function allcheck()
	{
	var ck=document.fm.ckbox.length;
	
	for(i=0;i<ck;i++)
		{
		if(document.fm.ckboxmain.checked)
			{
			document.fm.ckbox[i].checked=true;
			document.fm.sel_bbs_state[i].disabled=false;
			}
		else{
			document.fm.ckbox[i].checked=false;
			document.fm.sel_bbs_state[i].disabled=true;
			}
		}
	}
</script>

<script>
//부분선택시 셀렉트박스 활성화
function checking()
	{
	var ck= document.fm.ckbox.length;
	
	for(i=0; i<ck; i++)
		{
		if(document.fm.ckbox[i].checked)
			{
			document.fm.sel_bbs_state[i].disabled=false;
			}else
			{
			document.fm.sel_bbs_state[i].disabled=true;
			}
		
		}
	}

</script>
<script>
//체크박스 선택후 글확인하는 펑션
//요약. 체크박스 체크가 트루라면 밸류값을 키값으로 다음페이지에 전달

function bbsinfo(){
	var num;
	var ck= document.fm.ckbox.length;
	for(i=0; i<ck; i++)
		{
			if(document.fm.ckbox[i].checked==true)
			{
				num=document.fm.ckbox[i].value;
				window.open('admin_bbs_info.jsp?idx='+num,'bbsinfo','width=200','height=100');
			}
				
		}
	
}

</script>
<script>
//체크박스 선택후 상태 변경하고 변경된값 넘기기
function bbs_state_modify()
	{
	
		fm.action='admin_bbs_state.jsp';
		fm.submit();

	}
</script>
<script>
//체크박스 선택후 글삭제(db완전삭제)
function bbsdel()
	{
	var num;
	var ck= document.fm.ckbox.length;
	for(i=0; i<ck; i++)
		{
			if(document.fm.ckbox[i].checked==true)
			{
				num=document.fm.ckbox[i].value;
				window.location='admin_bbs_del.jsp?idx='+num;
			}
		}
	}
</script>

			
<%	
String fkey="";
String sel=request.getParameter("sel");
String admin_bbs_find=request.getParameter("admin_bbs_find");
if(sel==null){
	sel="";
	admin_bbs_find="";
	fkey="";
}else if(sel.equals("번호")){
	fkey="bbs_idx";
	if(request.getParameter("admin_bbs_find").equals("")){
		admin_bbs_find="0";
	}
}else if(sel.equals("작성자")){
	fkey="bbs_writer";
}else if(sel.equals("제목")){
	fkey="bbs_subject";
}

int totalCnt=admindao.getbbslistTotalCnt(fkey,admin_bbs_find);//총게시물수
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
%>
<%



ArrayList<bbsDTO> arr=admindao.bbsList(fkey,admin_bbs_find,cp, listSize);

int idx=0;
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
<h2 align="center"><a href="admin_bbslist.jsp">게시판관리</a></h2>
	<form name="fm" action="admin_bbslist.jsp" method="POST">
		<table>
			<tr>
				<th id="tdline"><input type="checkbox" id="tdline" name="ckboxmain" onclick="javascript:allcheck()"></th>
				<th id="tdline">번호</th>
				<th id="tdline">상태</th>
				<th id="tdline">작성자</th>
				<th id="tdline">제목</th>
				<th id="tdline">작성일자</th>
				<th id="tdline">수정일자</th>
			</tr>
			
			<%
			if (arr == null || arr.size() == 0) {
		%>
			<tr>
				<td colspan="7" align="center">등록된 게시글이 없습니다.</td>
			</tr>
		
		<%	}else{
	
				for(int i = 0; i < arr.size(); i++){
					idx=arr.get(i).getBbs_idx();
					

		%>	<tr>
				<td id="tdline"><input type="checkbox" name="ckbox" value="<%=arr.get(i).getBbs_idx() %>" onclick="javascript:checking()"></td>
				<td id="tdline"><a href="admin_bbs_info.jsp?idx=<%=arr.get(i).getBbs_idx() %>"><%=arr.get(i).getBbs_idx() %></a></td>	
				<td id="tdline">
					<select name="sel_bbs_state" disabled>
						<option value="정상" <%=arr.get(i).getBbs_state().equals("정상")?"selected":"" %>>정상</option>
						<option value="보류" <%=arr.get(i).getBbs_state().equals("보류")?"selected":"" %>>보류</option>
						<option value="삭제" <%=arr.get(i).getBbs_state().equals("삭제")?"selected":"" %>>삭제</option>
					</select>
				</td>
				<td id="tdline"><%=arr.get(i).getBbs_writer() %></td>
				<td id="tdline"><a href="admin_bbs_info.jsp?idx=<%=arr.get(i).getBbs_idx() %>"><%=arr.get(i).getBbs_subject() %></a></td>

				<td id="tdline"><%=arr.get(i).getBbs_writedate() %></td>
				<td id="tdline"><%=arr.get(i).getBbs_editdate() %></td>
		<% 
		}	
	}
	%>
		</tr>
		</table>
													<!-- -------------------------- -->
	
	<p align="center">	<% //왼쪽 << 표시
	if(userGroup!=0){
		%><a href="admin_bbslist.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a><%
	}
		%>

	<% //페이지 보여주기   1,2,3,4,5 
	for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
	%>&nbsp;&nbsp;<a href="admin_bbslist.jsp?cp=<%=i%>"><%=i %></a>&nbsp;&nbsp;<%  
		if(i==totalPage) break;  //브레이크 건이유는 총페이지수가 13페이지인데 그룹때문에 15페이지까지나올때 브레이크걸어줌
	}
	%>
	<% //오른쪽 >>표시
		if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
		%><a href="admin_bbslist.jsp?cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a><%
	}
	%> </p>
						<!-- -------------------------- -->
	<p align="center">
		<input type="button" value="글확인" onclick="javascript:bbsinfo()" id="update">
		<input type="button" value="상태변경" onclick="javascript:bbs_state_modify()" id="update">
	
	</p>
	<p align="center">
		<select name="sel">
			<option   value="모두보기" >모두보기</option>
			<option   value="번호" <%=sel.equals("번호")?"selected":"" %>>번호</option>
			<option   value="작성자"<%=sel.equals("작성자")?"selected":"" %>>작성자</option>
			<option   value="제목"<%=sel.equals("제목")?"selected":"" %>>제목</option>
			<option   value="날짜"<%=sel.equals("날짜")?"selected":"" %>>날짜</option>
		</select>
		<input type="text" name="admin_bbs_find"  value=<%=admin_bbs_find.equals("0")?"":admin_bbs_find %>>
		<input type="submit" value="검색" id="update">
	</p>
	</form>

	</article>
</section>
</body>
</html>
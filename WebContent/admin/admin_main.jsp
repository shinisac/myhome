<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="myhome.goods.*" %>
<%@ page import="myhome.member.*" %>
<%@ page import="java.text.*" %>
<jsp:useBean id="adao" class="myhome.admin.adminDAO"/>
<!DOCTYPE html>
<html>
<head>
<meta  charset="UTF-8">
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

#title{
	padding:0px 0px 0px 20px;
}
#look{
	padding:0px 5px 0px 0px;
}
#tdline{
	border-right: 2px solid #ddd;
}
</style>
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
<section>
	<article>
		<table>
			<tr>
				<th colspan="5">
					<div id="title" style="float:left;">현재 등록된 상품 수 (<%=adao.goodsCount() %>)</div>
					<div id="look" style="float:right;"><a href="admin_goods.jsp">상세보기</a></div>
				</th>
			</tr>
			<tr>
				<th id="tdline">상품코드</th>
				<th id="tdline">상품명</th>
				<th id="tdline">가격</th>
				<th id="tdline">수량</th>
				<th>등록일</th>
			</tr>
<%
		DecimalFormat df1 = new DecimalFormat("#,##0");
		ArrayList<GoodsDTO> adds = adao.goodsMainList();
		SimpleDateFormat sdfCurrent = new SimpleDateFormat ("MM-dd hh:mm");
		if(adds==null||adds.size()==0){
			%>
			<tr>
				<td colspan="5">
					등록된 상품이 없습니다.
				</td>
			</tr>
			
			<%
			
		}else{
			for(int i=0;i<adds.size();i++){
				if(i==5){
					break;
				}
			%>
			<tr>
				<td id="tdline"><%=adds.get(i).getGoods_idx() %></td>
				<td id="tdline"><%=adds.get(i).getGoods_name() %></td>
				<td id="tdline"><%=df1.format(adds.get(i).getGoods_price()) %></td>
				<td id="tdline"><%=adds.get(i).getGoods_amount() %></td>
				<td ><%=sdfCurrent.format(adds.get(i).getGoods_date()) %></td>
			</tr>
			
			<%	

			}
		}
%>				
		</table>
		
		<table>
			<tr>
				<th colspan="5">
					<div id="title" style="float:left;">현재 진열된 상품 수  (<%=adao.goodsshowCount() %>)</div>
					<div id="look" style="float:right;"><a href="goods_display.jsp">상세보기</a></div>
				</th>
			</tr>
			<tr>
				<th id="tdline">상품코드</th>
				<th id="tdline">삼품명</th>
				<th id="tdline">가격</th>
				<th id="tdline">수량</th>
				<th>등록일</th>
			</tr>
<%
		ArrayList<GoodsDTO> shows = adao.goodsMainshowList();
		if(shows==null||shows.size()==0){
			%>
			<tr>
				<td colspan="5">
					진열된 상품이 없습니다.
				</td>
			</tr>

			<%
			
		}else{
			for(int i=0;i<shows.size();i++){
				if(i==5){
					break;
				}				
			%>
			<tr>
				<td id="tdline"><%=shows.get(i).getGoods_idx() %></td>
				<td id="tdline"><%=shows.get(i).getGoods_name() %></td>
				<td id="tdline"><%=df1.format(shows.get(i).getGoods_price()) %></td>
				<td id="tdline"><%=shows.get(i).getGoods_amount() %></td>
				<td><%=sdfCurrent.format(shows.get(i).getGoods_date()) %></td>
			</tr>
			
			<%	
			}
		}
%>			
		</table>
		
		<table>
			<tr>
				<th colspan="6">
					<div id="title" style="float:left;">현재 가입한 회원 수 (<%=adao.memberCount() %>)</div>
					<div id="look" style="float:right;"><a href="#">상세보기</a></div>
				</th>
			</tr>		
			<tr>
				<th id="tdline">회원코드</th>
				<th id="tdline">사용자 ID</th>
				<th id="tdline">성명</th>
				<th id="tdline">전화번호</th>
				<th id="tdline">E-Mail</th>
				<th>가입일자</th>
			</tr>
<%
		ArrayList<MemberDTO> member = adao.goodsMainmemberList();
		SimpleDateFormat sdfMember = new SimpleDateFormat ("YYYY-MM-dd");
		if(member==null||member.size()==0){
			%>
			<tr>
				<td colspan="6">
					가입된 회원이 없습니다.
				</td>
			</tr>
			
			<%
			
		}else{
			for(int i=0;i<member.size();i++){
				if(i==5){
					break;
				}				
			%>
			<tr>
				<td id="tdline"><%=member.get(i).getMember_idx()%></td>
				<td id="tdline"><%=member.get(i).getMember_id() %></td>
				<td id="tdline"><%=member.get(i).getMember_name()%></td>
				<td id="tdline"><%=member.get(i).getMember_phone()%></td>
				<td id="tdline"><%=member.get(i).getMember_email()%></td>
				<td><%=sdfMember.format(member.get(i).getMember_date())%></td>
			</tr>
			
			<%	
			}
		}
%>						
		</table>
	</article>
</section>



</body>
</html>
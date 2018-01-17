<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%> 
<%@ page import="myhome.member.*" %>
<jsp:useBean id="mdto" class="myhome.member.MemberDTO" scope="page"/>    
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="myhome.member.MemberDAO" scope="page"/>

<%
String member_pwd=request.getParameter("member_pwd");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<script>
	function pwdOpen(){
		window.open('/myhome/mypage/pwdUpdate.jsp','pwdup','width=500,height=150');
	}
	function memberDel(){
		location.href="/myhome/mypage/memberDel.jsp?member_pwd=<%=member_pwd%>";
	}
</script>
<style>
#me ul
{
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
   
}
#me li
{
    float: left;
}
#me li a, .dropbtn
{
    display: inline-block;
    color: black;
    text-align: center;
    padding: 5px 5px;
    text-decoration: none;
}
#me li a:hover, .dropdown:hover .dropbtn
{

}
#me li.dropdown
{
    display: inline-block;
}
#me .dropdown-content
{
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    left:-10px;
}
#me .dropdown-content a
{
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    text-align: left;
}
#me .dropdown-content a:hover
{
    background-color: #f1f1f1
}
#me .dropdown:hover .dropdown-content
{
    display: block;
}

</style>
   <style>
   a:link{
      color:black;
      font-size:13px;
      text-decoration:none;
   }
   a:visited{
      color:black;
      font-size:13px;
      text-decoration:none;
   }
   a:hover{
      color:skyblue;
      font-size:15px;
   }
   </style>
<script>
window.onpageshow = function (event) {
    if (event.persisted) {
    	// 뒤로가기로 페이지 로드 시
        console.log(event.persited);
    	location.replace('/myhome');
    }
}
    function openLogin() {
      window.open('/myhome/member/login.jsp','login','width=500,height=550');
   }
    function chk(){
    	var sear = document.getElementById("sh");
    	if(sear.style.display==''){
    		if(fm_header.search.value==''){
    			sear.style.display='none';
    		}else{
    			search();
    		}
    		
    		//alert('on');
    	}else{
    		sear.style.display='';
    		//alert('off');
    	}
    }
    function search(){
    	if(fm_header.search.value==''){
    		alert('검색어를 입력해주세요');
    		document.fm_header.search.focus();
    		return false;
    	}else{
    		fm_header.submit();
    	}
    	
    }    
    </script> 
<meta http-equiv="Cache-Control" content="no-cache"/> 
<meta http-equiv="Expires" content="0"/> 
<meta http-equiv="Pragma" content="no-cache"/> 
</head>
<body>

<%
    String sname=(String)session.getAttribute("sname");
   
%>    
<header>
<%
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);   
if (request.getProtocol().equals("HTTP/1.1")) 
        response.setHeader("Cache-Control", "no-cache"); 
%>   

<div style="width:100%; margin:0px auto;text-align:center;height:70px;">
	<div style="float:left;font-size:20px;margin:5px;width:18%;">
	<a href="/myhome/bbs/write.jsp" style="font-size:20px; float:left;"><img src="/myhome/img/write.jpg" width="40" height="40"></a>
	</div>
	
	<a href="/myhome/index.jsp" style="font-size:40px">
	<font face="">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/myhome/img/mainhome.jpg" width="130" height="40">
	</font></a>
	
	<div style="float:right; margin:5px;font-size:20px;width:250px;height:60px;position:relative;" ID="me" >
		<form name="fm_header" action="/myhome/member/Find_ok.jsp">
		<ul>
			 <li>
			  <a href="javascript:void(0);" onClick="chk();"><img src="/myhome/img/search.jpg" width="20" height="20"></a>
			  
			  <div id="sh" style="position:absolute;display:none;top:0px;width:230px;margin-left:-230px;text-align:left">
			  	<select name="sel_search" style="width:70px;font-size:10px;height:20px;">
			  		<optgroup label="스토리"/>
			  			<option value="bbs_writer">작성자</option>
			  			<option value="bbs_subject">제목+글내용</option>
			  		<optgroup label="스토어"/>
			  			<option value="goods_name">제품명</option>
			  	</select>
			  	<input type="text" name="search" style="width:140px;  onkeydown="if(event.keyCode==13){search();return;}"">
			  </div>
			  </li>
		<%if(sname==null || sname.equals("")){
	%>
			
			  <li><a href="/myhome/cart/cartPage.jsp"><img src="/myhome/img/cart.jpg" width="50" height="20"></a></li>
			  <li><a href="javascript:openLogin();">로그인</a></li>
			  <li><a href="/myhome/member/join.jsp">회원가입</a></li>
			</ul>
	
	<%
	}else{	
	%>		
			
			  <li><a href="/myhome/cart/cartPage.jsp"><img src="/myhome/img/cart.jpg" width="50" height="20"></a></li>
			  <li class="dropdown">
			    <a href="javascript:void(0)" class="dropbtn"><%=sname %>님</a>
			    <div class="dropdown-content">
			      <a href="/myhome/mypage/mystory.jsp">나의 스토리</a>
			      <a href="/myhome/mypage/mybuy.jsp">나의 쇼핑</a>
			      <a href="/myhome/mypage/memberUpdate.jsp">회원정보수정</a>
			      <a href="/myhome/bbs/write.jsp">스토리 올리기</a>
			      <a href="/myhome/member/logout.jsp">로그아웃</a>
			    </div>
			  </li>
			</ul>

	<%
	}
	%>
	</form>
	</div>
</div>
   <nav>
      <ul>

         <li><a href="/myhome/index.jsp">홈</a></li>
         <li><a href="/myhome/bbs/bbslist.jsp">스토리</a></li>
         <li><a href="/myhome/Ranking/goods_rank.jsp?sl=goods_like">가구랭킹</a></li>
         <li><a href="/myhome/store/myhomeStoreList.jsp">스토어</a></li>
      </ul>
   </nav>
   </header>
<section>
	<article>
		<%
		String userid=(String)session.getAttribute("sid");
		ArrayList<MemberDTO> arr=mdao.memberList(userid);
		if(arr==null||arr.size()==0){
			%>
			
			<%
		}else{
		for(int i=0;i<arr.size();i++){
			
		%>
		<h2 align="center">
		<%=arr.get(i).getMember_name() %>님 정보
		</h2>
		<form name="memberUpdate_ok" action="memberUpdate_ok.jsp">
		<table align="center">
			<tr>
				<th>회원번호</th>
				<td><%=arr.get(i).getMember_idx() %></td>
				<input type="hidden" name="member_idx" value="<%=arr.get(i).getMember_idx()%>">
			</tr>
			<tr>
				<th>회원상태</th>
				<td><%=arr.get(i).getMember_state() %></td>
				<input type="hidden" name="member_state" value="<%=arr.get(i).getMember_state() %>">
			</tr>
			<tr>
				<th>회원등급</th>
				<td><%=arr.get(i).getMember_level()%></td>
				<input type="hidden" name="member_level" value="<%=arr.get(i).getMember_level() %>">
			</tr>
			<tr>
				<th>회원아이디</th>
				<td><%=arr.get(i).getMember_id()%></td>
				<input type="hidden" name="member_id" value="<%=arr.get(i).getMember_id()%>">
			</tr>
			<tr>
				<th>회원비밀번호</th>
				<td>
					<input type="button" name="member_pwd" value="수정" onclick="pwdOpen()">
				</td>
			</tr>
			<tr>
				<th>회원이름</th>
				<td><%=arr.get(i).getMember_name()%></td>
				<input type="hidden" name="member_name" value="<%=arr.get(i).getMember_name()%>">
			</tr>
			<tr>
				<th>회원생년월일</th>
				<td><%=arr.get(i).getMember_birthday()%></td>
				<input type="hidden" name="member_birthday" value="<%=arr.get(i).getMember_birthday()%>">
			</tr>
			<tr>
				<th>회원성별</th>
				<td><%=arr.get(i).getMember_gen()%></td>
				<input type="hidden" name="member_gen" value="<%=arr.get(i).getMember_gen()%>">
			</tr>
			<tr>
				<th>회원전화번호</th>
				<td><input type="text" name="member_phone" value="<%=arr.get(i).getMember_phone()%>"></td>
			</tr>
			<tr>
				<th>E-Mail</th>
				<td><input type="text" name="member_email" value="<%=arr.get(i).getMember_email()%>"></td>
			</tr>
			<tr>
				<th>회원주소</th>
				<td><input type="text" name="member_addr" value="<%=arr.get(i).getMember_addr()%>"></td>
			</tr>
			<%
		
		}
			%>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="정보수정"> 
					<input type="button" value="탈퇴하기" onclick="memberDel()">
				</td>
			</tr>
		</table>
		</form>
				<%
		
		}
			%>	
	</article>
</section>
<footer>
	<hr color="skyblue">
	<p>
	<b>고객센터<b></b>
	<h3>1670-0876</h3>
	평일 10:00~17:00 (점심시간 12:00~13:00 / 주말&공휴일 제외)
	<nav>
		<ul>
			<li><a href=#>서비스 소개</a></li>
			<li><a href=#>이용약관</a></li>
			<li><a href=#>개인정보취급방침</a></li>
			<li><a href=#>고객의 소리</a></li>
			<li><a href=#>입점/제휴 문의</a></li>
		</ul>
	</nav>
	상호명 : (주)마이홈 이메일 : Myhome@naver.com 대표이사 : 최영우 사업자등록번호 : 111-11-11111
	통신판매업신고번호 : 제2014-서울관악-0792호 주소 : 서울특별시 관악구 남부순환로 1935 2층
	NICEPAY 안전거래 서비스 : 고객님의 안전거래를 위해 현금 결제 시, 저희 사이트에서 가입한 구매안전 서비스를 이용할 수 있습니다.
	Copyright © 2017 by Myhome Inc All Rights Reserved
	</p>
</footer>
</body>
</html>
















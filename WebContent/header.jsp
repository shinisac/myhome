<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
#me ul
{
    list-style-type: none;
    margin-top:0px;
    margin-right:-1px;
    padding: 0px;
    overflow: hidden;
   	float:right;
}
#me li
{
    text-align: Right;
    float:left;
}
#me li a, .dropbtn
{
    display: inline-block;
    color: black;
    text-align: center;
    padding: 5px 5px;
    text-decoration: none;
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
    min-width: 130px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    right: -1px;
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
nav{
	text-align: center;
}

</style>
<script>
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
<%
    String sname=(String)session.getAttribute("sname");
%>    
<header>
<div style="width:100%; margin:0px auto;text-align:center;height:70px;">
	<div style="float:left;font-size:20px;margin:5px;width:18%;">
	<a href="/myhome/bbs/write.jsp" style="font-size:20px; float:left;"><img src="/myhome/img/write.jpg" width="40" height="40"></a>
	</div>
	
	<a href="/myhome/index.jsp" style="font-size:40px">
	<font face="">
	<img src="/myhome/img/mainhome.jpg" width="130" height="40">
	</font></a>
	
	<div style="float:right; margin:5px;font-size:20px;width:250px;height:60px;position:relative;" ID="me" >
		<form name="fm_header" action="/myhome/member/Find_ok.jsp" method="POST">
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
			  	<input type="text" name="search" style="width:140px;  onkeydown="if(event.keyCode==13){search();return;}">
			  </div>
			  </li>
		<%if(session.getAttribute("sname")==null){
	%>
			
			  <li><a href="/myhome/cart/cartPage.jsp"><img src="/myhome/img/cart.jpg" width="50" height="20"></a></li>
			  <li><a href="/myhome/member/login.jsp">로그인</a></li>
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
			<li><a href="/myhome/index.jsp"><font size="2"><strong>홈</strong></font></a></li>
			<li><a href="/myhome/bbs/bbslist.jsp"><font size="2"><strong>스토리</strong></font></a></li>
			<li><a href="/myhome/beans/goods_rank.jsp?sl=goods_like"><font size="2"><strong>가구랭킹</strong></font></a></li>
			<li><a href="/myhome/store/myhomeStoreList.jsp"><font size="2"><strong>스토어</strong></font></a></li>
		</ul>
	</nav>
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
		font-size:13px;
	}
	</style>
</header>
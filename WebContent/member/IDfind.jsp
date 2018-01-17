<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 
%>
<!DOCTYPE>
<html>
<head>
<style>

   html, body
   {
      height: 20%;
   }
   
   body
   {
      text-align: center;
   }    

   #searchbox
   {
      background: #eaf8fc;
      background-image: -moz-linear-gradient(#fff, #d4e8ec);
      background-image: -webkit-gradient(linear,left bottom,left top,color-stop(0, #d4e8ec),color-stop(1, #fff));
      
      -moz-border-radius: 35px;
      border-radius: 35px;
      
      border-width: 1px;
      border-style: solid;
      border-color: #c4d9df #a4c3ca #83afb7;            
      width: 550px;
      height: 160px;
      padding: 10px;
      margin: 100px auto 50px;
      overflow: hidden;
   }

#search, #submit
{
   float: left;
}

#search
{
   padding: 5px 9px;
   height: 23px;
   width: 380px;
   border: 1px solid #a4c3ca;
   font: normal 13px 'trebuchet MS', arial, helvetica;
   background: #f1f1f1;
   
   -moz-border-radius: 50px 3px 3px 50px;
    border-radius: 50px 3px 3px 50px;
    -moz-box-shadow: 0 1px 3px rgba(0, 0, 0, 0.25) inset, 0 1px 0 rgba(255, 255, 255, 1);
    -webkit-box-shadow: 0 1px 3px rgba(0, 0, 0, 0.25) inset, 0 1px 0 rgba(255, 255, 255, 1);
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.25) inset, 0 1px 0 rgba(255, 255, 255, 1);            
}

/* ----------------------- */

#submit
{      
   background: #6cbb6b;
   background-image: -moz-linear-gradient(#95d788, #6cbb6b);
   background-image: -webkit-gradient(linear,left bottom,left top,color-stop(0, #6cbb6b),color-stop(1, #95d788));
   
   -moz-border-radius: 3px 50px 50px 3px;
   border-radius: 3px 50px 50px 3px;
   
   border-width: 1px;
   border-style: solid;
   border-color: #7eba7c #578e57 #447d43;
   
    -moz-box-shadow: 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 0 rgba(255, 255, 255, 0.3) inset;
    -webkit-box-shadow: 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 0 rgba(255, 255, 255, 0.3) inset;
    box-shadow: 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 0 rgba(255, 255, 255, 0.3) inset;         

   height: 35px;
   margin: 0 0 0 10px;
   padding: 0;
   width: 90px;
   cursor: pointer;
   font: bold 14px Arial, Helvetica;
   color: #23441e;
   
   text-shadow: 0 1px 0 rgba(255,255,255,0.5);
}

#submit:hover
{      
   background: #95d788;
   background-image: -moz-linear-gradient(#6cbb6b, #95d788);
   background-image: -webkit-gradient(linear,left bottom,left top,color-stop(0, #95d788),color-stop(1, #6cbb6b));
}   

#submit:active
{      
   background: #95d788;
   outline: none;
   
    -moz-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.5) inset;
    -webkit-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.5) inset;
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.5) inset;      
}

#submit::-moz-focus-inner
{
  border: none;
}      

/* ----------------------- */

#search::-webkit-input-placeholder {
   color: #9c9c9c;
   font-style: italic;
}

#search:-moz-placeholder {
   color: #9c9c9c;
   font-style: italic;
}    

#search.placeholder {
   color: #9c9c9c !important;
   font-style: italic;
}  

#search:focus
{
   border-color: #8badb4;
   background: #fff;
   outline: none;
}   

</style>

<style>

.button-3d {
  position:relative;
  width: auto;
  display:inline-block;
  color:#ecf0f1;
  text-decoration:none;
  border-radius:5px;
  border:solid 1px #f39c12;
  background:#e67e22;
  text-align:center;
  padding:16px 18px 14px;
  margin: 12px;
  
  -webkit-transition: all 0.1s;
   -moz-transition: all 0.1s;
   transition: all 0.1s;
   
  -webkit-box-shadow: 0px 6px 0px #d35400;
  -moz-box-shadow: 0px 6px 0px #d35400;
  box-shadow: 0px 6px 0px #d35400;
}

.button-3d:active{
    -webkit-box-shadow: 0px 2px 0px #d35400;
    -moz-box-shadow: 0px 2px 0px #d35400;
    box-shadow: 0px 2px 0px #d35400;
    position:relative;
    top:4px;
}
</style>
<script>
	function idCheck(){
		if(document.idFind.member_name.value==''){
			window.alert('이름을 입력해주세요.');
			document.idFind.member_name.focus();
			return false;
		}else if(document.idFind.member_email.value==''){
			window.alert('이메일을 입력해주세요.');
			document.idFind.member_email.focus();
			return false;
		}else{
			return true;//submit 보내기
		}
	}

	function pwdOpen(){
		var name='';
		var id='';
		if(document.pwdFind.member_name.value==''){
			window.alert('이름을 입력해주세요.');
			document.pwdFind.member_name.focus();
			name=document.pwdFind.member_name.value;
		
		}else if(document.pwdFind.member_id.value==''){
			window.alert('아이디를 입력해주세요.');
			document.pwdFind.member_id.focus();
			id=document.pwdFind.member_id.value;
		}else{
			name=document.pwdFind.member_name.value;
			id=document.pwdFind.member_id.value;
			 window.open('/myhome/member/PWDfind.jsp?name='+name+'&id='+id+'','login','width=500,height=130');
		}
		
		 
	}
	
	

</script>
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="stylesheet" type="text/css" href="../css/myhomeLayout.css">
</head>
<body>
<%@include file="../header.jsp" %>
<section>
   <article align="center">
   <form name="idFind" action="IDfind_ok.jsp" id="searchbox" onsubmit='return idCheck()' method="POST">
      <h2>아이디 찾기</h2>
               이&nbsp;&nbsp;&nbsp;름 <input type="text" name="member_name" placeholder="이름을 입력해주세요">
               이메일 <input type="text" name="member_email" placeholder="이메일을 입력해주세요"><br>
               <input type="submit" value="아이디찾기" class="button-3d">
   </form>
   </article>
</section>

<section>
	<article align="center">
	<form name="pwdFind" id="searchbox">
	<h2>비밀번호 찾기</h2>
					이&nbsp;&nbsp;&nbsp;름 <input type="text" name="member_name" placeholder="이름을 입력해주세요">
					아이디 <input type="text" name="member_id" placeholder="아이디을 입력해주세요"><br>
					<input type="button" value="비밀번호찾기" class="button-3d" onclick="pwdOpen()">
	</form>
	</article>
</section>
<%@include file="../footer.jsp" %>    
</body>
</html>
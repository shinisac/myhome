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
<meta charset="UTF-8">

<title>회원가입</title>               
<link rel="stylesheet" type="text/css" href="../css/myhomeLayout.css">

<script>
function openIdCheck(){
   window.open('IDcheck.jsp','idCheck','width=450,height=450');
}
function chkkor(value){
   return value.replace(/[^ㄱ-ㅎㅏ-ㅣ가-힁]/gi,"");
   
}
function chkjoo(value){
   return value.replace(/[^0-9-]/gi,"");
   
}
function chkemail(value){
   return value.replace(/[^_0-9a-zA-Z@\.]/gi,"");
   
}
function chkphone(value){
   return value.replace(/[^-0-9]/gi,"");
   
}
function AddNum(obj) 
{
  var n = obj.value;
  var reg = /(\d{4})(\d{2})(\d{2})/;
  n += '';                          
  while (reg.test(n))
  n = n.replace(reg, '$1' + '-' + '$2'+ '-' + '$3');  
  obj.value = n;     
}
function AddPhone(obj) 
{
  var n = obj.value;
  var reg = /(\d{3})(\d{4})(\d{4})/;
  n += '';                          
  while (reg.test(n))
  n = n.replace(reg, '$1' + '-' + '$2'+ '-' + '$3');  
  obj.value = n;     
}
function allchk(){
   var pwd=/^[0-9a-zA-Z]+$/;
   var bir = /^(\d{4})-(\d{2})-(\d{2})+$/;
   var phone=/^01(?:0|1|[\d])-(\d{4})-\d{4}$/;
   var name = /^[가-힁]+$/;
   var email = /^[_\w-]+@[\._\w-]+\.[a-zA-Z]+$/;
   if(join.member_id.value==''){
      alert("아이디를 확인해주세요.");
      document.join.member_id.focus();
      return false;
   }else if(join.member_pwd.value.length<8){
      alert("비밀번호를 8글자 이상 입력해주세요.");
      document.join.member_pwd.focus();
      return false;
   }else if(!join.member_pwd.value.match(pwd)){
      alert("비밀번호 조건이 맞지않습니다.");
      document.join.member_pwd.focus();
      return false;

   }else if(document.join.member_pwd.value!=document.join.member_pwdok.value){
      alert("비밀번호를 확인해주세요.");
      document.join.member_pwd.focus();
      return false;
   }else if(document.join.member_name.value<1){
      alert("이름을 입력해주세요.");
      document.join.member_name.focus();
      return false;
      
   }else if(!join.member_name.value.match(name)){
      alert("이름은 한글로 입력해주세요.");
      document.join.member_name.focus();
      return false;   
      
   }else if(document.join.member_birthday.value==''){
      alert("생년월일을 형식에 맞게 입력해주세요.");
      document.join.member_birthday.focus();
      return false;   
      
   }else if(!join.member_birthday.value.match(bir)){
         alert("생년월일은 1999-01-01 형식으로 입력해주세요.");
         document.join.member_birthday.focus();
         return false;   
      
   }else if(document.join.member_addr.value==''){
      alert("주소를 입력해주세요.");
      document.join.member_addr.focus();
      return false;      
      
   }else if(document.join.member_phone.value==''){
      alert("전화번호를 입력해주세요.");
      document.join.member_phone.focus();
      return false;   
      
   }else if(!join.member_phone.value.match(콜)){
      alert("전화번호형식을 확인해주세요.");
      document.join.member_phone.focus();
      return false;   
      
   }else if(document.join.member_email.value==''){
      alert("이메일을 입력해주세요.");
      document.join.member_email.focus();
      return false;      
      
   }else if(!join.member_email.value.match(email)){
      alert("이메일형식을 확인해주세요.");
      document.join.member_email.focus();
      return false;   
      
   }else{
      join.submit();
      return false;
   }
   
   
}

</script>
<style rel="stylesheet">
@charset "UTF-8";
@import url(https://fonts.googleapis.com/css?family=Lato:400,700);
* {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}

body {
  font-family: 'Lato', sans-serif;
}
body .container {
  position: relative;
  overflow: hidden;
  width: 720px;
  height: 1080px;
  margin: 80px auto 0;
  background-color: #FAFAFA;
  -moz-box-shadow: rgba(0, 0, 0, 0.1) 0px 10px 30px;
  -webkit-box-shadow: rgba(0, 0, 0, 0.1) 0px 10px 30px;
  box-shadow: rgba(0, 0, 0, 0.1) 0px 10px 30px;
}
body .container .half {
  float: left;
  width: 50%;
  height: 100%;
  padding: 58px 40px 0;
}
body .container .half.bg {
 background-image: url("../img/joinmain.jpg");
 background-size: auto;
}
body .container h1 {
  font-size: 18px;
  font-weight: 550;
  margin-bottom: 23px;
  text-align: center;
  text-indent: 6px;
  letter-spacing: 7px;
  text-transform: uppercase;
  color: #263238;
}
body .container .tabs {
  width: 100%;
  margin-bottom: 29px;
  border-bottom: 1px solid #d9d9d9;
}
body .container .tabs .tab {
  display: inline-block;
  margin-bottom: -1px;
  padding: 20px 15px 10px;
  cursor: pointer;
  letter-spacing: 0;
  border-bottom: 1px solid #d9d9d9;
  -moz-user-select: -moz-none;
  -ms-user-select: none;
  -webkit-user-select: none;
  user-select: none;
  transition: all 0.1s ease-in-out;
}
body .container .tabs .tab a {
  font-size: 11px;
  text-decoration: none;
  text-transform: uppercase;
  color: #d9d9d9;
  transition: all 0.1s ease-in-out;
}
body .container .tabs .tab.active a, body .container .tabs .tab:hover a {
  color: #263238;
}
body .container .tabs .tab.active {
  border-bottom: 1px solid #263238;
}
body .container .content form {
  position: relative;
  height: 287px;
}
body .container .content label:first-of-type, body .container .content input:first-of-type, body .container .content .more:first-of-type {
  -moz-animation: slideIn 0.4s cubic-bezier(0.37, 0.82, 0.2, 1);
  -webkit-animation: slideIn 0.4s cubic-bezier(0.37, 0.82, 0.2, 1);
  animation: slideIn 0.4s cubic-bezier(0.37, 0.82, 0.2, 1);
}
body .container .content label:nth-of-type(2), body .container .content input:nth-of-type(2), body .container .content .more:nth-of-type(2) {
  -moz-animation: slideIn 0.5s cubic-bezier(0.37, 0.82, 0.2, 1);
  -webkit-animation: slideIn 0.5s cubic-bezier(0.37, 0.82, 0.2, 1);
  animation: slideIn 0.5s cubic-bezier(0.37, 0.82, 0.2, 1);
}
body .container .content label:nth-of-type(3), body .container .content input:nth-of-type(3), body .container .content .more:nth-of-type(3) {
  -moz-animation: slideIn 0.6s cubic-bezier(0.37, 0.82, 0.2, 1);
  -webkit-animation: slideIn 0.6s cubic-bezier(0.37, 0.82, 0.2, 1);
  animation: slideIn 0.6s cubic-bezier(0.37, 0.82, 0.2, 1);
}
body .container .content label {
  font-size: 12px;
  color: #263238;
  -moz-user-select: -moz-none;
  -ms-user-select: none;
  -webkit-user-select: none;
  user-select: none;
}
body .container .content label:not([for='remember']) {
  display: none;
}
body .container .content input.inpt {
  font-size: 14px;
  display: block;
  width: 100%;
  height: 42px;
  margin-bottom: 12px;
  padding: 16px 13px;
  color: #999999;
  border: 1px solid #d9d9d9;
  background: transparent;
  -moz-border-radius: 2px;
  -webkit-border-radius: 2px;
  border-radius: 2px;
}
body .container .content input.inpt::-webkit-input-placeholder {
  font-size: 14px;
  color: #999999;
  font-family: 'Lato', sans-serif;
}
body .container .content input.inpt:-moz-placeholder {
  font-size: 14px;
  color: #999999;
  font-family: 'Lato', sans-serif;
}
body .container .content input.inpt::-moz-placeholder {
  font-size: 14px;
  color: #999999;
  font-family: 'Lato', sans-serif;
}
body .container .content input.inpt:-ms-input-placeholder {
  font-size: 14px;
  color: #999999;
  font-family: 'Lato', sans-serif;
}
body .container .content input.inpt:focus {
  border-color: #999999;
}
body .container .content input.submit {
  font-size: 12px;
  line-height: 42px;
  display: block;
  width: 100%;
  height: 42px;
  cursor: pointer;
  vertical-align: middle;
  letter-spacing: 2px;
  text-transform: uppercase;
  color: #263238;
  border: 1px solid #263238;
  background: transparent;
  -moz-border-radius: 2px;
  -webkit-border-radius: 2px;
  border-radius: 2px;
}
body .container .content input.submit:hover {
  background-color: #263238;
  color: #ffffff;
  -moz-transition: all 0.2s;
  -o-transition: all 0.2s;
  -webkit-transition: all 0.2s;
  transition: all 0.2s;
}
body .container .content input:focus {
  outline: none;
}
body .container .content .checkbox {
  margin-top: 4px;
  overflow: hidden;
  clip: rect(0 0 0 0);
  width: 0;
  height: 0;
  margin: 17px -1px;
  padding: 0;
  border: 0;
}
body .container .content .checkbox + label {
  vertical-align: middle;
  display: inline-block;
  width: 50%;
}
body .container .content .checkbox + label:before {
  content: "\A";
  color: #999999;
  font-family: Verdana;
  font-weight: bold;
  font-size: 8px;
  line-height: 10px;
  text-align: center;
  display: inline-block;
  vertical-align: middle;
  position: relative;
  -moz-border-radius: 2px;
  -webkit-border-radius: 2px;
  border-radius: 2px;
  background: transparent;
  border: 1px solid #d9d9d9;
  width: 11px;
  height: 11px;
  margin: -2px 8px 0 0;
}
body .container .content .checkbox:checked + label:before {
  content: "✓";
}
body .container .content .submit-wrap {
  bottom: 0;
  width: 100%;
}
body .container .content .submit-wrap a {
  font-size: 12px;
  display: block;
  margin-top: 20px;
  text-align: center;
  text-decoration: none;
  color: #999999;
}
body .container .content .submit-wrap a:hover {
  text-decoration: underline;
}
body .container .content .signin-cont {
  display: none;
}

@keyframes slideIn {
  0% {
    filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
    opacity: 0;
    margin-left: -320px;
  }
  100% {
    filter: progid:DXImageTransform.Microsoft.Alpha(enabled=false);
    opacity: 1;
    margin-left: 0px;
  }
}
@-webkit-keyframes slideIn {
  0% {
    filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
    opacity: 0;
    margin-left: -320px;
  }
  100% {
    filter: progid:DXImageTransform.Microsoft.Alpha(enabled=false);
    opacity: 1;
    margin-left: 0px;
  }
}
.credits {
  display: block;
  position: absolute;
  right: 0;
  bottom: 0;
  color: #999999;
  font-size: 14px;
  margin: 0 10px 10px 0;
}
.credits a {
  filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=80);
  opacity: 0.8;
  color: inherit;
  font-weight: 700;
  text-decoration: none;
}

/* 구분선 밑에는 라디오 css*/

</style>

</head>
<%
   Cookie cks[]=request.getCookies();
String saveid="";
if(cks!=null){
   for(int i=0; i<cks.length; i++){
      if(cks[i].getName().equals("saveid")){
         saveid=cks[i].getValue();
   }
}
}
   %>
   
<body>

<%@include file="../header.jsp" %>

<section class="container">
          <article class="half">
                 <div class="tabs">
                 <h1>회원가입</h1>
                        <span class="tab signup active"><a href="#signup">Sign up</a></span>
                 </div>
                 <div class="content">
                        <div class="signup-cont cont">
                <form action="join_ok.jsp" method="post" name="join" onsubmit="return allchk();">
                                      
                                            <br>아이디<input type="text" name="member_id" class="inpt"  required="required" placeholder="ID입력은 밑에 중복확인 버튼 클릭" readonly>
                                            <input type="button" value="아이디 중복확인" class="submit" onclick="openIdCheck()">
                                         
                                       <br>비밀번호<input type="password" name="member_pwd" class="inpt" required="required" placeholder="비밀번호를 입력해주세요">
                                       
                                      비밀번호 확인<input type="password" name="member_pwdok" class="inpt" required="required" placeholder="비밀번호를 한번 더 입력해주세요">
                                      
                                      이름<input type="text" name="member_name" class="inpt" required="required" placeholder="이름을 적어주세요" onKeyup="this.value=chkkor(this.value)">
                                      
                                      생년월일<input type="text" name="member_birthday" class="inpt" required="required" placeholder="ex) 1999-01-01" maxlength="10" onKeyup="this.value=chkjoo(this.value);AddNum(this);">
                                      
                                      주소<input type="text" name="member_addr" class="inpt" required="required" placeholder="집주소를 적어주세요" >
                                      
                                      성별<br><input type="radio" name="member_gen" value="남자" checked>남자
                                      <input type="radio" name="member_gen" value="여자">여자<br><br>
                                      
                                      핸드폰<input type="text" name="member_phone" class="inpt" required="required" placeholder="핸드폰 번호를 적어주세요" maxlength="13" onKeyup="this.value=chkphone(this.value);AddPhone(this);" >
                                      
                                      이메일<input type="text" name="member_email" required="required" class="inpt" placeholder="이메일을 적어주세요" onKeyup="this.value=chkemail(this.value)">
                                      <br>
                                      <div class="submit-wrap">
                                             <input type="submit" value="회원가입하기" class="submit"><br>
                                             <input type="reset" value="다시작성" class="submit">
                     </div>
                    </form>
                     </div>
                 </div>
          </article>
          <div class="half bg"></div>
          <br>    
   </section>
<%@include file="../footer.jsp" %>



<script>

$('.tabs .tab').click(function(){
    if ($(this).hasClass('signin')) {
        $('.tabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signin-cont').show();
    } 
    if ($(this).hasClass('signup')) {
        $('.tabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signup-cont').show();
    }
});
$('.container .bg').mousemove(function(e){
    var amountMovedX = (e.pageX * -1 / 30);
    var amountMovedY = (e.pageY * -1 / 9);
    $(this).css('background-position', amountMovedX + 'px ' + amountMovedY + 'px');
});
</script>
<%
   response.setHeader("pragma", "no-cache");
   response.setHeader("cache-control", "no-cache");
   response.addHeader("cache-control", "no-store");
   response.setDateHeader("Expires", 0);
%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %> 
<%
request.setCharacterEncoding("utf-8");

Map<String, String[]> m = request.getParameterMap();

if( m.keySet().size() == 0 ) {
	%>
	<script>
		alert('[접근오류]');
		location.replace('/myhome');
	</script>
	<%	
		return;
}
%>
<jsp:useBean id="mdao" class="myhome.member.MemberDAO"/>
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 

%>
<%
String userid=request.getParameter("userid");
String userpwd=request.getParameter("userpwd");
String saveid=request.getParameter("saveid");

int result=mdao.loginCheck(userid, userpwd);
	
if(result==mdao.LOGIN_OK){
	String username=mdao.getUserInfo(userid);
	session.setAttribute("sid", userid);
	session.setAttribute("sname", username);
	session.setAttribute("spwd", userpwd);
	
	String savepath=request.getSession().getServletContext().getRealPath("/")+"img/test/"+userid;
	File f=new File(savepath);
	if(!f.exists()){
		f.mkdir();
	}

	if(saveid==null || saveid.equals("")){
		Cookie ck=new Cookie("saveid", userid);
		ck.setMaxAge(0);
		response.addCookie(ck);
	}else{
		Cookie ck=new Cookie("saveid", userid);
		ck.setMaxAge(60*60*24*30);
		response.addCookie(ck);
		
	}

	
	%>
	<%
		if(application.getAttribute("likeidx")==null){
			ArrayList<String> list = new ArrayList<String>();
			HashMap<String,ArrayList> like = new HashMap<String,ArrayList>();
			like.put(userid, list);
			application.setAttribute("likeidx", like);
		}
		if(application.getAttribute("goodsidx")==null){
			ArrayList<String> list = new ArrayList<String>();
			HashMap<String,ArrayList> like = new HashMap<String,ArrayList>();
			like.put(userid, list);
			application.setAttribute("goodsidx", like);
		}
	%>
	<script>
	window.alert('<%=username%>님 환영합니다.')
	location.replace('/myhome/index.jsp');
	</script>
	<%
	
}else if(result==mdao.NOT_ID || result==mdao.NOT_PWD){
	
	%>
	<script>
	window.alert("아이디 또는 비밀번호가 틀렸습니다.");
	location.href='login.jsp'
	</script>
	<%
	
}else if(result==mdao.ERROR){
	out.println("<h4>고객센터 연락바람</h4>");
}	
%>

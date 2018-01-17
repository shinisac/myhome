<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
 <jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session"/>
 <%
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setHeader("Cache-Control", "private"); // HTTP 1.1 
	response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 
	String idx = request.getParameter("idx");
	if(session.getAttribute("sid")==null){
	%>
	<script>
		alert('좋아요!기능은 회원만 이용가능합니다!');
		location.replace('content.jsp?idx2=<%=idx%>');
	</script>
	<%	
		return;
	}
	
	%>
    <%
    
    String m_id = (String) session.getAttribute("sid");
    
    
    HashMap<String,ArrayList> maps = new HashMap<String,ArrayList>();
    maps = (HashMap)application.getAttribute("likeidx");
    boolean chk = false;
    
    if(!(maps.containsKey(m_id))){
    	
    	chk = true;
	    ArrayList<String> arr = new ArrayList<String>();
	   	arr.add(idx);
	    maps.put(m_id, arr);
	    application.setAttribute("likeidx", maps);
	    
    }else{
    	ArrayList<String> list=maps.get(m_id);
    	if(list.contains(idx)){
    		chk=false;
    	}else{
    		chk=true;
    		list.add(idx);
    		maps.put(m_id,list);
    		application.setAttribute("likeidx", maps);
    	}
    }
    
    int like=Integer.parseInt(request.getParameter("bbslike"));
    
    if(chk){
        int result=bdao.bbsLike(like);
        String msg=result>0?"좋아요!":"좋아요 실패";
        %>
        <script>
        window.alert('<%=msg%>');
        location.href="content.jsp?idx2=<%=like%>"
        window.self.close();
        </script>
        <%	
    }else{
        %>
        <script>
        window.alert('이미 좋아요를 눌렀습니다.');
        location.href="content.jsp?idx2=<%=like%>"
        window.self.close();
        </script>
        <%	
    }
    %>

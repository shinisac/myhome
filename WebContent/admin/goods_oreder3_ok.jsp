<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adao" class="myhome.admin.adminDAO"/>
<%
	String ck_s[]=request.getParameterValues("ack");
	int result=0;
	if(ck_s!=null){
		for(int i=0; i<ck_s.length; i++){
			int ck = Integer.parseInt(ck_s[i]);
		
			result=adao.orderUpdate3(ck);		
		}
	}
	
	String msg=result>0?"배송완료성공":"배송완료실패";
%>
<script>
window.alert('<%=msg%>');
location.href="goods_oreder2.jsp";
window.self.close();
</script>
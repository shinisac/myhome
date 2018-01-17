<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adao" class="myhome.admin.adminDAO"/>
<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=UTF-8");
	String ck_s[]=request.getParameterValues("ck");
	int result=0;
	if(ck_s!=null){
		for(int i=0; i<ck_s.length; i++){
			int ck = Integer.parseInt(ck_s[i]);
			
			result=adao.orderUpdate(ck);		
		}
	}

	String msg=result>0?"입금확인성공":"입금확인실패";
%>
<script>
window.alert('<%=msg%>');
location.href="goods_oreder.jsp";
window.self.close();
</script>
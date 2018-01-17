<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@ page import="myhome.bbs.*"%>
<jsp:useBean id="bdao" class="myhome.bbs.bbsDAO" scope="session" />
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 

if(session.getAttribute("sid")==null){
%>
<script>
	alert('로그인이 필요한 페이지입니다.');
	location.replace('/myhome');
</script>
<%	
	return;
}

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT ="-1">
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="styLesheet" type="text/css" href="../css/myhomeLayout.css">
<style>
#imgtext{
	border:0; 
	font-Weight:bold;
}
</style>
<script>
function submitchk(obj){
	if(bbs_write.bbs_subject.value==''){
		alert('제목을 입력해주세요.');
		return false;
	}else if(bbs_write.bbs_content.value==''){
		alert('글 내용을 작성해주세요.');
		return false;
	}else{
		return true;
	}
	
}
function imgchk(img){
	var pattern = /.+(\.jpg|\.gif|\.bmp|\.png|\.jpeg)+$/gi;
	var obj= document.getElementById('file');
	if(!img.match(pattern)){
		alert('이미지 파일만 업로드 가능합니다.');
		obj.outerHTML=obj.outerHTML;
		return;
	}
	simgpath(obj);
	return;
}

function simgpath(obj){
	var path = obj.value;
	var file = path.substring(path.lastIndexOf('\\')+1,path.length);
	bbs_write.imgpath.value=file;	
}

</script>
</head>
<%
	String userid = (String) session.getAttribute("sid");
	int uidx = Integer.parseInt(request.getParameter("idx"));
	bbsDTO dto = bdao.bbsContent(uidx);
%>
<body>
	<%@include file="../header.jsp"%>
	<section>
		<article>
			<form name="bbs_write" action="rewrite_ok.jsp?idx=<%=uidx%>"
				method="post" enctype="multipart/form-data" onSubmit="return submitchk(this.form)">

				<table align="center">

					<tr>
						<td colspan="3">
							<h2 align="center">
								<font color="skyblue"><%=userid%>님</font>
							</h2> 
							<input type="hidden" name="bbs_writer" value="<%=userid%>">
							<input type="hidden" name="bbs_idx" value="<%=uidx%>">
						</td>
					</tr>
					<tr>
						<td colspan="3"><input type="text" name="bbs_subject"
							value="<%=dto.getBbs_subject()%>" size="99"></td>
					</tr>
					<tr>
						<td colspan="3"><textarea name="bbs_content" cols="100"
								rows="30"><%=dto.getBbs_content()%></textarea></td>

					</tr>
					<tr>
						<td><input type="submit" value="작성완료"> <input
							type="reset" value="다시작성"></td>
						<td style="float:right"><input type="text" id="imgtext" name="imgpath" value="<%if(dto.getBbs_imgpath()==null){}else{%><%=dto.getBbs_imgpath() %><%}%>" readOnly>
						<input type="file" id="file" name="bbs_imgpath" onChange ="imgchk(this.value);"></td>
					</tr>

				</table>
				<hr color="lightgray">
				<table width="850" align="center">
					<tr>
						<td>
							<p><font color="darkgray">1. 소개해주시는 공간에 대한 충분한 설명(스토리텔링)을 남겨주세요.</font></p>
							<p><font color="darkgray">2. 다양한 구도의 스타일링 사진과 도면, 비포 사진은 보시는 분들에게 큰 도움이 됩니다.</font></p>
							<p><font color="darkgray">3. 업로드 후에 일부 사진이 나오지 않는다면, 사진을 삭제한 후 다시 올려주세요.</font></p>
							<p><font color="darkgray">4. 게시글 오픈 전/후, 수정이 필요하실때는 [마이홈]-[나의스토리]에서 작성 게시글을 확인하실 수 있습니다.</font></p>
						</td>
					</tr>
				</table>
			</form>
		</article>
	</section>
	<%@include file="../footer.jsp"%>
</body>

</html>
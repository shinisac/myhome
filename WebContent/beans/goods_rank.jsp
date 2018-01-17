<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="myhome.beans.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %> 
<jsp:useBean id="mdto" class="myhome.beans.myhomeDTO" />
<jsp:setProperty property="*" name="mdto" />
<jsp:useBean id="mdao" class="myhome.beans.myhomeDAO" />
<%
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setHeader("Cache-Control", "private"); // HTTP 1.1 
response.setHeader("Cache-Control", "no-store"); // HTTP 1.1 
%>
<%
   String sl=request.getParameter("sl");
   
   int totalCnt = mdao.getTotalCnt();//가지고있는 총 게시물수
   int listSize = 10;//한페이지당 보일수 있는 리스트수
   int pageSize = 5;//보여줄 페이지수

   String cp_s = request.getParameter("cp");
   if (cp_s == null || cp_s.equals("")) {
      cp_s = "1";
   }
   int cp = Integer.parseInt(cp_s);
   int totalPage = totalCnt / listSize + 1;
   if (totalCnt % listSize == 0)
      totalPage--;

   int userGroup = cp / pageSize;//그룹화

   if (cp % pageSize == 0)
      userGroup--;//딱 나눠떨어졋을때 하나를 줄여 그룹화를 맞춰준다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Myhome</title>
<link rel="stylesheet" type="text/css" href="/myhome/css/myhomeLayout.css">
<style>
   #bottom td{
      border-bottom: 1px solid lightgray;
   }
</style>
<script>
   function selchange(value){
      location.replace('goods_rank.jsp?sl='+value);
      
   }
</script>
</head>
<body>
<%
DecimalFormat df1 = new DecimalFormat("#,##0");
%>
<%@include file="/header.jsp" %>
   <section>
   <table width="1000" style="margin: 0px auto" align="center" border="0">
   <tr>
   <td align="center">
   <h1 align="center" size="5"><font color="skyblue">가구랭킹</font></h1>
   </td>
   </tr>
   <tr>
   <td style="float: right">
   <div  align="center">
      <form name="goods_rank" action="goods_rank.jsp?sl=" method="POST">
      <select name="sl" onchange="selchange(this.value)">
         <option value="goods_like" <%=sl.equals("goods_like")?"selected":"" %>>좋아요순</option>
         <option value="goods_readnum" <%=sl.equals("goods_readnum")?"selected":"" %>>조회수순</option>
         <option value="goods_buy" <%=sl.equals("goods_buy")?"selected":"" %>>판매순</option>
      </select>
      </form>
   </div>
   </td>
   </tr>
   </table>
   <hr color="lightgray">
      <article align="center">
            <table align="center" width="1000" id="bottom">
               <%
                  ArrayList<myhomeDTO> arr = mdao.goodsList(cp, listSize, sl);
                  if (arr == null || arr.size() == 0) {
               %>
               <tr>
                  <td colspan="4">등록된 상품이 없습니다.</td>
               </tr>
               <%
               
                  } else {
                     
                     for (int i = 0; i < arr.size(); i++) {
                        
               %>
               <tr>
                  <td><font size="6" color="<%=mdao.rownum(sl, arr.get(i).getGoods_ranking_idx())<4?"#ff7777":"skyblue"%>"><strong><%=mdao.rownum(sl, arr.get(i).getGoods_ranking_idx())%>위</strong></font></td>

                  <td>
                     <a href="/myhome/store/myhomeStoreContent.jsp?goods_idx=<%=arr.get(i).getGoods_ranking_idx()%>">
                        <img src="../img/<%=arr.get(i).getGoods_ranking_imgpath()%>" width="150"height="150">
                     </a>
                  </td>
                  <td>
                     <a href="/myhome/store/myhomeStoreContent.jsp?goods_idx=<%=arr.get(i).getGoods_ranking_idx()%>">
                        <font size="4" color="darkgray"><strong><%=arr.get(i).getGoods_ranking_name()%></strong></font>
                     </a>
                  </td>
                  <td>
                     <a href="/myhome/store/myhomeStoreContent.jsp?goods_idx=<%=arr.get(i).getGoods_ranking_idx()%>">
                        <font size="4"><strong><%=df1.format(arr.get(i).getGoods_ranking_price()) %>원</strong></font>
                     </a>
                  </td>
               </tr>
               <%
                     for (int z = 0; z < arr.get(i).getGoods_ranking_lev(); z++) {
                           
                        }
                     }
                  }
               %>
            </table>
            <!-- --------------------------------------- -->
            <%
               if (userGroup != 0) {//왼쪽으로가는 화살표
            %>
            <a href="goods_rank.jsp?cp=<%=(userGroup - 1) * pageSize + pageSize%>">&lt;&lt;</a>
            <%
               }
            %>
            <%
               for (int i = (userGroup * pageSize + 1); i <= (userGroup * pageSize + pageSize); i++) {
            %>
            &nbsp;&nbsp;&nbsp;<a href="goods_rank.jsp?cp=<%=i%>&sl=<%=sl%>"><%=i%></a>&nbsp;&nbsp;&nbsp;
            
            <%
               if (i == totalPage)
                     break;
               }
            %>
            <%
               if (userGroup != (totalPage / pageSize) - (totalPage % pageSize == 0 ? 1 : 0)) {//오른쪽으로 가는 화살표
            %>
            <a href="goods_rank.jsp?cp=<%=(userGroup + 1) * pageSize + 1%>">&gt;&gt;</a>
            <%
               }
            %>
            <!-- -------------------------------------------------- -->

      </article>
   </section>
<%@include file="/footer.jsp" %>
</body>
</html>
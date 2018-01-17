package myhome.beans;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import myhome.bbs.bbsDTO;
import myhome.beans.*;


public class myhomeDAO {
   private Connection conn;
   private PreparedStatement ps;
   private ResultSet rs;
   
   
   /**ref마지막값 관련메소드*/
   public int getMaxRef(){
      try {
         String sql = "select max(goods_ref) from myhome_goods";
         ps=conn.prepareStatement(sql);
         rs=ps.executeQuery();
         int count=0;
         if(rs.next()){
            count=rs.getInt(1);
         }
         return count;
      } catch (Exception e) {
         // TODO: handle exception
         e.printStackTrace();
         return 0;
      } finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }
   
   /**순번 업데이트 관련 메소드*/
   public void updateSun(int ref, int sunbun){
      try {
         String sql="update myhome_goods set goods_sunbun=goods_sunbun+1 where goods_ref=? and goods_sunbun>=?";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, ref);
         ps.setInt(2, sunbun);
         ps.executeUpdate();
      } catch (Exception e) {
         // TODO: handle exception
         e.printStackTrace();
      } finally {
         try {
            if(ps!=null)ps.close();
            
         } catch (Exception e) {
            // TODO: handle exception
         }
      }
   }
   
   /**총 게시물수관련 메서드*/
   public int getTotalCnt() {
      try {
         conn=myhome.db.MyhomeDB.getConn();
           String sql="select count(*) from myhome_goods where goods_state='게시'";
           ps=conn.prepareStatement(sql);
           rs=ps.executeQuery();
           rs.next();
           int count=rs.getInt(1); // idx 컬럼 가져오기
           return count==0?1:count;
        }catch(Exception e) {
           e.printStackTrace();
           return 1;
        }finally {
           try {
              if(rs!=null)rs.close();
              if(ps!=null)ps.close();
              if(conn!=null)conn.close();
           }catch(Exception e2) {}
       }
   }
   
   /**판매 랭킹 리스트 출력 메소드*/
   public ArrayList<myhomeDTO> goodsList(int cp, int ls, String sl) {
      try {
         
         conn=myhome.db.MyhomeDB.getConn();
        
         String sql="";
         if(sl.equals("goods_like")){
            sql="select * from " + 
                        "(select rownum as rnum,a.* from " + 
                        "(select * from myhome_goods where goods_state='게시' order by goods_like desc)a)b " + 
                        "where rnum>=("+cp+"-1)*"+ls+"+1 and rnum<="+cp+"*"+ls+"";
         }else if(sl.equals("goods_readnum")){
            sql="select * from " + 
                        "(select rownum as rnum,a.* from " + 
                        "(select * from myhome_goods where goods_state='게시' order by goods_readnum desc)a)b " + 
                        "where rnum>=("+cp+"-1)*"+ls+"+1 and rnum<="+cp+"*"+ls+"";
         }else if(sl.equals("goods_buy")){
            sql="select * from " + 
                        "(select rownum as rnum,a.* from " + 
                        "(select * from myhome_goods where goods_state='게시' order by goods_buy desc)a)b " + 
                        "where rnum>=("+cp+"-1)*"+ls+"+1 and rnum<="+cp+"*"+ls+"";
         }
         
         ps=conn.prepareStatement(sql);
      
         rs=ps.executeQuery();
      
         ArrayList<myhomeDTO> arr= new ArrayList<myhomeDTO>();
         while(rs.next()) {
            int goods_ranking_idx=rs.getInt("goods_idx");
            int goods_ranking_category=rs.getInt("goods_category");
            String goods_ranking_name=rs.getString("goods_name");
            String goods_ranking_imgpath=rs.getString("goods_imgpath");
            int goods_ranking_price=rs.getInt("goods_price");
            int goods_ranking_amount=rs.getInt("goods_amount");
            String goods_ranking_content=rs.getString("goods_content");
            String goods_ranking_state=rs.getString("goods_state");
            int goods_ranking_buy=rs.getInt("goods_buy");
            Date goods_ranking_adddate=rs.getDate("goods_adddate");
            int goods_ranking_readnum=rs.getInt("goods_readnum");
            int goods_ranking_ref=rs.getInt("goods_ref");
            int goods_ranking_lev=rs.getInt("goods_lev");
            int goods_ranking_sunbun=rs.getInt("goods_sunbun");
            int goods_ranking_like=rs.getInt("goods_like");
            
            myhomeDTO dto=new myhomeDTO(goods_ranking_idx, goods_ranking_category, goods_ranking_name, goods_ranking_imgpath, goods_ranking_price, goods_ranking_amount, goods_ranking_content, goods_ranking_state, goods_ranking_buy, goods_ranking_adddate, goods_ranking_readnum, goods_ranking_ref, goods_ranking_lev, goods_ranking_sunbun,goods_ranking_like);
            arr.add(dto);
         }
         
         return arr;
      }catch(Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }
   
   /**판매 랭킹 리스트 출력 메소드*/
   public ArrayList<myhomeDTO> index_goodsList() {
      try {
         
         conn=myhome.db.MyhomeDB.getConn();
      
         String sql="select * from " + 
                        "(select rownum as rnum,a.* from " + 
                        "(select * from myhome_goods where goods_state='게시' order by goods_like desc)a)b ";
         
         ps=conn.prepareStatement(sql);
      
         rs=ps.executeQuery();
      
         ArrayList<myhomeDTO> arr= new ArrayList<myhomeDTO>();
         while(rs.next()) {
            int goods_ranking_idx=rs.getInt("goods_idx");
            int goods_ranking_category=rs.getInt("goods_category");
            String goods_ranking_name=rs.getString("goods_name");
            String goods_ranking_imgpath=rs.getString("goods_imgpath");
            int goods_ranking_price=rs.getInt("goods_price");
            int goods_ranking_amount=rs.getInt("goods_amount");
            String goods_ranking_content=rs.getString("goods_content");
            String goods_ranking_state=rs.getString("goods_state");
            int goods_ranking_buy=rs.getInt("goods_buy");
            Date goods_ranking_adddate=rs.getDate("goods_adddate");
            int goods_ranking_readnum=rs.getInt("goods_readnum");
            int goods_ranking_ref=rs.getInt("goods_ref");
            int goods_ranking_lev=rs.getInt("goods_lev");
            int goods_ranking_sunbun=rs.getInt("goods_sunbun");
            int goods_ranking_like=rs.getInt("goods_like");
            
            myhomeDTO dto=new myhomeDTO(goods_ranking_idx, goods_ranking_category, goods_ranking_name, goods_ranking_imgpath, goods_ranking_price, goods_ranking_amount, goods_ranking_content, goods_ranking_state, goods_ranking_buy, goods_ranking_adddate, goods_ranking_readnum, goods_ranking_ref, goods_ranking_lev, goods_ranking_sunbun,goods_ranking_like);
            arr.add(dto);
         }
         
         return arr;
      }catch(Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }
   
   
   
   /**조회수 관련메소드*/
   public void ureadnum(int idx) {
      try {
         conn=myhome.db.MyhomeDB.getConn();
         String sql="update myhome_goods set goods_readnum=goods_readnum+1 where goods_idx=?";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, idx);
         int count=ps.executeUpdate();
      } catch (Exception e) {
         // TODO: handle exception]
         e.printStackTrace();
         
      } finally {
         try {
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }
   
   /**랭킹 순위 구하는 메소드*/
   public int rownum(String sl,int idx){
      try{
         conn=myhome.db.MyhomeDB.getConn();
         String sql="";
         if(sl.equals("goods_like")){
            sql="select * from (select rownum as rnum,a.* from (select * from myhome_goods where goods_state='게시' order by goods_like desc)a)b where goods_idx=?";
         }else if(sl.equals("goods_readnum")){
            sql="select * from (select rownum as rnum,a.* from (select * from myhome_goods where goods_state='게시' order by goods_readnum desc)a)b where goods_idx=?";   
         }else if(sl.equals("goods_buy")){
            sql="select * from (select rownum as rnum,a.* from (select * from myhome_goods where goods_state='게시' order by goods_buy desc)a)b where goods_idx=?";
         }
         ps=conn.prepareStatement(sql);
         ps.setInt(1, idx);
         rs=ps.executeQuery();
         int rank = 0;
         if(rs.next()){
            rank = rs.getInt(1);
         }
         return rank;
         
      }catch (Exception e) {
         // TODO: handle exception
         e.printStackTrace();
         return -1;
      }finally {
         try {
            if(rs!=null)rs.close();
              if(ps!=null)ps.close();
              if(conn!=null)conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }
   
   
}
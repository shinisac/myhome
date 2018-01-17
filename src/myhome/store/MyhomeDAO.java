package myhome.store;

import java.sql.*;
import java.util.ArrayList;

public class MyhomeDAO {
   
   private Connection conn;
   private PreparedStatement ps;
   private ResultSet rs;
   
   public MyhomeDAO() {
      
   }
   
   /**스토어 관련 메서드*/
   public int myhomeStore(MyhomeDTO dto) {
      try {
         
         conn=myhome.db.MyhomeDB.getConn();
         
         String sql="insert into myhome_goods values(myhome_goods_idx.nextval,?,?,?,?,?,?,?,?,sysdate)";
         
         ps=conn.prepareStatement(sql);
         ps.setInt(1, dto.getGoods_category());
         ps.setString(2, dto.getGoods_name());
         ps.setString(3, dto.getGoods_imgpath());
         ps.setInt(4, dto.getGoods_price());
         ps.setInt(5, dto.getGoods_amount());
         ps.setString(6, dto.getGoods_content());
         ps.setString(7, dto.getGoods_state());
         ps.setInt(8, dto.getGoods_buy());
         
         int count=ps.executeUpdate();
         return count;
         
      }catch(Exception e) {
         e.printStackTrace();
         return -1;
      }finally {
         try {
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         }catch(Exception e2) {}
      }
   }
   /**idx에 따른 목록 관련 메서드*/
   public MyhomeDTO myhomeIdxList(int idx,int amount){
      try {
         
         conn=myhome.db.MyhomeDB.getConn();
         
         String sql="select * from myhome_goods where goods_idx=? and goods_state='게시'";
         
         ps=conn.prepareStatement(sql);
         ps.setInt(1, idx);
         rs=ps.executeQuery();
         
         MyhomeDTO dto=null;
         while(rs.next()) {
            int goods_idx=rs.getInt("goods_idx");
            int goods_category=rs.getInt("goods_category");
            String goods_name=rs.getString("goods_name");
            String goods_imgpath=rs.getString("goods_imgpath");
            int goods_price=rs.getInt("goods_price");
            int goods_amount=amount;
            String goods_content=rs.getString("goods_content");
            String goods_state=rs.getString("goods_state");
            int goods_buy=rs.getInt("goods_buy");
            java.sql.Date goods_adddate=rs.getDate("goods_adddate");
            int goods_like=rs.getInt("goods_like");
            int goods_readnum=rs.getInt("goods_readnum");
            int goods_ref=rs.getInt("goods_ref");
            int goods_lev=rs.getInt("goods_lev");
            int goods_sunbun=rs.getInt("goods_sunbun");
            
            dto=new MyhomeDTO(goods_idx, goods_category, goods_name, goods_imgpath, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_adddate, goods_like,goods_readnum,goods_ref,goods_lev,goods_sunbun);
         
         }
         return dto;
      }catch(Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)rs.close();
            if(conn!=null)conn.close();
         }catch(Exception e2) {}
      }
   }   
   /**목록관련 메서드*/
   public ArrayList<MyhomeDTO> myhomeStoreList(){
      try {
         
         conn=myhome.db.MyhomeDB.getConn();
         
         String sql="select * from myhome_goods where goods_state='게시' order by goods_idx desc";
         
         ps=conn.prepareStatement(sql);
         rs=ps.executeQuery();
         ArrayList<MyhomeDTO> arr=new ArrayList<>();
         
         while(rs.next()) {
            int goods_idx=rs.getInt("goods_idx");
            int goods_category=rs.getInt("goods_category");
            String goods_name=rs.getString("goods_name");
            String goods_imgpath=rs.getString("goods_imgpath");
            int goods_price=rs.getInt("goods_price");
            int goods_amount=rs.getInt("goods_amount");
            String goods_content=rs.getString("goods_content");
            String goods_state=rs.getString("goods_state");
            int goods_buy=rs.getInt("goods_buy");
            java.sql.Date goods_adddate=rs.getDate("goods_adddate");
            int goods_readnum=rs.getInt("goods_readnum");
            int goods_ref=rs.getInt("goods_ref");
            int goods_lev=rs.getInt("goods_lev");
            int goods_sunbun=rs.getInt("goods_sunbun");
            int goods_like=rs.getInt("goods_like");
            
            MyhomeDTO dto=new MyhomeDTO(goods_idx, goods_category, goods_name, goods_imgpath, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_adddate, goods_readnum, goods_ref, goods_lev, goods_sunbun, goods_like);
            arr.add(dto);
         }
         return arr;
      }catch(Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)rs.close();
            if(conn!=null)conn.close();
         }catch(Exception e2) {}
      }
   }
   /**카테고리목록관련 메서드
   public ArrayList<MyhomeDTO> myhomeCategoryList(int cate){
      try {
         
         conn=myhome.db.MyhomeDB.getConn();
         
         String sql="select * from myhome_goods where goods_category=(select category_goods_num from myhome_category_goods where category_goods_num=?) order by goods_idx desc";
         
         ps=conn.prepareStatement(sql);
         ps.setInt(1, cate);
         rs=ps.executeQuery();
         ArrayList<MyhomeDTO> arr=new ArrayList<MyhomeDTO>();
         
         while(rs.next()) {
            int goods_idx=rs.getInt("goods_idx");
            int goods_category=rs.getInt("goods_category");
            String goods_name=rs.getString("goods_name");
            String goods_imgpath=rs.getString("goods_imgpath");
            int goods_price=rs.getInt("goods_price");
            int goods_amount=rs.getInt("goods_amount");
            String goods_content=rs.getString("goods_content");
            String goods_state=rs.getString("goods_state");
            int goods_buy=rs.getInt("goods_buy");
            java.sql.Date goods_adddate=rs.getDate("goods_adddate");
            
            MyhomeDTO dto=new MyhomeDTO(goods_idx, goods_category, goods_name, goods_imgpath, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_adddate);
            arr.add(dto);
         }
         return arr;
         
      }catch(Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)rs.close();
            if(conn!=null)conn.close();
         }catch(Exception e2) {}
      }
   }
   */
   /**본문보기관련 메서드*/
   public MyhomeDTO myhomeStoreContent(int goods_idx){
      try {
         
         conn=myhome.db.MyhomeDB.getConn();
         
         String sql="select * from myhome_goods where goods_idx=?";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, goods_idx);
         rs=ps.executeQuery();
         MyhomeDTO dto=null;
         
         if(rs.next()) {
            int goods_category=rs.getInt("goods_category");
            String goods_name=rs.getString("goods_name");
            String goods_imgpath=rs.getString("goods_imgpath");
            int goods_price=rs.getInt("goods_price");
            int goods_amount=rs.getInt("goods_amount");
            String goods_content=rs.getString("goods_content");
            String goods_state=rs.getString("goods_state");
            int goods_buy=rs.getInt("goods_buy");
            java.sql.Date goods_adddate=rs.getDate("goods_adddate");
            int goods_readnum=rs.getInt("goods_readnum");
            int goods_ref=rs.getInt("goods_ref");
            int goods_lev=rs.getInt("goods_lev");
            int goods_sunbun=rs.getInt("goods_sunbun");
            int goods_like=rs.getInt("goods_like");
            
            dto=new MyhomeDTO(goods_idx, goods_category, goods_name, goods_imgpath, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_adddate, goods_readnum, goods_ref, goods_lev, goods_sunbun, goods_like);
         }
         return dto;
      }catch(Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)rs.close();
            if(conn!=null)conn.close();
         }catch(Exception e2) {}
      }
   }
   /**조회수 출력 메소드*/
   public int readnum(int idx) {
      try {
         conn=myhome.db.MyhomeDB.getConn();
         String sql="select goods_readnum from myhome_goods where goods_idx=?";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, idx);
         rs=ps.executeQuery();
         int result=0;
         if(rs.next()){
            result=rs.getInt(1);
         }
         return result;
      } catch (Exception e) {
         // TODO: handle exception]
         e.printStackTrace();
         return -1;
      } finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }
   /**좋아요 관련메소드*/
   public int ulikenum(int idx) {
      try {
         conn=myhome.db.MyhomeDB.getConn();
         String sql="update myhome_goods set goods_like=goods_like+1 where goods_idx=?";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, idx);
         int count=ps.executeUpdate();
         return count;
      } catch (Exception e) {
         // TODO: handle exception]
         e.printStackTrace();
         return -1;
      } finally {
         try {
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
}






















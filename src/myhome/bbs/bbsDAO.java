package myhome.bbs;
import myhome.db.*;


import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.io.*;
import java.sql.Timestamp;
public class bbsDAO {
   
   
   int count=1;         
   private Connection conn;
   private PreparedStatement ps;
   private ResultSet rs;

   
   
   /*글쓰기 관련 메서드*/
   public int bbsWrite(String writer,String subject,String imgpath,String content) {
      try {
         conn=myhome.db.MyhomeDB.getConn();
         String sql="insert into myhome_bbs values(myhome_bbs_idx.nextval,'정상',0,?,?,?,?,sysdate,sysdate,0,0,0,0,0)";
         ps=conn.prepareStatement(sql);
         ps.setString(1, writer);
         ps.setString(2, subject);
         ps.setString(3, imgpath);
         ps.setString(4, content);
      
         int count=ps.executeUpdate();
         return count;
      } catch (Exception e) {
         e.printStackTrace();
         return -1;
      }finally {
         try {
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {
            
         }
      }
      
   }
   /*bbs 목록관련 페이징처리까지의 메서드*/
   public ArrayList<bbsDTO> bbsList(int cp,int listSize){
      try {
         conn=myhome.db.MyhomeDB.getConn();
         String sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs where bbs_state='정상' order by bbs_idx desc)a)b where bbs_state='정상' and rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
         
         ps=conn.prepareStatement(sql);
         rs=ps.executeQuery();
         ArrayList<bbsDTO> arr=new ArrayList<bbsDTO>();
         while(rs.next()) {
            int bbs_idx=rs.getInt("bbs_idx");
            String bbs_state=rs.getString("bbs_state");
            int bbs_category=rs.getInt("bbs_category");
            String bbs_writer=rs.getString("bbs_writer");
            String bbs_subject=rs.getString("bbs_subject");
            String bbs_imgpath=rs.getString("bbs_imgpath");
            String bbs_content=rs.getString("bbs_content");
            Timestamp bbs_writedate=rs.getTimestamp("bbs_writedate");
            Timestamp bbs_editdate=rs.getTimestamp("bbs_editdate");
            int bbs_like=rs.getInt("bbs_like");
            int bbs_readnum=rs.getInt("bbs_readnum");
            int bbs_ref=rs.getInt("bbs_ref");
            int bbs_lev=rs.getInt("bbs_lev");
            int bbs_sunbun=rs.getInt("bbs_sunbun");
                  
            bbsDTO dto=new bbsDTO(bbs_idx, bbs_state, bbs_category, bbs_writer, bbs_subject, bbs_imgpath, bbs_content, bbs_writedate, bbs_editdate, bbs_like, bbs_readnum, bbs_ref, bbs_lev, bbs_sunbun);
            arr.add(dto);
         }
         return arr;
      } catch (Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {
            
         }
      }
      
      
   }/*bbs 목록관련 페이징처리까지의 메서드*/
   public ArrayList<bbsDTO> bbsListMain(){
      try {
         conn=myhome.db.MyhomeDB.getConn();
         String sql="select *from myhome_bbs where bbs_state='정상' order by bbs_idx desc";
         ps=conn.prepareStatement(sql);
         rs=ps.executeQuery();
         ArrayList<bbsDTO> arr=new ArrayList<bbsDTO>();
         while(rs.next()) {
            int bbs_idx=rs.getInt("bbs_idx");
            String bbs_state=rs.getString("bbs_state");
            int bbs_category=rs.getInt("bbs_category");
            String bbs_writer=rs.getString("bbs_writer");
            String bbs_subject=rs.getString("bbs_subject");
            String bbs_imgpath=rs.getString("bbs_imgpath");
            String bbs_content=rs.getString("bbs_content");
            Timestamp bbs_writedate=rs.getTimestamp("bbs_writedate");
            Timestamp bbs_editdate=rs.getTimestamp("bbs_editdate");
            int bbs_like=rs.getInt("bbs_like");
            int bbs_readnum=rs.getInt("bbs_readnum");
            int bbs_ref=rs.getInt("bbs_ref");
            int bbs_lev=rs.getInt("bbs_lev");
            int bbs_sunbun=rs.getInt("bbs_sunbun");
                  
            bbsDTO dto=new bbsDTO(bbs_idx, bbs_state, bbs_category, bbs_writer, bbs_subject, bbs_imgpath, bbs_content, bbs_writedate, bbs_editdate, bbs_like, bbs_readnum, bbs_ref, bbs_lev, bbs_sunbun);
            arr.add(dto);
         }
         return arr;
      } catch (Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {
            
         }
      }
      
      
   }
   
   
   /*bbs_클릭시 상세내용*/
   public bbsDTO bbsContent(int key) {
      try {
         conn=myhome.db.MyhomeDB.getConn();
         String sql="select * from myhome_bbs where bbs_idx=?";
         ps=conn.prepareStatement(sql);
         ps.setInt(1,key);
         rs=ps.executeQuery();
         bbsDTO dto=new bbsDTO();
            while(rs.next()) {
            int bbs_idx=rs.getInt("bbs_idx");
            String bbs_state=rs.getString("bbs_state");
            int bbs_category=rs.getInt("bbs_category");
            String bbs_writer=rs.getString("bbs_writer");
            
            String bbs_subject=rs.getString("bbs_subject");
            String bbs_imgpath=rs.getString("bbs_imgpath");
            String bbs_content=rs.getString("bbs_content");
            
            Timestamp bbs_writedate=rs.getTimestamp("bbs_writedate");
            Timestamp bbs_editdate=rs.getTimestamp("bbs_editdate");
            
            int bbs_like=rs.getInt("bbs_like");
            int bbs_readnum=rs.getInt("bbs_readnum");
            int bbs_ref=rs.getInt("bbs_ref");
            int bbs_lev=rs.getInt("bbs_lev");
            int bbs_sunbun=rs.getInt("bbs_sunbun");
      
            dto=new bbsDTO(bbs_idx, bbs_state, bbs_category, bbs_writer, bbs_subject, bbs_imgpath, bbs_content, bbs_writedate, bbs_editdate, bbs_like, bbs_readnum, bbs_ref, bbs_lev, bbs_sunbun);
            
         }
         return dto;
      } catch (Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {
            if(rs!=null)rs.close();
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {
            
         }
      }
      
   }
   /*조회수 관련*/
   public void readNum(int key) {
      try {
         conn=myhome.db.MyhomeDB.getConn();
         String sql="update myhome_bbs set bbs_readnum=bbs_readnum+"+count+" where bbs_idx=?";
         
         ps=conn.prepareStatement(sql);
         ps.setInt(1, key);
         int count=ps.executeUpdate();
         
         
      } catch (Exception e) {
         e.printStackTrace();
         
      }finally {
         try {
            
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {
            
         }
      }
      
   }
   /*좋아요 up관련*/
   public int bbsLike(int key) {
      try {
         conn=myhome.db.MyhomeDB.getConn();
         String sql="update myhome_bbs set bbs_like=bbs_like+1 where bbs_idx=?";
         
         ps=conn.prepareStatement(sql);
         ps.setInt(1, key);
         int count=ps.executeUpdate();
         return count;
         
      } catch (Exception e) {
         e.printStackTrace();
         return -1;
      }finally {
         try {
            
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         } catch (Exception e2) {
            
         }
      }
      
   }
      /**게시글 수정관련 메소드*/
      public int bbsReWrite(String subject,String imgpath,String content, int idx) {
         try {
           conn=myhome.db.MyhomeDB.getConn();
            String sql="update myhome_bbs set bbs_subject=?, bbs_imgpath=?, bbs_content=?, bbs_editdate=sysdate where bbs_idx=?";
            ps=conn.prepareStatement(sql);
            
            ps.setString(1, subject);
            ps.setString(2, imgpath);
            ps.setString(3, content);
            ps.setInt(4, idx);
            int count=ps.executeUpdate();
            return count;
         } catch (Exception e) {
            e.printStackTrace();
            return -1;
         }finally {
            try {
               if(ps!=null)ps.close();
               if(conn!=null)conn.close();
            } catch (Exception e2) {
               
            }
         }
         
      }
      /**게시글 삭제관련 메소드*/
      public int delbbs(int idx){
         try{
           conn=myhome.db.MyhomeDB.getConn();
            String sql="update myhome_bbs set bbs_state='삭제' where bbs_idx=?";
            
            ps=conn.prepareStatement(sql);
            ps.setInt(1, idx);
            int count=ps.executeUpdate();
            return count;
            
         }catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            return -1;
         }finally {
            try {
               if(ps!=null)ps.close();
               if(conn!=null)conn.close();
            } catch (Exception e2) {
               // TODO: handle exception
            }
         }
      }
      /*작성자의 다른 게시물보기관려*/
      public ArrayList<bbsDTO> member_content(String writer,int cp,int listSize) {
         try {
            conn=myhome.db.MyhomeDB.getConn();
            String sql="select * from (select rownum as rnum,a.* from (select * from myhome_bbs where bbs_writer=? and bbs_state in('정상') order by bbs_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
            ps=conn.prepareStatement(sql);
            ps.setString(1,writer);
            rs=ps.executeQuery();
            ArrayList<bbsDTO> arr=new ArrayList<bbsDTO>();
            while(rs.next()) {
               int bbs_idx=rs.getInt("bbs_idx");
               String bbs_state=rs.getString("bbs_state");
               int bbs_category=rs.getInt("bbs_category");
               String bbs_writer=rs.getString("bbs_writer");
               String bbs_subject=rs.getString("bbs_subject");
               String bbs_imgpath=rs.getString("bbs_imgpath");
               String bbs_content=rs.getString("bbs_content");
               Timestamp bbs_writedate=rs.getTimestamp("bbs_writedate");
               Timestamp bbs_editdate=rs.getTimestamp("bbs_editdate");
               int bbs_like=rs.getInt("bbs_like");
               int bbs_readnum=rs.getInt("bbs_readnum");
               int bbs_ref=rs.getInt("bbs_ref");
               int bbs_lev=rs.getInt("bbs_lev");
               int bbs_sunbun=rs.getInt("bbs_sunbun");
                     
               bbsDTO dto=new bbsDTO(bbs_idx, bbs_state, bbs_category, bbs_writer, bbs_subject, bbs_imgpath, bbs_content, bbs_writedate, bbs_editdate, bbs_like, bbs_readnum, bbs_ref, bbs_lev, bbs_sunbun);
               arr.add(dto);
            }
            return arr;
            
      } catch (Exception e) {
         e.printStackTrace();
         return null;
      }finally {
         try {   if(rs!=null)rs.close();
                 if(ps!=null)ps.close();
                  if(conn!=null)conn.close();
         } catch (Exception e2) {
            
         }
      }
        
      }
      /*게시판 state가 정상인 총게시물수 관련 메서드*/
      public int getbbsTotalCnt() {
         try {
            conn=myhome.db.MyhomeDB.getConn();
            String sql="select count(*) from myhome_bbs where bbs_state='정상'";
            ps=conn.prepareStatement(sql);
            rs=ps.executeQuery();
            rs.next();
            int count=rs.getInt(1);
            return count==0?1:count;
            
         }catch(Exception e) {
            e.printStackTrace();
            return 1;
            
         }finally {
            try {
               if(rs!=null)rs.close();
               if(ps!=null)ps.close();
               if(conn!=null)conn.close();
            }catch(Exception e2) {
            }
         }
      }
      /*회원의 게시물 더보기관련, 유저총게시물수 관련 메서드*/
      public int getUserTotalCnt(String writer) {
         try {
            conn=myhome.db.MyhomeDB.getConn();
            String sql="select count(*) from myhome_bbs where bbs_writer=? and bbs_state='정상'";
            ps=conn.prepareStatement(sql);
            ps.setString(1, writer);
            rs=ps.executeQuery();
            rs.next();
            int count=rs.getInt(1);
            return count==0?1:count;
            
         }catch(Exception e) {
            e.printStackTrace();
            return 1;
            
         }finally {
            try {
               if(rs!=null)rs.close();
               if(ps!=null)ps.close();
               if(conn!=null)conn.close();
            }catch(Exception e2) {
            }
         }
      }
}
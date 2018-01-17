package myhome.rip;
import java.sql.*;
import java.util.ArrayList;

import myhome.bbs.bbsDTO;
import myhome.db.*;


public class ripDAO {
	int count=1;			
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public ripDAO() {
		
	}
	/*rip 글쓰기 관련*/
	public int ripWrite(ripDTO dto) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="insert into myhome_rip values(myhome_bbs_idx.nextval,?,?,?,0,0,0,sysdate)";
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, dto.getRip_bbs_idx());
			 ps.setString(2, dto.getRip_member_id()); 
			ps.setString(3, dto.getRip_content());
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
	
	/*rip(댓글목록) 라스트관련 메서드*/
	public ArrayList<ripDTO> ripList(int bbs_idx){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			//String sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs order by idx desc)a)b "
				//	+ "where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			
			String sql="select * from myhome_rip where rip_bbs_idx=? order by rip_idx desc ";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, bbs_idx);
			rs=ps.executeQuery();
			ArrayList<ripDTO> arr=new ArrayList<ripDTO>();
			while(rs.next()) {
				int rip_idx=rs.getInt("rip_idx");
				int rip_bbs_idx=rs.getInt("rip_bbs_idx");
				String rip_member_id=rs.getString("rip_member_id");
				String rip_content=rs.getString("rip_content");
			    int  rip_bbs_ref=rs.getInt("rip_bbs_ref");
			    int rip_bbs_lev=rs.getInt("rip_bbs_lev");
			    int rip_bbs_sunbun=rs.getInt("rip_bbs_sunbun");
			    Timestamp rip_bbs_writedate=rs.getTimestamp("rip_bbs_writedate");
			    ripDTO dto=new ripDTO(rip_member_id, rip_idx, rip_bbs_idx, rip_content, rip_bbs_ref, rip_bbs_lev, rip_bbs_sunbun, rip_bbs_writedate);
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
	
	public int ripDel(int rip_idx) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="delete myhome_rip where rip_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, rip_idx);
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
	public int ripModify(String rip_modify, int rip_idx) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="update myhome_rip set rip_content=? where rip_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, rip_modify);
			ps.setInt(2, rip_idx);
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
	
}

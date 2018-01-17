package myhome.category;

import java.sql.*;
import java.util.ArrayList;

import myhome.store.MyhomeDTO;

public class CategoryDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public CategoryDAO() {
		
	}
	
	/**카테고리목록관련 메서드*/
	public ArrayList<CategoryDTO> categoryList(){
		try {
			
			conn=myhome.db.MyhomeDB.getConn();
			
			String sql="select * from  myhome_category_goods order by category_goods_num asc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<CategoryDTO> arr=new ArrayList<CategoryDTO>();
			
			while(rs.next()) {
				
				int category_goods_num=rs.getInt("category_goods_num");
				String category_goods_imgpath=rs.getString("category_goods_imgpath");
				String category_goods_name=rs.getString("category_goods_name");
				
				CategoryDTO dto=new CategoryDTO(category_goods_num, category_goods_imgpath, category_goods_name);
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
	/**카테고리 리스트관련 메서드*/
	public ArrayList<MyhomeDTO> myhomeCategoryList(int idx){
		try {
			
			conn=myhome.db.MyhomeDB.getConn();
			
			String sql="select * from myhome_goods where goods_state='게시' and goods_category=? order by goods_idx desc";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
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
}


















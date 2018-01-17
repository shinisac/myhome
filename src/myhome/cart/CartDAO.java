package myhome.cart;
import java.sql.*;
import java.util.*;
import java.text.*;
import myhome.goods.*;
public class CartDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public CartDAO() {
		
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		
	}
	/**가져온 물건 정보를 장바구니에 넣는 메서드*/
	public int cartInsert(GoodsDTO dto,int member_idx,int amount,String optiona,String optionb) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			
			String sql = "insert into myhome_cart values(myhome_cart_idx.nextval,?,?,?,?,?,?,?,?,?,?)";
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getGoods_idx());
			ps.setInt(2, member_idx);
			ps.setInt(3, dto.getGoods_category());
			ps.setString(4, dto.getGoods_path());
			ps.setString(5, dto.getGoods_name());
			ps.setInt(6, dto.getGoods_price());
			ps.setInt(7, amount);
			ps.setString(8, dto.getGoods_state());
			ps.setString(9, optiona);
			ps.setString(10, optionb);
			
			int count = ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();					
			} catch (Exception e2) {
				
			}
		}
	}
	/**장바구니에 넣을 물건 검색 관련 메서드*/
	public GoodsDTO cartGoods(int idx) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql = "select * from myhome_goods where goods_idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs =  ps.executeQuery();
			GoodsDTO gdto = null;
			while(rs.next()) {
				int idxx = rs.getInt("goods_idx");
				int category = rs.getInt("goods_category");
				String name = rs.getString("goods_name");
				String path = rs.getString("goods_imgpath");
				int price = rs.getInt("goods_price");
				int amount = rs.getInt("goods_amount");
				String content = rs.getString("goods_content");
				String state = rs.getString("goods_state");
				int buy = rs.getInt("goods_buy");
				Timestamp date = rs.getTimestamp("goods_adddate");
				int like=rs.getInt("goods_like");
				int readnum=rs.getInt("goods_readnum");
				int ref=rs.getInt("goods_ref");
				int lev=rs.getInt("goods_lev");
				int sunbun=rs.getInt("goods_sunbun");
				gdto = new GoodsDTO(idxx, category, name, path, price, amount, content, state, buy, date, like, readnum, ref, lev, sunbun);			
				}
			return gdto;
			
			
		} catch (Exception e) {
			return null;
		}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();				
			} catch (Exception e2) {
		
			}
		}
		
	}
	/**장바구니 수량변경 관련 메서드*/
	public void cartAmount(int idxs,int amount) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql = "UPDATE myhome_cart SET cart_goods_amount=? WHERE cart_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, amount);
			ps.setInt(2, idxs);	
			ps.executeUpdate();
		} catch (Exception e) {
				e.printStackTrace();
		}finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	/**장바구니 삭제 관련 메서드*/
	public int cartDel(String idxs) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql = "delete from myhome_cart where cart_idx=?";
			ps=conn.prepareStatement(sql);
			int idxx = Integer.parseInt(idxs);
			ps.setInt(1, idxx);
			
			int count = ps.executeUpdate();
			
			return count;
			
		}catch(Exception e) {
			return -1;
		}finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();				
			} catch (Exception e2) {
				
			}
		}
		
	}
	/**장바구니 관련 메서드*/
	public ArrayList<CartDTO> cartList(int idxs) {
		
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql = "select * from myhome_cart where cart_member_idx =?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idxs);
			rs = ps.executeQuery();
			
			ArrayList<CartDTO> arr = new ArrayList<CartDTO>();
			while(rs.next()) {
				int idx = rs.getInt(1);
				int goods_idx = rs.getInt(2);
				int member_idx = rs.getInt(3);
				int goods_category_idx=rs.getInt(4);
				String goods_imgpath= rs.getString(5);
				String goods_name= rs.getString(6);
				int goods_price = rs.getInt(7);
				int goods_amount = rs.getInt(8);
				String goods_state = rs.getString(9);
				String goods_optiona=rs.getString(10);
				String goods_optionb=rs.getString(11);
				
				CartDTO dt = new CartDTO(idx, goods_idx, member_idx, goods_category_idx, goods_imgpath, goods_name, goods_price, goods_amount, goods_state, goods_optiona,goods_optionb);
				arr.add(dt);
			}
			return arr;
			
		}catch(Exception e) {
			return null;
		}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {
				
			}
		}
	}
	/**장바구니내역 삭제관련 메서드 */
	public int cartListDel(int idx) {
		try {
			
			conn=myhome.db.MyhomeDB.getConn();
			
			String sql = "delete from myhome_cart where cart_idx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			int count = ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {}
		}
	}
}

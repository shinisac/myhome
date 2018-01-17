package myhome.order;

import java.sql.*;
import java.util.ArrayList;

import myhome.store.MyhomeDTO;
import myhome.member.MemberDTO;
import myhome.order.OrderDTO;

public class OrderDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public OrderDAO() {
		
	}
	
	/**주문입력관련 메서드*/
	public int myhomeOrder(OrderDTO dto) {
		try {
			
			conn=myhome.db.MyhomeDB.getConn();
			
			String sql="insert into myhome_order values(myhome_order_idx.nextval,?,?,?,?,?,?,?,?,sysdate,?,?,?)";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, "입금대기");
			ps.setString(2, dto.getOrder_member_id());
			ps.setInt(3, dto.getOrder_goods_idx());
			ps.setInt(4, dto.getOrder_amount());
			ps.setInt(5, dto.getOrder_price());
			ps.setString(6, dto.getOrder_addr());
			ps.setString(7, "상품준비중");
			ps.setString(8, dto.getOrder_pay());
			ps.setString(9, dto.getOrder_goods_name());
			ps.setInt(10, dto.getOrder_goods_price());			
			ps.setString(11, dto.getOrder_imgpath());

			
			int count=ps.executeUpdate();
			return count;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
	}

	
	/**구매내역관련 메소드*/
	public ArrayList<OrderDTO> myhomeBuyList(String id){
		try {
			
			conn=myhome.db.MyhomeDB.getConn();
			
			String sql="select * from myhome_order where order_member_id=(select member_id from myhome_member where member_id=?) order by order_date desc";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			ArrayList<OrderDTO> arr=new ArrayList<>();
			
			while(rs.next()) {
				int order_idx=rs.getInt("order_idx");
				String order_state=rs.getString("order_state");
				String order_member_id=rs.getString("order_member_id");
				int order_goods_idx=rs.getInt("order_goods_idx");
				int order_amount=rs.getInt("order_amount");
				int order_price=rs.getInt("order_price");
				String order_addr=rs.getString("order_addr");
				String order_shipstate=rs.getString("order_shipstate");
				String order_pay=rs.getString("order_pay");
				Timestamp order_date=rs.getTimestamp("order_date");
				String order_goods_name=rs.getString("order_goods_name");	
				String order_imgpath=rs.getString("order_goods_imgpath");
				int order_goods_price=rs.getInt("order_goods_price");
				OrderDTO dto=new OrderDTO(order_idx, order_state, order_member_id, order_goods_idx, order_amount, order_price, order_addr, order_shipstate, order_pay, order_date, order_imgpath, order_goods_name, order_goods_price);
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
	/**구매수 관련 메소드*/
	public void buyCount(int idx) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="update myhome_goods set goods_buy =goods_buy+1 where goods_idx = ?";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
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
}

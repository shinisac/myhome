package myhome.admin;

import java.sql.Connection;
import myhome.member.MemberDTO;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import myhome.bbs.bbsDTO;
import myhome.cart.CartDTO;
import myhome.db.*;
import myhome.goods.GoodsDTO;
import myhome.order.*;
import myhome.rip.ripDTO;
import myhome.category.CategoryDTO;
import java.sql.Timestamp;
public class adminDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	public adminDAO() {
	}
	
	
	/**관리자페이지 - 회원 - 탈퇴한 회원페이지로딩시 삭제한지 6개월이 지난 아이디는 삭제*/
	public void monthdel() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="delete from myhome_member where add_months(member_dedate,6)<=sysdate";
			ps=conn.prepareStatement(sql);
			ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();		
			} catch (Exception e2) {}
		}
	}	
	/**관리자페이지 회원-회원정보 회원정보 상세 출력 관련 메서드*/
	public MemberDTO memberimfo(int idx) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from myhome_member where member_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs = ps.executeQuery();
			MemberDTO dto = null;
		while(rs.next()) {
			
			int member_idx=rs.getInt("member_idx");
			String member_state=rs.getString("member_state");
			String member_level=rs.getString("member_level");
			String member_id=rs.getString("member_id");
			String member_pwd=rs.getString("member_pwd");
			String member_name=rs.getString("member_name");
			String member_birthday=rs.getString("member_birthday");
			String member_gen=rs.getString("member_gen");
			String member_phone=rs.getString("member_phone");
			String member_email=rs.getString("member_email");
			String member_addr=rs.getString("member_addr");
			Timestamp member_date=rs.getTimestamp("member_date");
			Timestamp member_deldate=rs.getTimestamp("member_deldate");	
			dto = new MemberDTO(member_idx, member_state, member_level, member_id, member_pwd, member_name, member_birthday, member_gen, member_phone, member_email, member_addr, member_date, member_deldate);
			
		}
			return dto;
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();		
			} catch (Exception e2) {}
		}
		
	}
	
	/**관리자페이지 주문-매출현황 오늘 매출현황 출력 관련 메서드*/
	public int todaysales() {
		
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select decode(sum(order_price),null,0,sum(order_price)) from myhome_order where TRUNC(order_date)=TRUNC(sysdate)";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int todaysales=0;
			while(rs.next()) {
				todaysales = rs.getInt(1);
			}
			return todaysales;
		} catch (Exception e) {
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();		
			} catch (Exception e2) {}
		}
		
		
	}
	/**관리자페이지 주문-매출현황 오늘 주문 건수 출력 관련 메서드*/
	public int todayorder() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) from myhome_order where TRUNC(order_date)=TRUNC(sysdate)";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int todayorder=0;
			while(rs.next()) {
				todayorder = rs.getInt(1);
			}
			return todayorder;
		} catch (Exception e) {
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();		
			} catch (Exception e2) {}
		}
	}
	/**관리자페이지 주문-매출현황 날짜검색에 따른 주문결과 출력 관련 메서드*/
	public ArrayList<OrderDTO> salessearch(String start, String end, int cp,int listSize){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from(select rownum as rnum,a.* from (select * from myhome_order where order_date between to_date(?,'YYYY/MM/DD') and to_date(?,'YYYY/MM/DD')+1 order by order_date desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";		
			ps=conn.prepareStatement(sql);
			if(start.equals("")) {
				ps.setString(1, "0001-01-01");
			}else {
				ps.setString(1, start);
			}
			
			if(end.equals("")) {
				ps.setString(2, "4000-01-01");
			}else {
				ps.setString(2, end);
			}
			rs=ps.executeQuery();
			ArrayList<OrderDTO> arr= new ArrayList<OrderDTO>();
			while(rs.next()) {
				int order_idx = rs.getInt("order_idx");
				String order_state = rs.getString("order_state");
				String order_member_id = rs.getString("order_member_id");
				int order_goods_idx = rs.getInt("order_goods_idx");
				int order_amount = rs.getInt("order_amount");
				int order_price = rs.getInt("order_price");
				String order_addr = rs.getString("order_addr");
				String order_shipstate = rs.getString("order_shipstate");
				String order_pay = rs.getString("order_pay");
				Timestamp order_date = rs.getTimestamp("order_date");
				String order_goods_name = rs.getString("order_goods_name");
				int order_goods_price = rs.getInt("order_goods_price");
				String order_imgpath = rs.getString("order_goods_imgpath");
				
				OrderDTO dto = new OrderDTO(order_idx, order_state, order_member_id, order_goods_idx, order_amount, order_price, order_addr, order_shipstate, order_pay, order_date, order_imgpath, order_goods_name, order_goods_price);
				arr.add(dto);
			}
			
			return arr;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**관리자페이지 주문- 매출현황 날짜검색에 따른 주문 결과 총 수*/
	public int salescount(String start, String end) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) from myhome_order where order_date between to_date(?,'YYYY/MM/DD') and to_date(?,'YYYY/MM/DD')+1 ";		
			ps=conn.prepareStatement(sql);
			if(start.equals("")) {
				ps.setString(1, "0001-01-01");
			}else {
				ps.setString(1, start);
			}
			
			if(end.equals("")) {
				ps.setString(2, "4000-01-01");
			}else {
				ps.setString(2, end);
			}		
			rs=ps.executeQuery();
			int count = 0;
			while(rs.next()) {
					count = rs.getInt(1);
			}
			return count;

		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**관리자페이지 주문-매출현황 날짜검색에 따른 주문결과 매출액 출력 관련 메서드*/
	public int totalsales(String start, String end){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select decode(sum(order_price),null,0,sum(order_price)) total from myhome_order where order_date between to_date(?,'YYYY/MM/DD') and (to_date(?,'YYYY/MM/DD')+1) order by order_date desc";		
			ps=conn.prepareStatement(sql);
			if(start.equals("")) {
				ps.setString(1, "0001-01-01");
			}else {
				ps.setString(1, start);
			}
			
			if(end.equals("")) {
				ps.setString(2, "4000-01-01");
			}else {
				ps.setString(2, end);
			}
			rs=ps.executeQuery();
			int totalsales=0;
			while(rs.next()) {
				totalsales = rs.getInt(1);
			}
			
			return totalsales;
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}	
	/**관리자페이지 주문-매출현황 주문서 관련 메서드*/
	public OrderDTO orderimfo(int idx){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from myhome_order where order_idx =?";		
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs = ps.executeQuery();
			OrderDTO dto=null;
			while(rs.next()) {
				int order_idx = rs.getInt("order_idx");
				String order_state = rs.getString("order_state");
				String order_member_id = rs.getString("order_member_id");
				int order_goods_idx = rs.getInt("order_goods_idx");
				int order_amount = rs.getInt("order_amount");
				int order_price = rs.getInt("order_price");
				String order_addr = rs.getString("order_addr");
				String order_shipstate = rs.getString("order_shipstate");
				String order_pay = rs.getString("order_pay");
				Timestamp order_date = rs.getTimestamp("order_date");
				String order_goods_name = rs.getString("order_goods_name");
				int order_goods_price = rs.getInt("order_goods_price");
				String order_imgpath = rs.getString("order_goods_imgpath");
				dto = new OrderDTO(order_idx, order_state, order_member_id, order_goods_idx, order_amount, order_price, order_addr, order_shipstate, order_pay, order_date, order_imgpath, order_goods_name, order_goods_price);
			}
			return dto;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}	

	/**관리자페이지 상품 진열 변경 관련 메서드*/
	public void goodsdislpay(int idx) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="update myhome_goods set goods_state='입고' where goods_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.executeUpdate();
			
		} catch (Exception e) {
		
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();					
			} catch (Exception e2) {}
		}
	}
	/**관리자페이지 상품 진열 대기 변경 관련 메서드*/
	public void goodsnodislpay(int idx) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="update myhome_goods set goods_state='게시' where goods_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.executeUpdate();
			
		} catch (Exception e) {
		
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();				
			} catch (Exception e2) {}
		}
	}	
	/**관리자페이지 상품 진열 관련 메서드*/
	public ArrayList<GoodsDTO> goodsDisplaylist(int cp,int listSize){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from(select rownum as rnum,a.* from (select * from myhome_goods where goods_state='게시' order by goods_adddate desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"order by goods_adddate desc";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<GoodsDTO> arr = new ArrayList<GoodsDTO>();
			while(rs.next()) {
				int goods_idx=rs.getInt("goods_idx");
				int goods_category=rs.getInt("goods_category");
				String goods_name=rs.getString("goods_name");
				String goods_path=rs.getString("goods_imgpath");
				int goods_price=rs.getInt("goods_price");
				int goods_amount=rs.getInt("goods_amount");
				String goods_content=rs.getString("goods_content");
				String goods_state=rs.getString("goods_state");
				int goods_buy=rs.getInt("goods_buy");
				Timestamp goods_date=rs.getTimestamp("goods_adddate");
				int goods_like=rs.getInt("goods_like");
				int goods_readnum=rs.getInt("goods_readnum");
				int goods_ref=rs.getInt("goods_ref");
				int goods_lev=rs.getInt("goods_lev");
				int goods_sunbun=rs.getInt("goods_sunbun");			
				GoodsDTO dto=new GoodsDTO(goods_idx, goods_category, goods_name, goods_path, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_date, goods_like, goods_readnum, goods_ref, goods_lev, goods_sunbun);		
				arr.add(dto);
			}
				
			return arr;			
		}catch(Exception e) {
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();	
			} catch (Exception e2) {}
		}
		
		
	}
	/**관리자페이지 상품 진열 대기 관련 메서드*/
	public ArrayList<GoodsDTO> goodsnoDisplaylist(int cp,int listSize){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from(select rownum as rnum,a.* from (select * from myhome_goods where goods_state='입고' order by goods_adddate desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<GoodsDTO> arr = new ArrayList<GoodsDTO>();
			while(rs.next()) {
				int goods_idx=rs.getInt("goods_idx");
				int goods_category=rs.getInt("goods_category");
				String goods_name=rs.getString("goods_name");
				String goods_path=rs.getString("goods_imgpath");
				int goods_price=rs.getInt("goods_price");
				int goods_amount=rs.getInt("goods_amount");
				String goods_content=rs.getString("goods_content");
				String goods_state=rs.getString("goods_state");
				int goods_buy=rs.getInt("goods_buy");
				Timestamp goods_date=rs.getTimestamp("goods_adddate");
				int goods_like=rs.getInt("goods_like");
				int goods_readnum=rs.getInt("goods_readnum");
				int goods_ref=rs.getInt("goods_ref");
				int goods_lev=rs.getInt("goods_lev");
				int goods_sunbun=rs.getInt("goods_sunbun");			
				GoodsDTO dto=new GoodsDTO(goods_idx, goods_category, goods_name, goods_path, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_date, goods_like, goods_readnum, goods_ref, goods_lev, goods_sunbun);		
				arr.add(dto);
			}
				
			return arr;			
		}catch(Exception e) {
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();	
			} catch (Exception e2) {}
		}
		
		
	}	
	/**관리자페이지 메인홈 등록된 상품리스트 최대5개*/
	public ArrayList<GoodsDTO> goodsMainList(){
		
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from myhome_goods order by goods_adddate desc";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<GoodsDTO> arr = new ArrayList<GoodsDTO>();
			while(rs.next()) {
				int goods_idx=rs.getInt("goods_idx");
				int goods_category=rs.getInt("goods_category");
				String goods_name=rs.getString("goods_name");
				String goods_path=rs.getString("goods_imgpath");
				int goods_price=rs.getInt("goods_price");
				int goods_amount=rs.getInt("goods_amount");
				String goods_content=rs.getString("goods_content");
				String goods_state=rs.getString("goods_state");
				int goods_buy=rs.getInt("goods_buy");
				Timestamp goods_date=rs.getTimestamp("goods_adddate");
				int goods_like=rs.getInt("goods_like");
				int goods_readnum=rs.getInt("goods_readnum");
				int goods_ref=rs.getInt("goods_ref");
				int goods_lev=rs.getInt("goods_lev");
				int goods_sunbun=rs.getInt("goods_sunbun");			
				GoodsDTO dto=new GoodsDTO(goods_idx, goods_category, goods_name, goods_path, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_date, goods_like, goods_readnum, goods_ref, goods_lev, goods_sunbun);		
				arr.add(dto);
			}
				
			return arr;
		}catch(Exception e) {
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();				
			} catch (Exception e1) {}
		}
	}
	
	/**관리자페이지 메인홈 등록된 상품총 갯수*/
	public int goodsCount() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) as cnt from myhome_goods";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int count =0;
			if(rs.next()) {
					count = rs.getInt("cnt");
			}
			return count;
		} catch (Exception e) {
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();					
			} catch (Exception e2) {}
		}
	}
	/**관리자페이지 메인홈 진열된 상품리스트 최대5개*/
	public ArrayList<GoodsDTO> goodsMainshowList(){
		
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from myhome_goods where goods_state ='게시' order by goods_adddate desc";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<GoodsDTO> arr = new ArrayList<GoodsDTO>();
			while(rs.next()) {
				int goods_idx=rs.getInt("goods_idx");
				int goods_category=rs.getInt("goods_category");
				String goods_name=rs.getString("goods_name");
				String goods_path=rs.getString("goods_imgpath");
				int goods_price=rs.getInt("goods_price");
				int goods_amount=rs.getInt("goods_amount");
				String goods_content=rs.getString("goods_content");
				String goods_state=rs.getString("goods_state");
				int goods_buy=rs.getInt("goods_buy");
				Timestamp goods_date=rs.getTimestamp("goods_adddate");
				int goods_like=rs.getInt("goods_like");
				int goods_readnum=rs.getInt("goods_readnum");
				int goods_ref=rs.getInt("goods_ref");
				int goods_lev=rs.getInt("goods_lev");
				int goods_sunbun=rs.getInt("goods_sunbun");			
				GoodsDTO dto=new GoodsDTO(goods_idx, goods_category, goods_name, goods_path, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_date, goods_like, goods_readnum, goods_ref, goods_lev, goods_sunbun);		
				arr.add(dto);
			}
				
			return arr;
		}catch(Exception e) {
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();				
			} catch (Exception e1) {}
		}
	}
	/**관리자페이지 메인홈 진열된 상품총 갯수*/
	public int goodsshowCount() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) as cnt from myhome_goods where goods_state ='게시'";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int count =0;
			if(rs.next()) {
					count = rs.getInt("cnt");
			}
			return count;
		} catch (Exception e) {
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();					
			} catch (Exception e2) {}
		}
	}
	/**관리자페이지 메인홈 진열대기 상품총 갯수*/
	public int goodsnoshowCount() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) as cnt from myhome_goods where goods_state ='입고'";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int count =0;
			if(rs.next()) {
					count = rs.getInt("cnt");
			}
			return count;
		} catch (Exception e) {
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();					
			} catch (Exception e2) {}
		}
	}	
	/**관리자페이지 메인홈 가입한 회원리스트 최대5개*/
	public ArrayList<MemberDTO> goodsMainmemberList(){
		
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from myhome_member where member_state ='일반' order by member_date desc";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<MemberDTO> arr = new ArrayList<MemberDTO>();
			while(rs.next()) {
				
				int member_idx=rs.getInt("member_idx");
				String member_state=rs.getString("member_state");
				String member_level=rs.getString("member_level");
				String member_id=rs.getString("member_id");
				String member_pwd=rs.getString("member_pwd");
				String member_name=rs.getString("member_name");
				String member_birthday=rs.getString("member_birthday");
				String member_gen=rs.getString("member_gen");
				String member_phone=rs.getString("member_phone");
				String member_email=rs.getString("member_email");
				String member_addr=rs.getString("member_addr");
				Timestamp member_date=rs.getTimestamp("member_date");
				Timestamp member_deldate=rs.getTimestamp("member_deldate");
				MemberDTO dto = new MemberDTO(member_idx, member_state, member_level, member_id, member_pwd, member_name, member_birthday, member_gen, member_phone, member_email, member_addr, member_date, member_deldate);
				arr.add(dto);
			}
				
			return arr;
		}catch(Exception e) {
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();				
			} catch (Exception e1) {}
		}
	}
	/**관리자페이지 메인홈 가입한 회원 인원 수*/
	public int memberCount() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) as cnt from myhome_member where member_state ='일반'";
			ps=conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int count =0;
			if(rs.next()) {
					count = rs.getInt("cnt");
			}
			return count;
		} catch (Exception e) {
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();					
			} catch (Exception e2) {}
		}
	}		
	/*관리자 로그인관련 메서드*/
	public int admin_login(String admin_id,String admin_pwd) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select admin_id,admin_pwd from myhome_admin where admin_id=? and admin_pwd=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, admin_id);
			ps.setString(2, admin_pwd);
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
	
	//회원수정
	public int admin_memberUpdate(String id, String level){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="update myhome_member set member_level=? where member_id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, level);
			ps.setString(2, id);
			int count=ps.executeUpdate();
			return count;
			
		} catch (Exception e) {
			// TODO: handle exception
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
	
	//회원탈퇴
		public int admin_memberdel(String id){
			try {
				conn=myhome.db.MyhomeDB.getConn();
				String sql="delete from myhome_member where member_id=?";
				ps=conn.prepareStatement(sql);;
				ps.setString(1, id);
				int count=ps.executeUpdate();
				return count;
				
			} catch (Exception e) {
				// TODO: handle exception
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
	
		/**회원관리 메서드 */
		public ArrayList<MemberDTO> member_admin(String sel,String text,int cp,int listSize){
			try {
				conn=myhome.db.MyhomeDB.getConn();
				String sql="";
				if(sel.equals("")) {
					sql="select *from(select rownum as rnum,a.* from (select * from myhome_member order by member_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
				}else if(sel.equals("member_date")){
					sql="select *from(select rownum as rnum,a.* from (select * from myhome_member where trunc(member_date)=to_date(?,'YYYY/MM/DD') order by member_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
					
				}else {
					sql="select *from(select rownum as rnum,a.* from (select * from myhome_member where "+sel+"=? order by member_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
				}
				ps=conn.prepareStatement(sql);
				if(!sel.equals("")) {
					ps.setString(1, text);
				}	

				rs=ps.executeQuery();
				ArrayList<MemberDTO> arr= new ArrayList<MemberDTO>();
				while(rs.next()) {
					int member_idx=rs.getInt("member_idx");
					String member_state=rs.getString("member_state");
					String member_level=rs.getString("member_level");
					String member_id=rs.getString("member_id");
					String member_pwd=rs.getString("member_pwd");
					String member_name=rs.getString("member_name");
					String member_birthday=rs.getString("member_birthday");
					String member_gen=rs.getString("member_gen");
					String member_phone=rs.getString("member_phone");
					String member_email=rs.getString("member_email");
					String member_addr=rs.getString("member_addr");
					Timestamp member_date=rs.getTimestamp("member_date");
					Timestamp member_deldate=rs.getTimestamp("member_deldate");
					
					MemberDTO dto=new MemberDTO(member_idx, member_state, member_level, member_id, member_pwd, member_name, member_birthday, member_gen, member_phone, member_email, member_addr, member_date, member_deldate);
					arr.add(dto);
				
				}
				return arr;
			}catch(Exception e){
				e.printStackTrace();
				return null;
			}finally {
				try {
					if(rs!=null)rs.close();
					if(ps!=null)ps.close();
					if(conn!=null)conn.close();
				}catch(Exception e2) {}
			}
		}
		/**회원관리 메서드 */
		public ArrayList<MemberDTO> member_deladmin(String sel,String text,int cp,int listSize){
			try {
				conn=myhome.db.MyhomeDB.getConn();
				String sql="";
				if(sel.equals("")) {
					sql="select *from(select rownum as rnum,a.* from (select * from myhome_member where member_state='탈퇴' order by member_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
				}else {
					sql="select *from(select rownum as rnum,a.* from (select * from myhome_member where "+sel+"=? and member_state='탈퇴'order by member_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
				}
				ps=conn.prepareStatement(sql);
				if(!sel.equals("")) {
					ps.setString(1, text);
				}	

				rs=ps.executeQuery();
				ArrayList<MemberDTO> arr= new ArrayList<MemberDTO>();
				while(rs.next()) {
					int member_idx=rs.getInt("member_idx");
					String member_state=rs.getString("member_state");
					String member_level=rs.getString("member_level");
					String member_id=rs.getString("member_id");
					String member_pwd=rs.getString("member_pwd");
					String member_name=rs.getString("member_name");
					String member_birthday=rs.getString("member_birthday");
					String member_gen=rs.getString("member_gen");
					String member_phone=rs.getString("member_phone");
					String member_email=rs.getString("member_email");
					String member_addr=rs.getString("member_addr");
					Timestamp member_date=rs.getTimestamp("member_date");
					Timestamp member_deldate=rs.getTimestamp("member_deldate");
					
					MemberDTO dto=new MemberDTO(member_idx, member_state, member_level, member_id, member_pwd, member_name, member_birthday, member_gen, member_phone, member_email, member_addr, member_date, member_deldate);
					arr.add(dto);
				
				}
				return arr;
			}catch(Exception e){
				e.printStackTrace();
				return null;
			}finally {
				try {
					if(rs!=null)rs.close();
					if(ps!=null)ps.close();
					if(conn!=null)conn.close();
				}catch(Exception e2) {}
			}
		}
	/**회원관리 메서드 */
	public ArrayList<MemberDTO> delmemlist(int cp,int listSize){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select *from(select rownum as rnum,a.* from (select * from myhome_member where member_state='탈퇴' order by member_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<MemberDTO> arr= new ArrayList<MemberDTO>();
			while(rs.next()) {
				int member_idx=rs.getInt("member_idx");
				String member_state=rs.getString("member_state");
				String member_level=rs.getString("member_level");
				String member_id=rs.getString("member_id");
				String member_pwd=rs.getString("member_pwd");
				String member_name=rs.getString("member_name");
				String member_birthday=rs.getString("member_birthday");
				String member_gen=rs.getString("member_gen");
				String member_phone=rs.getString("member_phone");
				String member_email=rs.getString("member_email");
				String member_addr=rs.getString("member_addr");
				Timestamp member_date=rs.getTimestamp("member_date");
				Timestamp member_deldate=rs.getTimestamp("member_deldate");
				
				MemberDTO dto=new MemberDTO(member_idx, member_state, member_level, member_id, member_pwd, member_name, member_birthday, member_gen, member_phone, member_email, member_addr, member_date, member_deldate);
				arr.add(dto);
				
			}
			return arr;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
		
		
	}
	
		/*관리자 게시판 관리*/
	public ArrayList<bbsDTO> bbsList(int cp,int listSize){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs order by bbs_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			
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
	   /*게시판 총게시물수 관련 메서드*/
		public int getbbsTotalCnt() {
			try {
				conn=myhome.db.MyhomeDB.getConn();
				String sql="select count(*) from myhome_bbs";
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
		/**게시글 삭제관련 메소드(관리자db 완전삭제)*/
		   public int bbsdel(int idx){
		      try{
		    	 conn=myhome.db.MyhomeDB.getConn();
		         String sql="delete myhome_bbs where bbs_idx=?";    
		         ps=conn.prepareStatement(sql);
		         ps.setInt(1, idx);
		         int count=ps.executeUpdate();
		         return count;
		         
		      }catch (Exception e) {
		         
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
		   /*게시판 상태변환(정상,보류,삭제)*/
	public int bbs_state_modify(String state,int idx) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="update myhome_bbs set bbs_state=? where bbs_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, state);
			ps.setInt(2,idx);
			
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
	/*회원 총게시물수 관련 메서드*/
	public int member_getmemberTotalCnt(String sel,String text) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="";
			if(sel.equals("")) {
				sql="select count(*) from myhome_member";
			}else if(sel.equals("member_date")){
				sql="select count(*) from myhome_member where trunc(member_date)=to_date(?,'YYYY/MM/DD')";
			}else {
				sql="select count(*) from myhome_member where "+sel+"=?";
			}

			ps=conn.prepareStatement(sql);
			if(!sel.equals("")) {
				ps.setString(1, text);
			}			
			rs=ps.executeQuery();
			rs.next();
			int count=rs.getInt(1);
			return count==0?1:count;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
			}
		}
	}
	/*회원 총게시물수 관련 메서드*/
	public int order_getbbsTotalCnt() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) from myhome_order";
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
	
	/*입금현황 총게시물수 관련 메서드*/
	public int order_getbbsTotalCnt2() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) from myhome_order where order_state='입금대기'";
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
	
	/*배송현황 총게시물수 관련 메서드*/
	public int order_getbbsTotalCnt3() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) from myhome_order where order_shipstate='상품준비중'";
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
	
	public int order_getbbsTotalCnt3_1() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) from myhome_order where order_shipstate='배송중'";
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
	
	/*배송완료현황 총게시물수 관련 메서드*/
	public int order_getbbsTotalCnt4() {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) from myhome_order where order_state='배송완료'";
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
	
	/*장바구니 총게시물수 관련 메서드*/
	public int cart_getbbsTotalCnt(int useridx) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) from myhome_cart where cart_member_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, useridx);
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
	
	/*주문내역 총게시물수 관련 메서드*/
	public int order_getbbsTotalCnt5(String userid) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) from myhome_order where order_member_id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, userid);
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
	/**상품관리 메서드 */
	public ArrayList<GoodsDTO> goodslist(int chs,String goodsname,String goodscate,String min,String max,int cp,int listSize){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from(select rownum as rnum,a.* from (select * from myhome_goods where goods_name LIKE ? AND goods_category LIKE ? order by goods_adddate desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			if(chs!=1) {
				sql="select * from(select rownum as rnum,a.* from (select * from myhome_goods where goods_name LIKE ? AND goods_category LIKE ? AND goods_price between ? and ? order by goods_adddate desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			}
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, "%"+goodsname+"%");
			ps.setString(2, "%"+goodscate+"%");
			if(chs!=1) {
				ps.setInt(3, Integer.parseInt(min));
				ps.setInt(4, Integer.parseInt(max));
			}
			rs=ps.executeQuery();
			ArrayList<GoodsDTO> arr= new ArrayList<GoodsDTO>();
			while(rs.next()) {
				int goods_idx=rs.getInt("goods_idx");
				int goods_category=rs.getInt("goods_category");
				String goods_name=rs.getString("goods_name");
				String goods_path=rs.getString("goods_imgpath");
				int goods_price=rs.getInt("goods_price");
				int goods_amount=rs.getInt("goods_amount");
				String goods_content=rs.getString("goods_content");
				String goods_state=rs.getString("goods_state");
				int goods_buy=rs.getInt("goods_buy");
				Timestamp goods_date=rs.getTimestamp("goods_adddate");
				int goods_like=rs.getInt("goods_like");
				int goods_readnum=rs.getInt("goods_readnum");
				int goods_ref=rs.getInt("goods_ref");
				int goods_lev=rs.getInt("goods_lev");
				int goods_sunbun=rs.getInt("goods_sunbun");
				
				GoodsDTO dto=new GoodsDTO(goods_idx, goods_category, goods_name, goods_path, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_date, goods_like, goods_readnum, goods_ref, goods_lev, goods_sunbun);
				arr.add(dto);
				
			}
			return arr;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	/**제품 상세 보기 관련 메서드*/
	public GoodsDTO goodsLook(int idx){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from myhome_goods where goods_idx = ?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs=ps.executeQuery();
			GoodsDTO dto= null;
			while(rs.next()) {
				int goods_idx=rs.getInt("goods_idx");
				int goods_category=rs.getInt("goods_category");
				String goods_name=rs.getString("goods_name");
				String goods_path=rs.getString("goods_imgpath");
				int goods_price=rs.getInt("goods_price");
				int goods_amount=rs.getInt("goods_amount");
				String goods_content=rs.getString("goods_content");
				String goods_state=rs.getString("goods_state");
				int goods_buy=rs.getInt("goods_buy");
				Timestamp goods_date=rs.getTimestamp("goods_adddate");
				int goods_like=rs.getInt("goods_like");
				int goods_readnum=rs.getInt("goods_readnum");
				int goods_ref=rs.getInt("goods_ref");
				int goods_lev=rs.getInt("goods_lev");
				int goods_sunbun=rs.getInt("goods_sunbun");
				
				dto=new GoodsDTO(goods_idx, goods_category, goods_name, goods_path, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_date, goods_like, goods_readnum, goods_ref, goods_lev, goods_sunbun);
				
			}
			return dto;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}	
	/*스토어 총게시물수 관련 메서드*/
	public int store_getbbsTotalCnt(int chs,String goodsname,String goodscate,String min,String max) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select count(*) from myhome_goods where goods_name LIKE ? AND goods_category LIKE ?";
			if(chs!=1) {
				sql="select count(*) from myhome_goods where goods_name LIKE ? AND goods_category LIKE ? AND goods_price between ? and ?";
			}
			ps=conn.prepareStatement(sql);
			ps.setString(1, "%"+goodsname+"%");
			ps.setString(2, "%"+goodscate+"%");
			if(chs!=1) {
				ps.setInt(3, Integer.parseInt(min));
				ps.setInt(4, Integer.parseInt(max));
			}
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
	/**상품관리 메서드 */
	public ArrayList<OrderDTO> orderlist(int cp,int listSize){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from(select rownum as rnum,a.* from (select * from myhome_order where order_state='입금대기' order by order_idx)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";			ps=conn.prepareStatement(sql);
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<OrderDTO> arr= new ArrayList<OrderDTO>();
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
				int order_goods_price=rs.getInt("order_goods_price");
				String order_imgpath=rs.getString("order_goods_imgpath");
				
				OrderDTO dto = new OrderDTO(order_idx, order_state, order_member_id, order_goods_idx, order_amount, order_price, order_addr, order_shipstate, order_pay, order_date, order_imgpath, order_goods_name, order_goods_price);
				arr.add(dto);
				
			}
			return arr;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//사용자 주문내역 리스트 관련 메소드
	public ArrayList<OrderDTO> orderBuyList(int cp, int listSize, String id){
		try {
			
			conn=myhome.db.MyhomeDB.getConn();
			
			String sql="select * from(select rownum as rnum,a.* from (select * from myhome_order where order_member_id=? order by order_idx)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			
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
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/**상품관리 메서드 */
	public ArrayList<OrderDTO> orderlist2(int cp,int listSize){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from(select rownum as rnum,a.* from (select * from myhome_order where order_state='입금완료' and order_shipstate='상품준비중' order by order_idx)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<OrderDTO> arr= new ArrayList<OrderDTO>();
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
				int order_goods_price=rs.getInt("order_goods_price");
				String order_imgpath=rs.getString("order_goods_imgpath");
				
				OrderDTO dto = new OrderDTO(order_idx, order_state, order_member_id, order_goods_idx, order_amount, order_price, order_addr, order_shipstate, order_pay, order_date, order_imgpath, order_goods_name, order_goods_price);
				arr.add(dto);
				
			}
			return arr;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/**상품관리 메서드 */
	public ArrayList<OrderDTO> orderlist3(int cp,int listSize){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from(select rownum as rnum,a.* from (select * from myhome_order where order_state='입금완료' and order_shipstate='배송중' order by order_idx)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<OrderDTO> arr= new ArrayList<OrderDTO>();
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
				int order_goods_price=rs.getInt("order_goods_price");
				String order_imgpath=rs.getString("order_goods_imgpath");
				
				OrderDTO dto = new OrderDTO(order_idx, order_state, order_member_id, order_goods_idx, order_amount, order_price, order_addr, order_shipstate, order_pay, order_date, order_imgpath, order_goods_name, order_goods_price);
				arr.add(dto);
				
			}
			return arr;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	/**장바구니내역 리스트 관련 메서드 */
	public ArrayList<CartDTO> cartlist(int cp,int listSize,int useridx){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from(select rownum as rnum,a.* from (select * from myhome_cart where cart_member_idx=? order by cart_idx)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, useridx);
			rs=ps.executeQuery();
			ArrayList<CartDTO> arr= new ArrayList<CartDTO>();
			while(rs.next()) {
				int idx=rs.getInt("cart_idx");
				int goods_idx=rs.getInt("cart_goods_idx");
				int member_idx=rs.getInt("cart_member_idx");
				int goods_category_idx=rs.getInt("cart_goods_category_idx");
				String goods_imgpath=rs.getString("cart_goods_imgpath");
				String goods_name=rs.getString("cart_goods_name");
				int goods_price=rs.getInt("cart_goods_price");
				int goods_amount=rs.getInt("cart_goods_amount");
				String goods_state=rs.getString("cart_goods_state");
				String goods_optiona=rs.getString("cart_goods_optiona");
				String goods_optionb=rs.getString("cart_goods_optionb");
				CartDTO dto = new CartDTO(idx, goods_idx, member_idx, goods_category_idx, goods_imgpath, goods_name, goods_price, goods_amount, goods_state, goods_optiona, goods_optionb);
				arr.add(dto);
				
			}
			return arr;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
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
	            if(ps!=null)ps.close();
	            if(conn!=null)conn.close();
	         }catch(Exception e2) {}
	      }
	   }
	   /**카테고리 분류 관련 메서드*/
	   public CategoryDTO categorygoods(int num){
	      try {
	         
	         conn=myhome.db.MyhomeDB.getConn();
	         
	         String sql="select * from  myhome_category_goods where category_goods_num=?";
	         ps=conn.prepareStatement(sql);
	         ps.setInt(1, num);
	         rs=ps.executeQuery();
	         CategoryDTO dto = null;
	         while(rs.next()) {
	            
	            int category_goods_num=rs.getInt("category_goods_num");
	            String category_goods_imgpath=rs.getString("category_goods_imgpath");
	            String category_goods_name=rs.getString("category_goods_name");
	            
	            dto=new CategoryDTO(category_goods_num, category_goods_imgpath, category_goods_name);
	         }
	   
	         return dto;
	         
	      }catch(Exception e) {
	         e.printStackTrace();
	         return null;
	      }finally {
	         try {
	            if(rs!=null)rs.close();
	            if(ps!=null)ps.close();
	            if(conn!=null)conn.close();
	         }catch(Exception e2) {}
	      }
	   }   
	/**상품수정관리 메서드 */
	public GoodsDTO goodsUpdatelist(int idx){
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select * from(select rownum as rnum,a.* from (select * from myhome_goods where goods_idx = ? order by goods_idx)a)b ";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs=ps.executeQuery();
			GoodsDTO dto=null;
			while(rs.next()) {
				int goods_idx=rs.getInt("goods_idx");
				int goods_category=rs.getInt("goods_category");
				String goods_name=rs.getString("goods_name");
				String goods_path=rs.getString("goods_imgpath");
				int goods_price=rs.getInt("goods_price");
				int goods_amount=rs.getInt("goods_amount");
				String goods_content=rs.getString("goods_content");
				String goods_state=rs.getString("goods_state");
				int goods_buy=rs.getInt("goods_buy");
				Timestamp goods_date=rs.getTimestamp("goods_adddate");
				int goods_like=rs.getInt("goods_like");
				int goods_readnum=rs.getInt("goods_readnum");
				int goods_ref=rs.getInt("goods_ref");
				int goods_lev=rs.getInt("goods_lev");
				int goods_sunbun=rs.getInt("goods_sunbun");
				
				dto=new GoodsDTO(goods_idx, goods_category, goods_name, goods_path, goods_price, goods_amount, goods_content, goods_state, goods_buy, goods_date, goods_like, goods_readnum, goods_ref, goods_lev, goods_sunbun);
				
			}
			return dto;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	
	
	/*상품등록 관련 메서드*/
	public int addgoods(int category, String name, String imgpath, int price, int amount, String content, String state) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="insert into myhome_goods values(myhome_goods_idx.nextval, ?,?,?,?,?,?,?,0,sysdate,3,0,0,0,0)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, category);
			ps.setString(2, name);
			ps.setString(3, imgpath);
			ps.setInt(4, price);
			ps.setInt(5, amount);
			ps.setString(6, content);
			ps.setString(7, state);
		
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
	
	/*상품수정 관련 메서드*/
	public int updategoods(int category, String name, String imgpath, int price, int amount, String content, String state, int idx) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="update myhome_goods set goods_category=?, goods_name=?, goods_imgpath=?, goods_price=?, goods_amount=?, goods_content=?, goods_state=? where goods_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, category);
			ps.setString(2, name);
			ps.setString(3, imgpath);
			ps.setInt(4, price);
			ps.setInt(5, amount);
			ps.setString(6, content);
			ps.setString(7, state);
			ps.setInt(8, idx);
		
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
	
	 /**상품 삭제관련 메소드(관리자db 완전삭제)*/
	   public int goodsdel(int idx){
	      try{
	    	 conn=myhome.db.MyhomeDB.getConn();
	         String sql="delete from myhome_goods where goods_idx=?";    
	         ps=conn.prepareStatement(sql);
	         ps.setInt(1, idx);
	         int count=ps.executeUpdate();
	         return count;
	         
	      }catch (Exception e) {
	         
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
	   
	   /**카테고리 삭제관련 메소드(관리자db 완전삭제)*/
	   public int categorydel(int idx){
	      try{
	    	 conn=myhome.db.MyhomeDB.getConn();
	         String sql="delete from myhome_category_goods where category_goods_num=?";    
	         ps=conn.prepareStatement(sql);
	         ps.setInt(1, idx);
	         int count=ps.executeUpdate();
	         return count;
	         
	      }catch (Exception e) {
	         
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
	   
	   /*카테고리등록 관련 메서드*/
		public int addcategory(String img,String name) {
			try {
				conn=myhome.db.MyhomeDB.getConn();
				String sql="insert into myhome_category_goods values(myhome_category_goods_idx.nextval,?,?)";
				ps=conn.prepareStatement(sql);
				ps.setString(1, img);
				ps.setString(2, name);
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
		//입금완료 업데이트 관련 메소드
		public int orderUpdate(int ck){
			try {
				conn=myhome.db.MyhomeDB.getConn();
				String sql="update myhome_order set order_state='입금완료' where order_idx=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, ck);
				int count=ps.executeUpdate();
				return count;
				
			} catch (Exception e) {
				
				e.printStackTrace();
				return -1;
			} finally {
				try {
					if(ps!=null)ps.close();
					if(conn!=null)conn.close();
				} catch (Exception e2) {
					
				}
			}
		}
		
		//배송중 업데이트 관련 메소드
				public int orderUpdate2(int ck){
					try {
						conn=myhome.db.MyhomeDB.getConn();
						String sql="update myhome_order set order_shipstate='배송중' where order_idx=?";
						ps=conn.prepareStatement(sql);
						ps.setInt(1, ck);
						int count=ps.executeUpdate();
						return count;
						
					} catch (Exception e) {
						
						e.printStackTrace();
						return -1;
					} finally {
						try {
							if(ps!=null)ps.close();
							if(conn!=null)conn.close();
						} catch (Exception e2) {
							
						}
					}
				}	
		//배송완료 업데이트 관련 메소드
			public int orderUpdate3(int ck){
				try {
					conn=myhome.db.MyhomeDB.getConn();
					String sql="update myhome_order set order_shipstate='배송완료' where order_idx=?";
					ps=conn.prepareStatement(sql);
					ps.setInt(1, ck);
					int count=ps.executeUpdate();
					return count;
						
				} catch (Exception e) {	
					e.printStackTrace();
					return -1;
				} finally {
					try {
						if(ps!=null)ps.close();
						if(conn!=null)conn.close();
					} catch (Exception e2) {}
					}
				}
				/*게시판 총게시물수 관련 메서드*/
				public int getbbslistTotalCnt(String fkey,String search) {
					try {
						conn=myhome.db.MyhomeDB.getConn();
						String sql="";
						if(fkey.equals("")) {
							sql="select count(*) from myhome_bbs where bbs_state in('정상','보류')";
						}else{
							sql="select count(*) from myhome_bbs where "+fkey+"=? and bbs_state in('정상','보류')";
						}
						ps=conn.prepareStatement(sql);
						if(!(fkey.equals(""))) {
							if(fkey.equals("bbs_idx")) {
								ps.setInt(1, Integer.parseInt(search));
							}else {
								ps.setString(1, search);
							}
						}
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
				/*게시판 삭제 게시물수 관련 메서드*/
				public int getbbsdellistTotalCnt(String fkey,String search) {
					try {
						conn=myhome.db.MyhomeDB.getConn();
						String sql="";
						if(fkey.equals("")) {
							sql="select count(*) from myhome_bbs where bbs_state='삭제'";
						}else{
							sql="select count(*) from myhome_bbs where "+fkey+"=? and bbs_state='삭제'";
						}
						ps=conn.prepareStatement(sql);
						if(!(fkey.equals(""))) {
							if(fkey.equals("bbs_idx")) {
								ps.setInt(1, Integer.parseInt(search));
							}else {
								ps.setString(1, search);
							}
						}
						
						rs=ps.executeQuery();
						int count=0;
						while(rs.next()) {
							count=rs.getInt(1);
						}
						
						
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
				/*관리자 게시판 삭제관리*/
				public ArrayList<bbsDTO> bbsdelList(String fkey,String value,int cp,int listSize){
					try {
						conn=myhome.db.MyhomeDB.getConn();
						String sql="";
						if(fkey.equals("")) {
							sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs where bbs_state='삭제' order by bbs_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";

						}else if(fkey.equals("bbs_idx")){
							sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs where "+fkey+"=? and bbs_state='삭제' order by bbs_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
						}else if(fkey.equals("bbs_writer")) {
							sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs where "+fkey+"=? and bbs_state='삭제' order by bbs_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
						}else if(fkey.equals("bbs_subject")){
							sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs where "+fkey+" like ? and bbs_state='삭제' order by bbs_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";	
						}
						ps=conn.prepareStatement(sql);
						
						if(fkey.equals("")) {
							
						}
						else if(fkey.equals("bbs_idx")) {
							ps.setInt(1, Integer.parseInt(value));
						}else if(fkey.equals("bbs_writer")) {
							ps.setString(1, value);
						}else if(fkey.equals("bbs_subject")){
							ps.setString(1, "%"+value+"%");
						}
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
				/*관리자 게시판 관리및 검색*/
				public ArrayList<bbsDTO> bbsList(String fkey,String value,int cp,int listSize){
					try {
						String sql="";
						conn=myhome.db.MyhomeDB.getConn();
						if(fkey.equals("")) {
							sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs where bbs_state IN('정상','보류') order by bbs_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";

						}else if(fkey.equals("bbs_idx")){
							sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs where "+fkey+"=? and bbs_state IN('정상','보류') order by bbs_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
						}else if(fkey.equals("bbs_writer")) {
							sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs where "+fkey+"=? and bbs_state IN('정상','보류') order by bbs_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
						}else if(fkey.equals("bbs_subject")){
							sql="select *from(select rownum as rnum,a.* from (select * from myhome_bbs where "+fkey+" like ? and bbs_state IN('정상','보류') order by bbs_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";	
						}
						ps=conn.prepareStatement(sql);
						if(fkey.equals("")) {
							
						}
						else if(fkey.equals("bbs_idx")) {
							ps.setInt(1, Integer.parseInt(value));
						}else if(fkey.equals("bbs_writer")) {
							ps.setString(1, value);
						}else if(fkey.equals("bbs_subject")){
							ps.setString(1, "%"+value+"%");
						}
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
				/*회원의 게시물 더보기관련, 유저총게시물수 관련 메서드*/
				public int getUserRipTotalCnt(String member_id) {
					try {
						conn=myhome.db.MyhomeDB.getConn();
						String sql="select count(*) from myhome_rip where rip_member_id=?";
						ps=conn.prepareStatement(sql);
						ps.setString(1, member_id);
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
				/*관리자 디테일 리플관련 리스트(id로 확인)*/
				
				public ArrayList<ripDTO> adminRipList(String rip_id,int cp,int listSize){
					try {
						conn=myhome.db.MyhomeDB.getConn();
						String sql="select *from(select rownum as rnum,a.* from (select * from myhome_rip where rip_member_id=? order by rip_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
			
						
						ps=conn.prepareStatement(sql);
						ps.setString(1, rip_id);
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
				/*관리자 디테일 리플관련 리스트(id로 확인)*/
				
				public ArrayList<ripDTO> membrerRipList(int bbs_idx,String rip_id){
					try {
						conn=myhome.db.MyhomeDB.getConn();
						String sql="select * from myhome_rip where rip_bbs_idx=? and rip_member_id=? order by rip_idx desc ";
						ps=conn.prepareStatement(sql);
						ps.setInt(1, bbs_idx);
						ps.setString(2, rip_id);
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
				/**회원관리 메서드 */
				public ArrayList<MemberDTO> member_admin(int cp,int listSize){
					try {
						conn=myhome.db.MyhomeDB.getConn();
						String sql="select *from(select rownum as rnum,a.* from (select * from myhome_member order by member_idx desc)a)b where rnum>=("+cp+"-1)*"+listSize+"+1 and rnum<="+cp+"*"+listSize+"";
						ps=conn.prepareStatement(sql);
						rs=ps.executeQuery();
						ArrayList<MemberDTO> arr= new ArrayList<MemberDTO>();
						while(rs.next()) {
							int member_idx=rs.getInt("member_idx");
							String member_state=rs.getString("member_state");
							String member_level=rs.getString("member_level");
							String member_id=rs.getString("member_id");
							String member_pwd=rs.getString("member_pwd");
							String member_name=rs.getString("member_name");
							String member_birthday=rs.getString("member_birthday");
							String member_gen=rs.getString("member_gen");
							String member_phone=rs.getString("member_phone");
							String member_email=rs.getString("member_email");
							String member_addr=rs.getString("member_addr");
							Timestamp member_date=rs.getTimestamp("member_date");
							Timestamp member_deldate=rs.getTimestamp("member_deldate");
							
							MemberDTO dto=new MemberDTO(member_idx, member_state, member_level, member_id, member_pwd, member_name, member_birthday, member_gen, member_phone, member_email, member_addr, member_date, member_deldate);
							arr.add(dto);
						
						}
						return arr;
					}catch(Exception e){
						e.printStackTrace();
						return null;
					}finally {
						try {
							if(rs!=null)rs.close();
							if(ps!=null)ps.close();
							if(conn!=null)conn.close();
						}catch(Exception e2) {}
					}
				}
				/*회원 총게시물수 관련 메서드*/
				public int member_getbbsTotalCnt() {
					try {
						conn=myhome.db.MyhomeDB.getConn();
						String sql="select count(*) from myhome_member";
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
}

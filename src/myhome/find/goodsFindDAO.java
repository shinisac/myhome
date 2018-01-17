package myhome.find;

import java.sql.*;
import java.util.*;

public class goodsFindDAO {

			private Connection conn;
			private PreparedStatement ps;
			private ResultSet rs;
			
			
			public static final int NOT_ID=1;
			public static final int NOT_PWD=2;
			public static final int LOGIN_OK=3;
			public static final int ERROR=-1;
			
			public goodsFindDAO() {
				dbConnect();
			}
			
			public void dbConnect() {
				try {
					Class.forName("oracle.jdbc.driver.OracleDriver");
					String url="jdbc:oracle:thin:@localhost:1521:orcl";
					String user="scott";
					String pwd="1234";
					conn=DriverManager.getConnection(url,user,pwd);
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			
	
	
	

	
	/**상품 이름 검색 관련 메서드 */
	public ArrayList<goodsFindDTO>
		goodsFind(String fkey, String fvalue){
			try {
				conn=myhome.db.MyhomeDB.getConn();
				String sql="select * from myhome_goods where goods_state='게시' and "+fkey+" LIKE ?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, "%"+fvalue+"%");
				rs=ps.executeQuery();
				ArrayList<goodsFindDTO> arr= new ArrayList<goodsFindDTO>();
				while(rs.next()) {
					int goods_idx=rs.getInt("goods_idx");
					String goods_imgpath=rs.getString("goods_imgpath");
					String goods_name=rs.getString("goods_name");
					int goods_price=rs.getInt("goods_price");
					
					goodsFindDTO dto=new goodsFindDTO(goods_idx, goods_imgpath, goods_name, goods_price);
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
	
	
}

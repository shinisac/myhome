package myhome.Sfind;

import java.sql.*;
import java.util.*;


public class bbsFindDAO {

			private Connection conn;
			private PreparedStatement ps;
			private ResultSet rs;
			
			
			public static final int NOT_ID=1;
			public static final int NOT_PWD=2;
			public static final int LOGIN_OK=3;
			public static final int ERROR=-1;
			
			public bbsFindDAO() {
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
			
	
	
	

	
	/**스토리 제목+글 검색 관련 메서드 */
	public ArrayList<bbsFindDTO> bbsFind(String fkey, String fvalue){
			try {
				conn=myhome.db.MyhomeDB.getConn();
				String sql="select * from myhome_bbs where bbs_state='정상' and "+fkey+" LIKE ? OR bbs_state='정상' and bbs_content LIKE ? order by bbs_idx desc";
				ps=conn.prepareStatement(sql);
				ps.setString(1, "%"+fvalue+"%");
				ps.setString(2, "%"+fvalue+"%");
				rs=ps.executeQuery();
				ArrayList<bbsFindDTO> arr= new ArrayList<bbsFindDTO>();
				while(rs.next()) {
					int bbs_idx=rs.getInt("bbs_idx");
					String bbs_writer=rs.getString("bbs_writer");
					String bbs_subject=rs.getString("bbs_subject");
					String bbs_imgpath=rs.getString("bbs_imgpath");
					String bbs_content=rs.getString("bbs_content");
					int bbs_like=rs.getInt("bbs_like");
					int bbs_readnum=rs.getInt("bbs_readnum");
					bbsFindDTO dto=new bbsFindDTO(bbs_idx, bbs_writer, bbs_subject, bbs_imgpath, bbs_content, bbs_like, bbs_readnum);
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

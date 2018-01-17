package myhome.member;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import myhome.member.MemberDTO;
import myhome.store.MyhomeDTO;

public class MemberDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	
	public static final int NOT_ID=1;
	public static final int NOT_PWD=2;
	public static final int LOGIN_OK=3;
	public static final int ERROR=-1;
	
	public MemberDAO() {
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
	/**회원 idx찾기 관련 메서드*/
	public MemberDTO memberSearch(String temp) {
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql = "select * from myhome_member where member_id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, temp);
			rs = ps.executeQuery();
			MemberDTO dt = null;
			while(rs.next()) {
				
				int	member_idx = rs.getInt(1);
				String member_state = rs.getString(2);
				String member_level = rs.getString(3);
				String member_id = rs.getString(4);
				String member_pwd = rs.getString(5);
				String member_name = rs.getString(6);
				String member_birthday = rs.getString(7);
				String member_gen = rs.getString(8);
				String member_phone = rs.getString(9);
				String member_email = rs.getString(10);
				String member_addr = rs.getString(11);
				Timestamp member_date = rs.getTimestamp("member_date");
				Timestamp member_deldate = rs.getTimestamp("member_deldate");
				
				dt = new MemberDTO(member_idx, member_state, member_level, member_id, member_pwd, member_name, member_birthday, member_gen, member_phone, member_email, member_addr, member_date, member_deldate);
			}
			return dt;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {}
		}
		
	}
	
	
	/**회원 가입 메서드 */
	public int memberJoin(MemberDTO dto) {
		try {
			
			String sql="insert into myhome_member values(myhome_member_idx.nextval,?,?,?,?,?,?,?,?,?,?,sysdate,sysdate)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, "일반");
			ps.setString(2, "브론즈");
			ps.setString(3, dto.getMember_id());
			ps.setString(4, dto.getMember_pwd());
			ps.setString(5, dto.getMember_name());
			ps.setString(6, dto.getMember_birthday());
			ps.setString(7, dto.getMember_gen());
			ps.setString(8, dto.getMember_phone());
			ps.setString(9, dto.getMember_email());
			ps.setString(10, dto.getMember_addr());
			
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
	
	public boolean idCheck(String userid) {
		try {
			
			String sql="select member_id from myhome_member where member_id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs=ps.executeQuery();
			return rs.next();
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	
	
	/**회원 검색 관련 메서드 */
	public ArrayList<MemberDTO>
		memberFind(String fkey, String fvalue){
			try {
				conn=myhome.db.MyhomeDB.getConn();
				String sql="select * from myhome_member where "+fkey+"=?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, fvalue);
				rs=ps.executeQuery();
				ArrayList<MemberDTO> arr= new ArrayList<MemberDTO>();
				while(rs.next()) {
					int idx=rs.getInt("idx");
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
					
					MemberDTO dto= new MemberDTO(idx, member_state, member_level, member_id, 
							member_pwd, member_name, member_birthday, member_gen, member_phone,
							member_email, member_addr, member_date, member_deldate);
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
		
		
	
				
	//회원 로그인 팝업
	public int loginCheck(String userid, String userpwd) {
		
		try {
			conn=myhome.db.MyhomeDB.getConn();
			String sql="select member_pwd from myhome_member where member_id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs=ps.executeQuery();
			if(rs.next()) {
				String dbpwd=rs.getString(1);
				if(dbpwd.equals(userpwd)) {
					return LOGIN_OK;
				}else {
					return NOT_PWD;
				}
			}else {
				return NOT_ID;
			}
		}catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
		
		
	}
	
	//회원 로그인 팝업
		public int pwdCheck(String id, String name) {
			
			try {
				conn=myhome.db.MyhomeDB.getConn();
				String sql="select count(*) from myhome_member where member_id=? and member_name=?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, id);
				ps.setString(2, name);
				rs=ps.executeQuery();
				if(rs.next()) {
					int count=rs.getInt(1);
					
					if(count==1){
						return 1;//성공
					}else{
						return 0;
					}
					
				}else {
					return NOT_ID;
				}
			}catch(Exception e) {
				e.printStackTrace();
				return ERROR;
			}finally {
				try {
					if(rs!=null)rs.close();
					if(ps!=null)ps.close();
					if(conn!=null)conn.close();
				}catch(Exception e2) {}
			}
			
			
		}

		
		
		//사용자 정보취득 관련 메서드
		
		public String getUserInfo(String userid) {
			try {
					conn=myhome.db.MyhomeDB.getConn();
					String sql="select member_name from myhome_member where member_id=?";
					ps=conn.prepareStatement(sql);
					ps.setString(1, userid);
					rs=ps.executeQuery();
					rs.next();
					return rs.getString(1);
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
		
		
		
		//회원 아이디 찾기(이름,이메일)
		public String getserchInfo(String name, String email) {
			try {
					conn=myhome.db.MyhomeDB.getConn();
					String sql="select member_id from myhome_member where member_name=? and member_email=?";
					ps=conn.prepareStatement(sql);
					ps.setString(1, name);
					ps.setString(2, email);
					rs=ps.executeQuery();
					rs.next();
					return rs.getString(1);
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
		
		
		//회원 비밀번호 찾기(이름,아이디)
		public String getserchInfopwd(String name, String id) {
			try {
					conn=myhome.db.MyhomeDB.getConn();
					String sql="select member_pwd from myhome_member where member_name=? and member_id=?";
					ps=conn.prepareStatement(sql);
					ps.setString(1, name);
					ps.setString(2, id);
					rs=ps.executeQuery();
					rs.next();
					return rs.getString(1);
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
		/**회원수정관련 메서드 */
		public int memberUpdate(MemberDTO mdto) {
			try {
				
				conn=myhome.db.MyhomeDB.getConn();
				
				String sql = "update myhome_member set member_phone=?, member_email=?, member_addr=? where member_idx=?";
				ps = conn.prepareStatement(sql);
				
				ps.setString(1, mdto.getMember_phone());
				ps.setString(2, mdto.getMember_email());
				ps.setString(3, mdto.getMember_addr());
				ps.setInt(4, mdto.getMember_idx());

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
		/**회원목록관련 메서드*/
		public ArrayList<MemberDTO> memberList(String id){
			try {
				
				conn=myhome.db.MyhomeDB.getConn();
				
				String sql="select * from myhome_member where member_id=?";
				
				ps=conn.prepareStatement(sql);
				ps.setString(1, id);
				rs=ps.executeQuery();
				ArrayList<MemberDTO> arr=new ArrayList<MemberDTO>();
				
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
					
					MemberDTO dto= new MemberDTO(member_idx, member_state, member_level, member_id, member_pwd, member_name, member_birthday, member_gen, member_phone, member_email, member_addr, member_date, member_deldate);
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
		
		/**DTO 회원목록관련 메서드*/
		public MemberDTO memberPwd(String id){
			try {
				
				conn=myhome.db.MyhomeDB.getConn();
				
				String sql="select member_pwd from myhome_member where member_id=?";
				
				ps=conn.prepareStatement(sql);
				ps.setString(1, id);
				rs=ps.executeQuery();
				MemberDTO dto=null;
				
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
					
					dto= new MemberDTO(member_idx, member_state, member_level, member_id, member_pwd, member_name, member_birthday, member_gen, member_phone, member_email, member_addr, member_date, member_deldate);
					
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
		/**회원 비밀번호 수정관련 메서드 */
		public int memberPwdUpdate(String id,String pwd) {
			try {
				
				conn=myhome.db.MyhomeDB.getConn();
				
				String sql = "update myhome_member set member_pwd=? where member_id=?";
				ps = conn.prepareStatement(sql);
				
				ps.setString(1,pwd);
				ps.setString(2, id);

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
		/**회원 삭제관련 메서드 */
		public int memberDel(String id) {
			try {
				
				conn=myhome.db.MyhomeDB.getConn();
				
				String sql = "update myhome_member set member_state=?, member_deldate=sysdate where member_id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, "탈퇴");
				ps.setString(2, id);
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
		/**DTO 회원목록관련 메서드*/
		public MemberDTO memberDelList(String id){
			try {
				
				conn=myhome.db.MyhomeDB.getConn();
		
				String sql="select member_idx from myhome_member where member_id=?";
				
				ps=conn.prepareStatement(sql);
				ps.setString(1, id);
				rs=ps.executeQuery();
				MemberDTO dto=null;
				
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
					
					dto= new MemberDTO(member_idx, member_state, member_level, member_id, member_pwd, member_name, member_birthday, member_gen, member_phone, member_email, member_addr, member_date, member_deldate);
					
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
		/**회원 비밀번호 수정관련 메서드 */
		public int PwdUpdate(String id,String pwd) {
			try {
				
				conn=myhome.db.MyhomeDB.getConn();
				
				String sql = "update myhome_member set member_pwd=? where member_id=?";
				ps = conn.prepareStatement(sql);
				
				ps.setString(1, pwd);
				ps.setString(2, id);

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

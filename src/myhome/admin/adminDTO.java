package myhome.admin;
import java.sql.*;
import java.text.SimpleDateFormat;
public class adminDTO {
	
	private int admin_idx;
	private String admin_id;
	private String admin_pwd;
	private Date admin_date;
	
	public adminDTO() {
		
	}
	public adminDTO(int admin_idx, String admin_id, String admin_pwd, Date admin_date) {
		super();
		this.admin_idx = admin_idx;
		this.admin_id = admin_id;
		this.admin_pwd = admin_pwd;
		this.admin_date = admin_date;
	}
	
	public int getAdmin_idx() {
		return admin_idx;
	}

	public void setAdmin_idx(int admin_idx) {
		this.admin_idx = admin_idx;
	}

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public String getAdmin_pwd() {
		return admin_pwd;
	}

	public void setAdmin_pwd(String admin_pwd) {
		this.admin_pwd = admin_pwd;
	}

	public Date getAdmin_date() {
		return admin_date;
	}

	public void setAdmin_date(Date admin_date) {
		this.admin_date = admin_date;
	}
	
}

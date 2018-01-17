package myhome.rip;
import java.sql.*;


public class ripDTO {
	private String rip_member_id;
	private int rip_idx;
	private int rip_bbs_idx;
	private String rip_content;
    private int  rip_bbs_ref;
    private int rip_bbs_lev;
    private int rip_bbs_sunbun;
    private Timestamp rip_bbs_writedate;
	public ripDTO() {
	
	}
	
	
	public ripDTO(String rip_member_id, int rip_idx, int rip_bbs_idx, String rip_content, int rip_bbs_ref,
			int rip_bbs_lev, int rip_bbs_sunbun, Timestamp rip_bbs_writedate) {
		super();
		this.rip_member_id = rip_member_id;
		this.rip_idx = rip_idx;
		this.rip_bbs_idx = rip_bbs_idx;
		this.rip_content = rip_content;
		this.rip_bbs_ref = rip_bbs_ref;
		this.rip_bbs_lev = rip_bbs_lev;
		this.rip_bbs_sunbun = rip_bbs_sunbun;
		this.rip_bbs_writedate = rip_bbs_writedate;
	}


	public String getRip_member_id() {
		return rip_member_id;
	}
	public void setRip_member_id(String rip_member_id) {
		this.rip_member_id = rip_member_id;
	}
	public int getRip_idx() {
		return rip_idx;
	}
	public void setRip_idx(int rip_idx) {
		this.rip_idx = rip_idx;
	}
	public int getRip_bbs_idx() {
		return rip_bbs_idx;
	}
	public void setRip_bbs_idx(int rip_bbs_idx) {
		this.rip_bbs_idx = rip_bbs_idx;
	}
	public String getRip_content() {
		return rip_content;
	}
	public void setRip_content(String rip_content) {
		this.rip_content = rip_content;
	}
	public int getRip_bbs_ref() {
		return rip_bbs_ref;
	}
	public void setRip_bbs_ref(int rip_bbs_ref) {
		this.rip_bbs_ref = rip_bbs_ref;
	}
	public int getRip_bbs_lev() {
		return rip_bbs_lev;
	}
	public void setRip_bbs_lev(int rip_bbs_lev) {
		this.rip_bbs_lev = rip_bbs_lev;
	}
	public int getRip_bbs_sunbun() {
		return rip_bbs_sunbun;
	}
	public void setRip_bbs_sunbun(int rip_bbs_sunbun) {
		this.rip_bbs_sunbun = rip_bbs_sunbun;
	}
	public Timestamp getRip_bbs_writedate() {
		return rip_bbs_writedate;
	}
	public void setRip_bbs_writedate(Timestamp rip_bbs_writedate) {
		this.rip_bbs_writedate = rip_bbs_writedate;
	}

	
	
	
}

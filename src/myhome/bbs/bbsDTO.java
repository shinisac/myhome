package myhome.bbs;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.sql.*;

public class bbsDTO {
	private int bbs_idx;
	private String bbs_state;
	private int bbs_category;
	private String bbs_writer;
	

	private String bbs_subject;
	private String bbs_imgpath;
	private String bbs_content;
	private Timestamp bbs_writedate;
	private Timestamp bbs_editdate;
	private int bbs_like;
	private int bbs_readnum;
	private int bbs_ref;
	private int bbs_lev;
	private int bbs_sunbun;
	
	public bbsDTO(int bbs_idx, String bbs_state, int bbs_category, String bbs_writer, String bbs_subject,
			String bbs_imgpath, String bbs_content, Timestamp bbs_writedate, Timestamp bbs_editdate, int bbs_like,
			int bbs_readnum, int bbs_ref, int bbs_lev, int bbs_sunbun) {
		super();
		this.bbs_idx = bbs_idx;
		this.bbs_state = bbs_state;
		this.bbs_category = bbs_category;
		this.bbs_writer = bbs_writer;
		this.bbs_subject = bbs_subject;
		this.bbs_imgpath = bbs_imgpath;
		this.bbs_content = bbs_content;
		this.bbs_writedate = bbs_writedate;
		this.bbs_editdate = bbs_editdate;
		this.bbs_like = bbs_like;
		this.bbs_readnum = bbs_readnum;
		this.bbs_ref = bbs_ref;
		this.bbs_lev = bbs_lev;
		this.bbs_sunbun = bbs_sunbun;
	}


	
	public bbsDTO() {
		
		
	}


	public int getBbs_ref() {
		return bbs_ref;
	}


	public void setBbs_ref(int bbs_ref) {
		this.bbs_ref = bbs_ref;
	}


	public int getBbs_idx() {
		return bbs_idx;
	}

	public void setBbs_idx(int bbs_idx) {
		this.bbs_idx = bbs_idx;
	}

	public String getBbs_state() {
		return bbs_state;
	}

	public void setBbs_state(String bbs_state) {
		this.bbs_state = bbs_state;
	}

	public int getBbs_category() {
		return bbs_category;
	}

	public void setBbs_category(int bbs_category) {
		this.bbs_category = bbs_category;
	}

	
	public String getBbs_subject() {
		return bbs_subject;
	}

	public void setBbs_subject(String bbs_subject) {
		this.bbs_subject = bbs_subject;
	}

	public String getBbs_imgpath() {
		return bbs_imgpath;
	}

	public void setBbs_imgpath(String bbs_imgpath) {
		this.bbs_imgpath = bbs_imgpath;
	}

	public String getBbs_content() {
		return bbs_content;
	}

	public void setBbs_content(String bbs_content) {
		this.bbs_content = bbs_content;
	}

	public String getBbs_writedate() {
		SimpleDateFormat sdfCurrent = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		
		return sdfCurrent.format(bbs_writedate);
	}

	public void setBbs_writedate(Timestamp bbs_writedate) {
		this.bbs_writedate = bbs_writedate;
	}

	public String getBbs_editdate() {
		SimpleDateFormat sdfCurrent = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		return sdfCurrent.format(bbs_editdate);
	}

	public void setBbs_editdate(Timestamp bbs_editdate) {
		this.bbs_editdate = bbs_editdate;
	}

	public int getBbs_like() {
		return bbs_like;
	}

	public void setBbs_like(int bbs_like) {
		this.bbs_like = bbs_like;
	}

	public int getBbs_readnum() {
		return bbs_readnum;
	}

	public void setBbs_readnum(int bbs_readnum) {
		this.bbs_readnum = bbs_readnum;
	}

	public int getBbs_lev() {
		return bbs_lev;
	}

	public void setBbs_lev(int bbs_lev) {
		this.bbs_lev = bbs_lev;
	}

	public int getBbs_sunbun() {
		return bbs_sunbun;
	}

	public void setBbs_sunbun(int bbs_sunbun) {
		this.bbs_sunbun = bbs_sunbun;
	}
	public String getBbs_writer() {
		return bbs_writer;
	}


	public void setBbs_writer(String bbs_writer) {
		this.bbs_writer = bbs_writer;
	}
}


package myhome.Sfind;

public class bbsFindDTO {

	private int bbs_idx;
	private String bbs_writer;
	private String bbs_subject;
	private String bbs_imgpath;
	private String bbs_content;
	private int bbs_like;
	private int bbs_readnum;
	
	public bbsFindDTO() {
		super();
	}

	public bbsFindDTO(int bbs_idx, String bbs_writer, String bbs_subject, String bbs_imgpath, String bbs_content,
			int bbs_like, int bbs_readnum) {
		super();
		this.bbs_idx = bbs_idx;
		this.bbs_writer = bbs_writer;
		this.bbs_subject = bbs_subject;
		this.bbs_imgpath = bbs_imgpath;
		this.bbs_content = bbs_content;
		this.bbs_like = bbs_like;
		this.bbs_readnum = bbs_readnum;
	}

	public int getBbs_idx() {
		return bbs_idx;
	}

	public void setBbs_idx(int bbs_idx) {
		this.bbs_idx = bbs_idx;
	}

	public String getBbs_writer() {
		return bbs_writer;
	}

	public void setBbs_writer(String bbs_writer) {
		this.bbs_writer = bbs_writer;
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
	
}




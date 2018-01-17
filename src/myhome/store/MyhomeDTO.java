package myhome.store;

import java.sql.*;

public class MyhomeDTO {
	
	private int goods_idx;
	private int goods_category;
	private String goods_name;
	private String goods_imgpath;
	private int goods_price;
	private int goods_amount;
	private String goods_content;
	private String goods_state;
	private int goods_buy;
	private Date goods_adddate;
	private int goods_readnum;
	private int goods_ref;
	private int goods_lev;
	private int goods_sunbun;
	private int goods_like;
	
	public MyhomeDTO() {
		super();
	}

	public MyhomeDTO(int goods_idx, int goods_category, String goods_name, String goods_imgpath, int goods_price,
			int goods_amount, String goods_content, String goods_state, int goods_buy, Date goods_adddate,
			int goods_readnum, int goods_ref, int goods_lev, int goods_sunbun, int goods_like) {
		super();
		this.goods_idx = goods_idx;
		this.goods_category = goods_category;
		this.goods_name = goods_name;
		this.goods_imgpath = goods_imgpath;
		this.goods_price = goods_price;
		this.goods_amount = goods_amount;
		this.goods_content = goods_content;
		this.goods_state = goods_state;
		this.goods_buy = goods_buy;
		this.goods_adddate = goods_adddate;
		this.goods_readnum = goods_readnum;
		this.goods_ref = goods_ref;
		this.goods_lev = goods_lev;
		this.goods_sunbun = goods_sunbun;
		this.goods_like = goods_like;
	}

	public int getGoods_idx() {
		return goods_idx;
	}

	public void setGoods_idx(int goods_idx) {
		this.goods_idx = goods_idx;
	}

	public int getGoods_category() {
		return goods_category;
	}

	public void setGoods_category(int goods_category) {
		this.goods_category = goods_category;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public String getGoods_imgpath() {
		return goods_imgpath;
	}

	public void setGoods_imgpath(String goods_imgpath) {
		this.goods_imgpath = goods_imgpath;
	}

	public int getGoods_price() {
		return goods_price;
	}

	public void setGoods_price(int goods_price) {
		this.goods_price = goods_price;
	}

	public int getGoods_amount() {
		return goods_amount;
	}

	public void setGoods_amount(int goods_amount) {
		this.goods_amount = goods_amount;
	}

	public String getGoods_content() {
		return goods_content;
	}

	public void setGoods_content(String goods_content) {
		this.goods_content = goods_content;
	}

	public String getGoods_state() {
		return goods_state;
	}

	public void setGoods_state(String goods_state) {
		this.goods_state = goods_state;
	}

	public int getGoods_buy() {
		return goods_buy;
	}

	public void setGoods_buy(int goods_buy) {
		this.goods_buy = goods_buy;
	}

	public Date getGoods_adddate() {
		return goods_adddate;
	}

	public void setGoods_adddate(Date goods_adddate) {
		this.goods_adddate = goods_adddate;
	}

	public int getGoods_readnum() {
		return goods_readnum;
	}

	public void setGoods_readnum(int goods_readnum) {
		this.goods_readnum = goods_readnum;
	}

	public int getGoods_ref() {
		return goods_ref;
	}

	public void setGoods_ref(int goods_ref) {
		this.goods_ref = goods_ref;
	}

	public int getGoods_lev() {
		return goods_lev;
	}

	public void setGoods_lev(int goods_lev) {
		this.goods_lev = goods_lev;
	}

	public int getGoods_sunbun() {
		return goods_sunbun;
	}

	public void setGoods_sunbun(int goods_sunbun) {
		this.goods_sunbun = goods_sunbun;
	}

	public int getGoods_like() {
		return goods_like;
	}

	public void setGoods_like(int goods_like) {
		this.goods_like = goods_like;
	}
}

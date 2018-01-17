package myhome.beans;

import java.sql.*;

public class myhomeDTO {
	private int goods_ranking_idx;
	private int goods_ranking_category;
	private String goods_ranking_name;
	private String goods_ranking_imgpath;
	private int goods_ranking_price;
	private int goods_ranking_amount;
	private String goods_ranking_content;
	private String goods_ranking_state;
	private int goods_ranking_buy;
	private Date goods_ranking_adddate;
	private int goods_ranking_readnum;
	private int goods_ranking_ref;
	private int goods_ranking_lev;
	private int goods_ranking_sunbun;
	private int goods_ranking_like;
	
	public myhomeDTO(){
		
	}

	public myhomeDTO(int goods_ranking_idx, int goods_ranking_category, String goods_ranking_name,
			String goods_ranking_imgpath, int goods_ranking_price, int goods_ranking_amount,
			String goods_ranking_content, String goods_ranking_state, int goods_ranking_buy, Date goods_ranking_adddate,
			int goods_ranking_readnum, int goods_ranking_ref, int goods_ranking_lev, int goods_ranking_sunbun,
			int goods_ranking_like) {
		super();
		this.goods_ranking_idx = goods_ranking_idx;
		this.goods_ranking_category = goods_ranking_category;
		this.goods_ranking_name = goods_ranking_name;
		this.goods_ranking_imgpath = goods_ranking_imgpath;
		this.goods_ranking_price = goods_ranking_price;
		this.goods_ranking_amount = goods_ranking_amount;
		this.goods_ranking_content = goods_ranking_content;
		this.goods_ranking_state = goods_ranking_state;
		this.goods_ranking_buy = goods_ranking_buy;
		this.goods_ranking_adddate = goods_ranking_adddate;
		this.goods_ranking_readnum = goods_ranking_readnum;
		this.goods_ranking_ref = goods_ranking_ref;
		this.goods_ranking_lev = goods_ranking_lev;
		this.goods_ranking_sunbun = goods_ranking_sunbun;
		this.goods_ranking_like = goods_ranking_like;
	}

	public int getGoods_ranking_idx() {
		return goods_ranking_idx;
	}

	public void setGoods_ranking_idx(int goods_ranking_idx) {
		this.goods_ranking_idx = goods_ranking_idx;
	}

	public int getGoods_ranking_category() {
		return goods_ranking_category;
	}

	public void setGoods_ranking_category(int goods_ranking_category) {
		this.goods_ranking_category = goods_ranking_category;
	}

	public String getGoods_ranking_name() {
		return goods_ranking_name;
	}

	public void setGoods_ranking_name(String goods_ranking_name) {
		this.goods_ranking_name = goods_ranking_name;
	}

	public String getGoods_ranking_imgpath() {
		return goods_ranking_imgpath;
	}

	public void setGoods_ranking_imgpath(String goods_ranking_imgpath) {
		this.goods_ranking_imgpath = goods_ranking_imgpath;
	}

	public int getGoods_ranking_price() {
		return goods_ranking_price;
	}

	public void setGoods_ranking_price(int goods_ranking_price) {
		this.goods_ranking_price = goods_ranking_price;
	}

	public int getGoods_ranking_amount() {
		return goods_ranking_amount;
	}

	public void setGoods_ranking_amount(int goods_ranking_amount) {
		this.goods_ranking_amount = goods_ranking_amount;
	}

	public String getGoods_ranking_content() {
		return goods_ranking_content;
	}

	public void setGoods_ranking_content(String goods_ranking_content) {
		this.goods_ranking_content = goods_ranking_content;
	}

	public String getGoods_ranking_state() {
		return goods_ranking_state;
	}

	public void setGoods_ranking_state(String goods_ranking_state) {
		this.goods_ranking_state = goods_ranking_state;
	}

	public int getGoods_ranking_buy() {
		return goods_ranking_buy;
	}

	public void setGoods_ranking_buy(int goods_ranking_buy) {
		this.goods_ranking_buy = goods_ranking_buy;
	}

	public Date getGoods_ranking_adddate() {
		return goods_ranking_adddate;
	}

	public void setGoods_ranking_adddate(Date goods_ranking_adddate) {
		this.goods_ranking_adddate = goods_ranking_adddate;
	}

	public int getGoods_ranking_readnum() {
		return goods_ranking_readnum;
	}

	public void setGoods_ranking_readnum(int goods_ranking_readnum) {
		this.goods_ranking_readnum = goods_ranking_readnum;
	}

	public int getGoods_ranking_ref() {
		return goods_ranking_ref;
	}

	public void setGoods_ranking_ref(int goods_ranking_ref) {
		this.goods_ranking_ref = goods_ranking_ref;
	}

	public int getGoods_ranking_lev() {
		return goods_ranking_lev;
	}

	public void setGoods_ranking_lev(int goods_ranking_lev) {
		this.goods_ranking_lev = goods_ranking_lev;
	}

	public int getGoods_ranking_sunbun() {
		return goods_ranking_sunbun;
	}

	public void setGoods_ranking_sunbun(int goods_ranking_sunbun) {
		this.goods_ranking_sunbun = goods_ranking_sunbun;
	}

	public int getGoods_ranking_like() {
		return goods_ranking_like;
	}

	public void setGoods_ranking_like(int goods_ranking_like) {
		this.goods_ranking_like = goods_ranking_like;
	}

	
	
	

	
}


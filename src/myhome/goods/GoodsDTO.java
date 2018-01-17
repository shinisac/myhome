package myhome.goods;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
public class GoodsDTO {
	
	private int goods_idx;
	private int goods_category ;
	private String goods_name ;
	private String goods_path;
	private int goods_price ;
	private int goods_amount ;
	private String goods_content;
	private String goods_state ;
	private int goods_buy;
	private Timestamp goods_date;
	private int goods_like;
	private int goods_readnum;
	private int goods_ref;
	private int goods_lev;
	private int goods_sunbun;
	
	public GoodsDTO() {
		super();
	}

	public GoodsDTO(int goods_idx, int goods_category, String goods_name, String goods_path, int goods_price,
			int goods_amount, String goods_content, String goods_state, int goods_buy, Timestamp goods_date,
			int goods_like, int goods_readnum, int goods_ref, int goods_lev, int goods_sunbun) {
		super();
		this.goods_idx = goods_idx;
		this.goods_category = goods_category;
		this.goods_name = goods_name;
		this.goods_path = goods_path;
		this.goods_price = goods_price;
		this.goods_amount = goods_amount;
		this.goods_content = goods_content;
		this.goods_state = goods_state;
		this.goods_buy = goods_buy;
		this.goods_date = goods_date;
		this.goods_like = goods_like;
		this.goods_readnum = goods_readnum;
		this.goods_ref = goods_ref;
		this.goods_lev = goods_lev;
		this.goods_sunbun = goods_sunbun;
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

	public String getGoods_path() {
		return goods_path;
	}

	public void setGoods_path(String goods_path) {
		this.goods_path = goods_path;
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

	public Timestamp getGoods_date() {
		return goods_date;
	}

	public void setGoods_date(Timestamp goods_date) {
		this.goods_date = goods_date;
	}

	public int getGoods_like() {
		return goods_like;
	}

	public void setGoods_like(int goods_like) {
		this.goods_like = goods_like;
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

	
	
	
}

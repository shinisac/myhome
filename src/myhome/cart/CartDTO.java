package myhome.cart;

public class CartDTO {
	
	private int idx;
	private int goods_idx;
	private int member_idx;
	private int goods_category_idx;
	private String goods_imgpath;
	private String goods_name;
	private int goods_price;
	private int goods_amount;
	private String goods_state;
	private String goods_optiona;
	private String goods_optionb;
	
	public CartDTO() {
		// TODO Auto-generated constructor stub
	}

	public CartDTO(int idx, int goods_idx, int member_idx, int goods_category_idx, String goods_imgpath,
			String goods_name, int goods_price, int goods_amount, String goods_state, String goods_optiona,
			String goods_optionb) {
		super();
		this.idx = idx;
		this.goods_idx = goods_idx;
		this.member_idx = member_idx;
		this.goods_category_idx = goods_category_idx;
		this.goods_imgpath = goods_imgpath;
		this.goods_name = goods_name;
		this.goods_price = goods_price;
		this.goods_amount = goods_amount;
		this.goods_state = goods_state;
		this.goods_optiona = goods_optiona;
		this.goods_optionb = goods_optionb;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getGoods_idx() {
		return goods_idx;
	}

	public void setGoods_idx(int goods_idx) {
		this.goods_idx = goods_idx;
	}

	public int getMember_idx() {
		return member_idx;
	}

	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}

	public int getGoods_category_idx() {
		return goods_category_idx;
	}

	public void setGoods_category_idx(int goods_category_idx) {
		this.goods_category_idx = goods_category_idx;
	}

	public String getGoods_imgpath() {
		return goods_imgpath;
	}

	public void setGoods_imgpath(String goods_imgpath) {
		this.goods_imgpath = goods_imgpath;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
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

	public String getGoods_state() {
		return goods_state;
	}

	public void setGoods_state(String goods_state) {
		this.goods_state = goods_state;
	}

	public String getGoods_optiona() {
		return goods_optiona;
	}

	public void setGoods_optiona(String goods_optiona) {
		this.goods_optiona = goods_optiona;
	}

	public String getGoods_optionb() {
		return goods_optionb;
	}

	public void setGoods_optionb(String goods_optionb) {
		this.goods_optionb = goods_optionb;
	}

	
}

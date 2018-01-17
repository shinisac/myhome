package myhome.find;

public class goodsFindDTO {

	private int goods_idx;
	private String goods_imgpath;
	private String goods_name;
	private int goods_price;
	
	
	public goodsFindDTO() {
		super();
		
	}
	public goodsFindDTO(int goods_idx, String goods_imgpath, String goods_name, int goods_price) {
		super();
		this.goods_idx = goods_idx;
		this.goods_imgpath = goods_imgpath;
		this.goods_name = goods_name;
		this.goods_price = goods_price;
	}
	public int getGoods_idx() {
		return goods_idx;
	}
	public void setGoods_idx(int goods_idx) {
		this.goods_idx = goods_idx;
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
}

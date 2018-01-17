package myhome.category;

import java.sql.*;

public class CategoryDTO {
	
	private int category_goods_num;
	private String category_goods_imgpath;
	private String category_goods_name;
	
	public CategoryDTO() {
		super();
	}

	public CategoryDTO(int category_goods_num, String category_goods_imgpath, String category_goods_name) {
		super();
		this.category_goods_num = category_goods_num;
		this.category_goods_imgpath = category_goods_imgpath;
		this.category_goods_name = category_goods_name;
	}

	public int getCategory_goods_num() {
		return category_goods_num;
	}

	public void setCategory_goods_num(int category_goods_num) {
		this.category_goods_num = category_goods_num;
	}

	public String getCategory_goods_imgpath() {
		return category_goods_imgpath;
	}

	public void setCategory_goods_imgpath(String category_goods_imgpath) {
		this.category_goods_imgpath = category_goods_imgpath;
	}

	public String getCategory_goods_name() {
		return category_goods_name;
	}

	public void setCategory_goods_name(String category_goods_name) {
		this.category_goods_name = category_goods_name;
	}
	
	

}

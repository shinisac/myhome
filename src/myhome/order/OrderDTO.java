package myhome.order;

import java.sql.*;

public class OrderDTO {
	
	private int order_idx;
	private String order_state;
	private String order_member_id;
	private int order_goods_idx;
	private int order_amount;
	private int order_price;
	private String order_addr;
	private String order_shipstate;
	private String order_pay;
	private Timestamp order_date;
	private String order_imgpath;
	private String order_goods_name;
	private int order_goods_price;
	
	public OrderDTO() {
		// TODO Auto-generated constructor stub
	}

	public OrderDTO(int order_idx, String order_state, String order_member_id, int order_goods_idx, int order_amount,
			int order_price, String order_addr, String order_shipstate, String order_pay, Timestamp order_date,
			String order_imgpath, String order_goods_name, int order_goods_price) {
		super();
		this.order_idx = order_idx;
		this.order_state = order_state;
		this.order_member_id = order_member_id;
		this.order_goods_idx = order_goods_idx;
		this.order_amount = order_amount;
		this.order_price = order_price;
		this.order_addr = order_addr;
		this.order_shipstate = order_shipstate;
		this.order_pay = order_pay;
		this.order_date = order_date;
		this.order_imgpath = order_imgpath;
		this.order_goods_name = order_goods_name;
		this.order_goods_price = order_goods_price;
	}

	public int getOrder_idx() {
		return order_idx;
	}

	public void setOrder_idx(int order_idx) {
		this.order_idx = order_idx;
	}

	public String getOrder_state() {
		return order_state;
	}

	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}

	public String getOrder_member_id() {
		return order_member_id;
	}

	public void setOrder_member_id(String order_member_id) {
		this.order_member_id = order_member_id;
	}

	public int getOrder_goods_idx() {
		return order_goods_idx;
	}

	public void setOrder_goods_idx(int order_goods_idx) {
		this.order_goods_idx = order_goods_idx;
	}

	public int getOrder_amount() {
		return order_amount;
	}

	public void setOrder_amount(int order_amount) {
		this.order_amount = order_amount;
	}

	public int getOrder_price() {
		return order_price;
	}

	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}

	public String getOrder_addr() {
		return order_addr;
	}

	public void setOrder_addr(String order_addr) {
		this.order_addr = order_addr;
	}

	public String getOrder_shipstate() {
		return order_shipstate;
	}

	public void setOrder_shipstate(String order_shipstate) {
		this.order_shipstate = order_shipstate;
	}

	public String getOrder_pay() {
		return order_pay;
	}

	public void setOrder_pay(String order_pay) {
		this.order_pay = order_pay;
	}

	public Timestamp getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Timestamp order_date) {
		this.order_date = order_date;
	}

	public String getOrder_imgpath() {
		return order_imgpath;
	}

	public void setOrder_imgpath(String order_imgpath) {
		this.order_imgpath = order_imgpath;
	}

	public String getOrder_goods_name() {
		return order_goods_name;
	}

	public void setOrder_goods_name(String order_goods_name) {
		this.order_goods_name = order_goods_name;
	}

	public int getOrder_goods_price() {
		return order_goods_price;
	}

	public void setOrder_goods_price(int order_goods_price) {
		this.order_goods_price = order_goods_price;
	}
	
	
	
	
}

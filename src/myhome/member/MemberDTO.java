package myhome.member;

import java.sql.*;
import java.text.SimpleDateFormat;
public class MemberDTO {

	
	private int member_idx;
	private String member_state;
	private String member_level;
	private String member_id;
	private String member_pwd;
	private String member_name;
	private String member_birthday;
	private String member_gen;
	private String member_phone;
	private String member_email;
	private String member_addr;
	private Timestamp member_date;
	private Timestamp member_deldate;
	
	public MemberDTO() {
		
	}

	public MemberDTO(int member_idx, String member_state, String member_level, String member_id, String member_pwd,
			String member_name, String member_birthday, String member_gen, String member_phone, String member_email,
			String member_addr, Timestamp member_date, Timestamp member_deldate) {
		super();
		this.member_idx = member_idx;
		this.member_state = member_state;
		this.member_level = member_level;
		this.member_id = member_id;
		this.member_pwd = member_pwd;
		this.member_name = member_name;
		this.member_birthday = member_birthday;
		this.member_gen = member_gen;
		this.member_phone = member_phone;
		this.member_email = member_email;
		this.member_addr = member_addr;
		this.member_date = member_date;
		this.member_deldate = member_deldate;
	}

	public int getMember_idx() {
		return member_idx;
	}

	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}

	public String getMember_state() {
		return member_state;
	}

	public void setMember_state(String member_state) {
		this.member_state = member_state;
	}

	public String getMember_level() {
		return member_level;
	}

	public void setMember_level(String member_level) {
		this.member_level = member_level;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pwd() {
		return member_pwd;
	}

	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_birthday() {
		return member_birthday;
	}

	public void setMember_birthday(String member_birthday) {
		this.member_birthday = member_birthday;
	}

	public String getMember_gen() {
		return member_gen;
	}

	public void setMember_gen(String member_gen) {
		this.member_gen = member_gen;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public String getMember_addr() {
		return member_addr;
	}

	public void setMember_addr(String member_addr) {
		this.member_addr = member_addr;
	}

	public Timestamp getMember_date() {
		return member_date;
	}

	public void setMember_date(Timestamp member_date) {
		this.member_date = member_date;
	}

	public Timestamp getMember_deldate() {
		return member_deldate;
	}

	public void setMember_deldate(Timestamp member_deldate) {
		this.member_deldate = member_deldate;
	}


	

}


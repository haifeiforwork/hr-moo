package com.moorim.hr.admin.vo;

import java.util.List;

public class MemberVO {
	private List<MemberVO> memberVOList;
	
	private String user_id;
	private String user_password;
	private String emp_no;
	private String user_name;
	private String job_title;
	private String work_place;
	private String group_name;
	private String user_auth;
	private String use_yn;
	private String reg_id;
	private String reg_dt;
	private String mod_id;
	private String mod_dt;
	private String procType;
	private String ev_role_1;
	private String ev_role_2;
	private String ev_role_3;
	private String ev_role_4;
	private String ev_role_5;
	private int listIndex;
	public List<MemberVO> getMemberVOList() {
		return memberVOList;
	}
	public void setMemberVOList(List<MemberVO> vo) {
		memberVOList = vo;
	}

	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getJob_title() {
		return job_title;
	}
	public void setJob_title(String job_title) {
		this.job_title = job_title;
	}
	public String getWork_place() {
		return work_place;
	}
	public void setWork_place(String work_place) {
		this.work_place = work_place;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getUser_auth() {
		return user_auth;
	}
	public void setUser_auth(String user_auth) {
		this.user_auth = user_auth;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	public String getMod_dt() {
		return mod_dt;
	}
	public void setMod_dt(String mod_dt) {
		this.mod_dt = mod_dt;
	}
	public String getProcType() {
		return procType;
	}
	public void setProcType(String procType) {
		this.procType = procType;
	}
	public int getListIndex() {
		return listIndex;
	}
	public void setListIndex(int listIndex) {
		this.listIndex = listIndex;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getEv_role_1() {
		return ev_role_1;
	}
	public void setEv_role_1(String ev_role_1) {
		this.ev_role_1 = ev_role_1;
	}
	public String getev_role_2() {
		return ev_role_2;
	}
	public void setev_role_2(String ev_role_2) {
		this.ev_role_2 = ev_role_2;
	}
	public String getev_role_3() {
		return ev_role_3;
	}
	public void setev_role_3(String ev_role_3) {
		this.ev_role_3 = ev_role_3;
	}
	public String getev_role_4() {
		return ev_role_4;
	}
	public void setev_role_4(String ev_role_4) {
		this.ev_role_4 = ev_role_4;
	}
	public String getev_role_5() {
		return ev_role_5;
	}
	public void setev_role_5(String ev_role_5) {
		this.ev_role_5 = ev_role_5;
	}
	
	
}

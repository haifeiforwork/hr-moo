package com.moorim.hr.admin.vo;

import java.util.Arrays;
import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class AdminRecruitCareerVO {
	
	private int rIdx;
	private int rSeq;
	private String rCode1;
	private String rCode2;
	private String[] rCode3;


	private List<AdminRecruitCareerVO> careerList;

	public int getrSeq() {
		return rSeq;
	}


	public void setrSeq(int rSeq) {
		this.rSeq = rSeq;
	}


	public int getrIdx() {
		return rIdx;
	}


	public void setrIdx(int rIdx) {
		this.rIdx = rIdx;
	}


	public String getrCode1() {
		return rCode1;
	}


	public void setrCode1(String rCode1) {
		this.rCode1 = rCode1;
	}


	public String getrCode2() {
		return rCode2;
	}


	public void setrCode2(String rCode2) {
		this.rCode2 = rCode2;
	}


	public String[] getrCode3() {
		return rCode3;
	}


	public void setrCode3(String[] rCode3) {
		this.rCode3 = rCode3;
	}


	public List<AdminRecruitCareerVO> getCareerList() {
		return careerList;
	}


	public void setCareerList(List<AdminRecruitCareerVO> careerList) {
		this.careerList = careerList;
	}


	@Override
	public String toString() {
		return "AdminRecruitCareerVO [rIdx=" + rIdx + ", rSeq=" + rSeq + ", rCode1=" + rCode1 + ", rCode2=" + rCode2
				+ ", rCode3=" + Arrays.toString(rCode3) + ", careerList=" + careerList + "]";
	}



	
	
	
}

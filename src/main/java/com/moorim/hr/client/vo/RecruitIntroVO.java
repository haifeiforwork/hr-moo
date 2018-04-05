package com.moorim.hr.client.vo;

import java.util.List;

import javax.validation.Valid;

import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class RecruitIntroVO {

	private String rApCode;
	private int rIdx;
	private int iSeq;
	private String iCode;
	
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String iDesc;

	@Valid
	private List<RecruitIntroVO> introList;

	public String getrApCode() {
		return rApCode;
	}

	public void setrApCode(String rApCode) {
		this.rApCode = rApCode;
	}

	public int getrIdx() {
		return rIdx;
	}

	public void setrIdx(int rIdx) {
		this.rIdx = rIdx;
	}

	public int getiSeq() {
		return iSeq;
	}

	public void setiSeq(int iSeq) {
		this.iSeq = iSeq;
	}

	public String getiCode() {
		return iCode;
	}

	public void setiCode(String iCode) {
		this.iCode = iCode;
	}

	public String getiDesc() {
		return iDesc;
	}

	public void setiDesc(String iDesc) {
		this.iDesc = iDesc;
	}

	public List<RecruitIntroVO> getIntroList() {
		return introList;
	}

	public void setIntroList(List<RecruitIntroVO> introList) {
		this.introList = introList;
	}

	@Override
	public String toString() {
		return "RecruitIntroVO [rApCode=" + rApCode + ", rIdx=" + rIdx + ", iSeq=" + iSeq + ", iCode=" + iCode
				+ ", iDesc=" + iDesc + "]";
	}

}

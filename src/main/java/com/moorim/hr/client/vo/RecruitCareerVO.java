package com.moorim.hr.client.vo;

import java.util.List;

import javax.validation.Valid;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class RecruitCareerVO {

	private String rApCode;
	private int rIdx;
	private int cSeq;
	
	@Length(max=100)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String cName;
	
	@Length(max=20)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String cPart;
	
	@Length(max=10)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String cIncome;
	
	@Length(max=20)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String cPosition;
	
	@Length(max=100)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String cWork;
	
	@Length(max=6)
	private String cSmonth;
	
	@Length(max=6)
	private String cEmonth;
	
	@Length(max=1000)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String cPerform;
	private String cType;
	private String cRelYn;
	
	@Length(max=1000)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String cReason;

	@Valid
	private List<RecruitCareerVO> careerList;

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

	public int getcSeq() {
		return cSeq;
	}

	public void setcSeq(int cSeq) {
		this.cSeq = cSeq;
	}

	public String getcName() {
		return cName;
	}

	public void setcName(String cName) {
		this.cName = cName;
	}

	public String getcPart() {
		return cPart;
	}

	public void setcPart(String cPart) {
		this.cPart = cPart;
	}

	public String getcIncome() {
		return cIncome;
	}

	public void setcIncome(String cIncome) {
		this.cIncome = cIncome;
	}

	public String getcPosition() {
		return cPosition;
	}

	public void setcPosition(String cPosition) {
		this.cPosition = cPosition;
	}

	public String getcWork() {
		return cWork;
	}

	public void setcWork(String cWork) {
		this.cWork = cWork;
	}

	public String getcSmonth() {
		return cSmonth;
	}

	public void setcSmonth(String cSmonth) {
		this.cSmonth = cSmonth;
	}

	public String getcEmonth() {
		return cEmonth;
	}

	public void setcEmonth(String cEmonth) {
		this.cEmonth = cEmonth;
	}

	public String getcPerform() {
		return cPerform;
	}

	public void setcPerform(String cPerform) {
		this.cPerform = cPerform;
	}

	public String getcType() {
		return cType;
	}

	public void setcType(String cType) {
		this.cType = cType;
	}

	public String getcRelYn() {
		return cRelYn;
	}

	public void setcRelYn(String cRelYn) {
		this.cRelYn = cRelYn;
	}

	public String getcReason() {
		return cReason;
	}

	public void setcReason(String cReason) {
		this.cReason = cReason;
	}

	public List<RecruitCareerVO> getCareerList() {
		return careerList;
	}

	public void setCareerList(List<RecruitCareerVO> careerList) {
		this.careerList = careerList;
	}

	@Override
	public String toString() {
		return "RecruitCareer [rApCode=" + rApCode + ", rIdx=" + rIdx + ", cSeq=" + cSeq + ", cName=" + cName
				+ ", cPart=" + cPart + ", cIncome=" + cIncome + ", cPosition=" + cPosition + ", cWork=" + cWork
				+ ", cSmonth=" + cSmonth + ", cEmonth=" + cEmonth + ", cPerform=" + cPerform + ", cType=" + cType
				+ ", cRelYn=" + cRelYn + ", cReason=" + cReason + "]";
	}

}

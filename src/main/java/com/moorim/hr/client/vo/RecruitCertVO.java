package com.moorim.hr.client.vo;

import java.util.List;

import javax.validation.Valid;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class RecruitCertVO {

	private String rApCode;
	private int rIdx;
	private int cSeq;
	
	@Length(max=100)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String cName;
	private String cCode;
	private String cGrade;
	
	@Length(max=8)
	private String cEdate;
	
	@Length(max=100)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String cInstit;

	@Valid
	private List<RecruitCertVO> certList;

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

	public String getcCode() {
		return cCode;
	}

	public void setcCode(String cCode) {
		this.cCode = cCode;
	}

	public String getcGrade() {
		return cGrade;
	}

	public void setcGrade(String cGrade) {
		this.cGrade = cGrade;
	}

	public String getcEdate() {
		return cEdate;
	}

	public void setcEdate(String cEdate) {
		this.cEdate = cEdate;
	}

	public String getcInstit() {
		return cInstit;
	}

	public void setcInstit(String cInstit) {
		this.cInstit = cInstit;
	}

	public List<RecruitCertVO> getCertList() {
		return certList;
	}

	public void setCertList(List<RecruitCertVO> certList) {
		this.certList = certList;
	}

	@Override
	public String toString() {
		return "RecruitCert [rApCode=" + rApCode + ", rIdx=" + rIdx + ", cSeq=" + cSeq + ", cName=" + cName + ", cCode="
				+ cCode + ", cGrade=" + cGrade + ", cEdate=" + cEdate + ", cInstit=" + cInstit + "]";
	}

}

package com.moorim.hr.client.vo;

import java.util.List;

import javax.validation.Valid;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class RecruitSchoolVO {
	
	private String rApCode;
	private int rIdx;
	private int sIdx;

	@Length(max = 50)
	private String sName;

	private String sTypeCode;
	private String sDnCode;

	@Length(max = 1)
	private String sBpCode;

	@Length(max = 20)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String sMajor;
	
	private String sMajorCode;
	private String sMajorGroup;

	@Length(max = 20)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String sMajorDetail;

	@Length(max = 20)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String sMinor;
	
	private String sMinorCode;
	private String sMinorGroup;

	@Length(max = 20)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String sDual;
	
	private String sDualCode;
	private String sDualGroup;

	@Length(max = 6)
	private String sEntMonth;

	@Length(max = 6)
	private String sGraMonth;

	private String sGraType;
	
	@Valid
	private List<RecruitSchoolVO> schoolList;

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

	public int getsIdx() {
		return sIdx;
	}

	public void setsIdx(int sIdx) {
		this.sIdx = sIdx;
	}

	public String getsName() {
		return sName;
	}

	public void setsName(String sName) {
		this.sName = sName;
	}

	public String getsTypeCode() {
		return sTypeCode;
	}

	public void setsTypeCode(String sTypeCode) {
		this.sTypeCode = sTypeCode;
	}

	public String getsDnCode() {
		return sDnCode;
	}

	public void setsDnCode(String sDnCode) {
		this.sDnCode = sDnCode;
	}

	public String getsBpCode() {
		return sBpCode;
	}

	public void setsBpCode(String sBpCode) {
		this.sBpCode = sBpCode;
	}

	public String getsMajor() {
		return sMajor;
	}

	public void setsMajor(String sMajor) {
		this.sMajor = sMajor;
	}

	public String getsMajorCode() {
		return sMajorCode;
	}

	public void setsMajorCode(String sMajorCode) {
		this.sMajorCode = sMajorCode;
	}

	public String getsMajorGroup() {
		return sMajorGroup;
	}

	public void setsMajorGroup(String sMajorGroup) {
		this.sMajorGroup = sMajorGroup;
	}

	public String getsMajorDetail() {
		return sMajorDetail;
	}

	public void setsMajorDetail(String sMajorDetail) {
		this.sMajorDetail = sMajorDetail;
	}

	public String getsMinor() {
		return sMinor;
	}

	public void setsMinor(String sMinor) {
		this.sMinor = sMinor;
	}

	public String getsMinorCode() {
		return sMinorCode;
	}

	public void setsMinorCode(String sMinorCode) {
		this.sMinorCode = sMinorCode;
	}

	public String getsMinorGroup() {
		return sMinorGroup;
	}

	public void setsMinorGroup(String sMinorGroup) {
		this.sMinorGroup = sMinorGroup;
	}

	public String getsDual() {
		return sDual;
	}

	public void setsDual(String sDual) {
		this.sDual = sDual;
	}

	public String getsDualCode() {
		return sDualCode;
	}

	public void setsDualCode(String sDualCode) {
		this.sDualCode = sDualCode;
	}

	public String getsDualGroup() {
		return sDualGroup;
	}

	public void setsDualGroup(String sDualGroup) {
		this.sDualGroup = sDualGroup;
	}

	public String getsEntMonth() {
		return sEntMonth;
	}

	public void setsEntMonth(String sEntMonth) {
		this.sEntMonth = sEntMonth;
	}

	public String getsGraMonth() {
		return sGraMonth;
	}

	public void setsGraMonth(String sGraMonth) {
		this.sGraMonth = sGraMonth;
	}

	public String getsGraType() {
		return sGraType;
	}

	public void setsGraType(String sGraType) {
		this.sGraType = sGraType;
	}

	public List<RecruitSchoolVO> getSchoolList() {
		return schoolList;
	}

	public void setSchoolList(List<RecruitSchoolVO> schoolList) {
		this.schoolList = schoolList;
	}

	@Override
	public String toString() {
		return "RecruitSchoolVO [rApCode=" + rApCode + ", rIdx=" + rIdx + ", sIdx=" + sIdx + ", sName=" + sName
				+ ", sTypeCode=" + sTypeCode + ", sDnCode=" + sDnCode + ", sBpCode="
				+ sBpCode + ", sMajor=" + sMajor + ", sMajorCode=" + sMajorCode + ", sMajorGroup=" + sMajorGroup
				+ ", sMajorDetail=" + sMajorDetail + ", sMinor=" + sMinor + ", sMinorCode=" + sMinorCode
				+ ", sMinorGroup=" + sMinorGroup + ", sDual=" + sDual + ", sDualCode=" + sDualCode + ", sDualGroup="
				+ sDualGroup + ", sEntMonth=" + sEntMonth + ", sGraMonth=" + sGraMonth + ", sGraType=" + sGraType + "]";
	}

}

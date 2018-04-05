package com.moorim.hr.client.vo;

import java.util.List;

import javax.validation.Valid;

import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class RecruitGradeVO {
	
	private String rApCode;
	private int rIdx;
	private int sIdx;
	private String sTypeCode;
	private String sScore11;
	private String sScore12;
	private String sScore21;
	private String sScore22;
	private String sScore31;
	private String sScore32;
	private String sScore41;
	private String sScore42;
	private String sScore51;
	private String sScore52;
	private String sScore61;
	private String sScore62;
	private String sScoreAvg;
	private String sScoreFull;
	private String sScoreFinal;

	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String sThesis1;
	private String sThesis1File;
	
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String sThesis2;
	private String sThesis2File;
	
	@Valid
	private List<RecruitGradeVO> gradeList;

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

	public String getsTypeCode() {
		return sTypeCode;
	}

	public void setsTypeCode(String sTypeCode) {
		this.sTypeCode = sTypeCode;
	}

	public String getsScore11() {
		return sScore11;
	}

	public void setsScore11(String sScore11) {
		this.sScore11 = sScore11;
	}

	public String getsScore12() {
		return sScore12;
	}

	public void setsScore12(String sScore12) {
		this.sScore12 = sScore12;
	}

	public String getsScore21() {
		return sScore21;
	}

	public void setsScore21(String sScore21) {
		this.sScore21 = sScore21;
	}

	public String getsScore22() {
		return sScore22;
	}

	public void setsScore22(String sScore22) {
		this.sScore22 = sScore22;
	}

	public String getsScore31() {
		return sScore31;
	}

	public void setsScore31(String sScore31) {
		this.sScore31 = sScore31;
	}

	public String getsScore32() {
		return sScore32;
	}

	public void setsScore32(String sScore32) {
		this.sScore32 = sScore32;
	}

	public String getsScore41() {
		return sScore41;
	}

	public void setsScore41(String sScore41) {
		this.sScore41 = sScore41;
	}

	public String getsScore42() {
		return sScore42;
	}

	public void setsScore42(String sScore42) {
		this.sScore42 = sScore42;
	}

	public String getsScore51() {
		return sScore51;
	}

	public void setsScore51(String sScore51) {
		this.sScore51 = sScore51;
	}

	public String getsScore52() {
		return sScore52;
	}

	public void setsScore52(String sScore52) {
		this.sScore52 = sScore52;
	}

	public String getsScore61() {
		return sScore61;
	}

	public void setsScore61(String sScore61) {
		this.sScore61 = sScore61;
	}

	public String getsScore62() {
		return sScore62;
	}

	public void setsScore62(String sScore62) {
		this.sScore62 = sScore62;
	}

	public String getsScoreAvg() {
		return sScoreAvg;
	}

	public void setsScoreAvg(String sScoreAvg) {
		this.sScoreAvg = sScoreAvg;
	}

	public String getsScoreFull() {
		return sScoreFull;
	}

	public void setsScoreFull(String sScoreFull) {
		this.sScoreFull = sScoreFull;
	}

	public String getsScoreFinal() {
		return sScoreFinal;
	}

	public void setsScoreFinal(String sScoreFinal) {
		this.sScoreFinal = sScoreFinal;
	}

	public String getsThesis1() {
		return sThesis1;
	}

	public void setsThesis1(String sThesis1) {
		this.sThesis1 = sThesis1;
	}

	public String getsThesis1File() {
		return sThesis1File;
	}

	public void setsThesis1File(String sThesis1File) {
		this.sThesis1File = sThesis1File;
	}

	public String getsThesis2() {
		return sThesis2;
	}

	public void setsThesis2(String sThesis2) {
		this.sThesis2 = sThesis2;
	}

	public String getsThesis2File() {
		return sThesis2File;
	}

	public void setsThesis2File(String sThesis2File) {
		this.sThesis2File = sThesis2File;
	}

	public List<RecruitGradeVO> getGradeList() {
		return gradeList;
	}

	public void setGradeList(List<RecruitGradeVO> gradeList) {
		this.gradeList = gradeList;
	}

	@Override
	public String toString() {
		return "RecruitGradeVO [rApCode=" + rApCode + ", rIdx=" + rIdx + ", sIdx=" + sIdx + ", sTypeCode=" + sTypeCode
				+ ", sScore11=" + sScore11 + ", sScore12=" + sScore12 + ", sScore21=" + sScore21 + ", sScore22="
				+ sScore22 + ", sScore31=" + sScore31 + ", sScore32=" + sScore32 + ", sScore41=" + sScore41
				+ ", sScore42=" + sScore42 + ", sScore51=" + sScore51 + ", sScore52=" + sScore52 + ", sScore61="
				+ sScore61 + ", sScore62=" + sScore62 + ", sScoreAvg=" + sScoreAvg + ", sScoreFull=" + sScoreFull
				+ ", sScoreFinal=" + sScoreFinal + ", sThesis1=" + sThesis1 + ", sThesis1File=" + sThesis1File
				+ ", sThesis2=" + sThesis2 + ", sThesis2File=" + sThesis2File + "]";
	}

}

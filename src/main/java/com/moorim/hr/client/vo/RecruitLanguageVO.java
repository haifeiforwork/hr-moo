package com.moorim.hr.client.vo;

import java.util.List;

import javax.validation.Valid;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class RecruitLanguageVO {

	private String rApCode;
	private int rIdx;
	private int lSeq;
	private String lLanguage;
	private String lExam;
	
	@Length(max=10)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String lScore;
	
	private String lGrade;
	
	@Length(max=8)
	private String lEdate;
	
	@Length(max=100)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String lInstit;

	@Valid
	private List<RecruitLanguageVO> languageList;

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

	public int getlSeq() {
		return lSeq;
	}

	public void setlSeq(int lSeq) {
		this.lSeq = lSeq;
	}

	public String getlLanguage() {
		return lLanguage;
	}

	public void setlLanguage(String lLanguage) {
		this.lLanguage = lLanguage;
	}

	public String getlExam() {
		return lExam;
	}

	public void setlExam(String lExam) {
		this.lExam = lExam;
	}

	public String getlScore() {
		return lScore;
	}

	public void setlScore(String lScore) {
		this.lScore = lScore;
	}

	public String getlGrade() {
		return lGrade;
	}

	public void setlGrade(String lGrade) {
		this.lGrade = lGrade;
	}

	public String getlEdate() {
		return lEdate;
	}

	public void setlEdate(String lEdate) {
		this.lEdate = lEdate;
	}

	public String getlInstit() {
		return lInstit;
	}

	public void setlInstit(String lInstit) {
		this.lInstit = lInstit;
	}

	public List<RecruitLanguageVO> getLanguageList() {
		return languageList;
	}

	public void setLanguageList(List<RecruitLanguageVO> languageList) {
		this.languageList = languageList;
	}

	@Override
	public String toString() {
		return "RecruitLanguage [rApCode=" + rApCode + ", rIdx=" + rIdx + ", lSeq=" + lSeq + ", lLanguage=" + lLanguage
				+ ", lExam=" + lExam + ", lScore=" + lScore + ", lGrade=" + lGrade + ", lEdate=" + lEdate + ", lInstit="
				+ lInstit + "]";
	}

}

package com.moorim.hr.client.vo;

import java.util.List;

import javax.validation.Valid;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class RecruitTrainingVO {

	private String rApCode;
	private int rIdx;
	private int tSeq;
	private String tGubunCode;
	private String tNatCode;
	
	@Length(max=100)
	@SafeHtml(whitelistType=WhiteListType.NONE, message="HTML 태그를 사용할 수 없습니다.")
	private String tInstitution;
	
	@Length(max=8)
	private String tSdate;
	
	@Length(max=8)
	private String tEdate;
	
	private String tTerm;

	@Valid
	private List<RecruitTrainingVO> trainingList;

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

	public int gettSeq() {
		return tSeq;
	}

	public void settSeq(int tSeq) {
		this.tSeq = tSeq;
	}

	public String gettGubunCode() {
		return tGubunCode;
	}

	public void settGubunCode(String tGubunCode) {
		this.tGubunCode = tGubunCode;
	}

	public String gettNatCode() {
		return tNatCode;
	}

	public void settNatCode(String tNatCode) {
		this.tNatCode = tNatCode;
	}

	public String gettInstitution() {
		return tInstitution;
	}

	public void settInstitution(String tInstitution) {
		this.tInstitution = tInstitution;
	}

	public String gettSdate() {
		return tSdate;
	}

	public void settSdate(String tSdate) {
		this.tSdate = tSdate;
	}

	public String gettEdate() {
		return tEdate;
	}

	public void settEdate(String tEdate) {
		this.tEdate = tEdate;
	}

	public String gettTerm() {
		return tTerm;
	}

	public void settTerm(String tTerm) {
		this.tTerm = tTerm;
	}

	public List<RecruitTrainingVO> getTrainingList() {
		return trainingList;
	}

	public void setTrainingList(List<RecruitTrainingVO> trainingList) {
		this.trainingList = trainingList;
	}

	@Override
	public String toString() {
		return "RecruitTraining [rApCode=" + rApCode + ", rIdx=" + rIdx + ", tSeq=" + tSeq + ", tGubunCode="
				+ tGubunCode + ", tNatCode=" + tNatCode + ", tInstitution=" + tInstitution + ", tSdate=" + tSdate
				+ ", tEdate=" + tEdate + ", tTerm=" + tTerm + "]";
	}

}

package com.moorim.hr.admin.vo;

import java.util.Arrays;
import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class AdminItemInterviewVO {
	
	private String IDX               ;
	private String E_STEP_CODE       ;
	private String Q_CODE            ;
	private String Q_INTRO           ;
	private String Q_DTL             ;
	private String idx               ;
	private String eStepCode         ;
	private String qCode             ;
	private String qIntro            ;
	private String qDtl              ;
	
	
	private String procType;
	
	private List<AdminItemInterviewVO> interviewList;

	public String getIDX() {
		return IDX;
	}

	public void setIDX(String iDX) {
		IDX = iDX;
	}

	public String getE_STEP_CODE() {
		return E_STEP_CODE;
	}

	public void setE_STEP_CODE(String e_STEP_CODE) {
		E_STEP_CODE = e_STEP_CODE;
	}

	public String getQ_CODE() {
		return Q_CODE;
	}

	public void setQ_CODE(String q_CODE) {
		Q_CODE = q_CODE;
	}

	public String getQ_INTRO() {
		return Q_INTRO;
	}

	public void setQ_INTRO(String q_INTRO) {
		Q_INTRO = q_INTRO;
	}

	public String getQ_DTL() {
		return Q_DTL;
	}

	public void setQ_DTL(String q_DTL) {
		Q_DTL = q_DTL;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String geteStepCode() {
		return eStepCode;
	}

	public void seteStepCode(String eStepCode) {
		this.eStepCode = eStepCode;
	}

	public String getqCode() {
		return qCode;
	}

	public void setqCode(String qCode) {
		this.qCode = qCode;
	}

	public String getqIntro() {
		return qIntro;
	}

	public void setqIntro(String qIntro) {
		this.qIntro = qIntro;
	}

	public String getqDtl() {
		return qDtl;
	}

	public void setqDtl(String qDtl) {
		this.qDtl = qDtl;
	}

	public String getProcType() {
		return procType;
	}

	public void setProcType(String procType) {
		this.procType = procType;
	}

	public List<AdminItemInterviewVO> getInterviewList() {
		return interviewList;
	}

	public void setInterviewList(List<AdminItemInterviewVO> interviewList) {
		this.interviewList = interviewList;
	}


	
}

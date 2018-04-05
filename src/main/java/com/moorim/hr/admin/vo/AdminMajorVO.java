package com.moorim.hr.admin.vo;

import java.util.Arrays;
import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class AdminMajorVO {
	
	
	private String M_CODE       ;
	private String M_NAME       ;
	private String M_GUBUN      ;
	private String M_CATEGORY   ;
	private String mCode        ;
	private String mName        ;
	private String mGubun       ;
	private String mCategory    ;
	
	private String procType;
	
	private List<AdminMajorVO> majorList;

	public String getM_CODE() {
		return M_CODE;
	}

	public void setM_CODE(String m_CODE) {
		M_CODE = m_CODE;
	}

	public String getM_NAME() {
		return M_NAME;
	}

	public void setM_NAME(String m_NAME) {
		M_NAME = m_NAME;
	}

	public String getM_GUBUN() {
		return M_GUBUN;
	}

	public void setM_GUBUN(String m_GUBUN) {
		M_GUBUN = m_GUBUN;
	}

	public String getM_CATEGORY() {
		return M_CATEGORY;
	}

	public void setM_CATEGORY(String m_CATEGORY) {
		M_CATEGORY = m_CATEGORY;
	}

	public String getmCode() {
		return mCode;
	}

	public void setmCode(String mCode) {
		this.mCode = mCode;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getmGubun() {
		return mGubun;
	}

	public void setmGubun(String mGubun) {
		this.mGubun = mGubun;
	}

	public String getmCategory() {
		return mCategory;
	}

	public void setmCategory(String mCategory) {
		this.mCategory = mCategory;
	}

	public String getProcType() {
		return procType;
	}

	public void setProcType(String procType) {
		this.procType = procType;
	}

	public List<AdminMajorVO> getMajorList() {
		return majorList;
	}

	public void setMajorList(List<AdminMajorVO> majorList) {
		this.majorList = majorList;
	}
	
	
	
	
	
	
}

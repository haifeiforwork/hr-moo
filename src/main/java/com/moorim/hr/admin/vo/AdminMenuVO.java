package com.moorim.hr.admin.vo;

import java.util.List;

public class AdminMenuVO {
	
	private String CAT_CODE         ;
	private String CAT_CODE_NM         ;
	private String CAR_AUTH_YN      ;
	private String ADM_AUTH_YN      ;
	private String DISPLAY_YN       ;
	private String catCode          ;
	private String catNm          ;
	private String carAuthYn        ;
	private String admAuthYn        ;
	private String displayYn        ;
	
	private String editType        ;
	
	
	List<AdminMenuVO> adminMenuList;
	
	
	public String getCatNm() {
		return catNm;
	}
	public void setCatNm(String catNm) {
		this.catNm = catNm;
	}
	public String getCAT_CODE() {
		return CAT_CODE;
	}
	public void setCAT_CODE(String cAT_CODE) {
		CAT_CODE = cAT_CODE;
	}
	public String getCAR_AUTH_YN() {
		return CAR_AUTH_YN;
	}
	public void setCAR_AUTH_YN(String cAR_AUTH_YN) {
		CAR_AUTH_YN = cAR_AUTH_YN;
	}
	public String getADM_AUTH_YN() {
		return ADM_AUTH_YN;
	}
	public void setADM_AUTH_YN(String aDM_AUTH_YN) {
		ADM_AUTH_YN = aDM_AUTH_YN;
	}
	public String getDISPLAY_YN() {
		return DISPLAY_YN;
	}
	public void setDISPLAY_YN(String dISPLAY_YN) {
		DISPLAY_YN = dISPLAY_YN;
	}
	public String getCatCode() {
		return catCode;
	}
	public void setCatCode(String catCode) {
		this.catCode = catCode;
	}
	public String getCarAuthYn() {
		return carAuthYn;
	}
	public void setCarAuthYn(String carAuthYn) {
		this.carAuthYn = carAuthYn;
	}
	public String getAdmAuthYn() {
		return admAuthYn;
	}
	public void setAdmAuthYn(String admAuthYn) {
		this.admAuthYn = admAuthYn;
	}
	public String getDisplayYn() {
		return displayYn;
	}
	public void setDisplayYn(String displayYn) {
		this.displayYn = displayYn;
	}
	public String getCAT_CODE_NM() {
		return CAT_CODE_NM;
	}
	public void setCAT_CODE_NM(String cAT_CODE_NM) {
		CAT_CODE_NM = cAT_CODE_NM;
	}
	public List<AdminMenuVO> getAdminMenuList() {
		return adminMenuList;
	}
	public void setAdminMenuList(List<AdminMenuVO> adminMenuList) {
		this.adminMenuList = adminMenuList;
	}
	public String getEditType() {
		return editType;
	}
	public void setEditType(String editType) {
		this.editType = editType;
	}
}

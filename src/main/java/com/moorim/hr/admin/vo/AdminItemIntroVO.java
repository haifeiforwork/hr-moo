package com.moorim.hr.admin.vo;

import java.util.Arrays;
import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class AdminItemIntroVO {
	
	private String idx ;
	private String itemCat ;
	private String itemTitle ;
	private String itemDesc ;
	private String priorNew ;
	private String priorCareer ;
	private String lengthMin ;
	private String lengthMax ;
	private String regId ;
	private String regDt ;
	
	
	private String procType;
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getItemCat() {
		return itemCat;
	}
	public void setItemCat(String itemCat) {
		this.itemCat = itemCat;
	}
	public String getItemTitle() {
		return itemTitle;
	}
	public void setItemTitle(String itemTitle) {
		this.itemTitle = itemTitle;
	}
	public String getItemDesc() {
		return itemDesc;
	}
	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}
	public String getPriorNew() {
		return priorNew;
	}
	public void setPriorNew(String priorNew) {
		this.priorNew = priorNew;
	}
	public String getPriorCareer() {
		return priorCareer;
	}
	public void setPriorCareer(String priorCareer) {
		this.priorCareer = priorCareer;
	}
	public String getLengthMin() {
		return lengthMin;
	}
	public void setLengthMin(String lengthMin) {
		this.lengthMin = lengthMin;
	}
	public String getLengthMax() {
		return lengthMax;
	}
	public void setLengthMax(String lengthMax) {
		this.lengthMax = lengthMax;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getProcType() {
		return procType;
	}
	public void setProcType(String procType) {
		this.procType = procType;
	}
	
	
	
}

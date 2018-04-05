package com.moorim.hr.admin.vo;

import java.util.Arrays;
import java.util.List;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.SafeHtml;
import org.hibernate.validator.constraints.SafeHtml.WhiteListType;

public class AdminEvalItemVO {
		
	private String IDX           ;
	private String E_STEP_CODE   ;
	private String ITEM_INDEX        ;
	private String E_ITEM        ;
	private String E_CONTENT     ;
	
	private String idx         ;
	private String eStepCode   ;
	private String itemIndex       ;
	private String eItem       ;
	private String eContent    ;
	
	private String procType;
	
	private List<AdminEvalItemVO> itemList;

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

	public String getITEM_INDEX() {
		return ITEM_INDEX;
	}

	public void setITEM_INDEX(String iTEM_INDEX) {
		ITEM_INDEX = iTEM_INDEX;
	}

	public String getE_ITEM() {
		return E_ITEM;
	}

	public void setE_ITEM(String e_ITEM) {
		E_ITEM = e_ITEM;
	}

	public String getE_CONTENT() {
		return E_CONTENT;
	}

	public void setE_CONTENT(String e_CONTENT) {
		E_CONTENT = e_CONTENT;
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

	public String getItemIndex() {
		return itemIndex;
	}

	public void setItemIndex(String itemIndex) {
		this.itemIndex = itemIndex;
	}

	public String geteItem() {
		return eItem;
	}

	public void seteItem(String eItem) {
		this.eItem = eItem;
	}

	public String geteContent() {
		return eContent;
	}

	public void seteContent(String eContent) {
		this.eContent = eContent;
	}

	public String getProcType() {
		return procType;
	}

	public void setProcType(String procType) {
		this.procType = procType;
	}

	public List<AdminEvalItemVO> getItemList() {
		return itemList;
	}

	public void setItemList(List<AdminEvalItemVO> itemList) {
		this.itemList = itemList;
	}

	
	
}

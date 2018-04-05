package com.moorim.hr.common.vo;


public class PagingCommonVO {
	
	private int pageNo = 1;
	private int rows = 10;
	private int pageSize = 5;
	private int totcnt;
	private int firstIndex = 0;
	private int lastIndex = 0;
	
	private String idx;

	
	private String searchType;
	private String gubunType1;
	private String gubunType2;
	private String gubunType3;
	private String gubunType4;
	private String gubunType5;
	private String procType;
	private String REG_DATE;
	private String MOD_DATA;
	private String SKEY_1;
	private String SKEY_2;
	private String SKEY_3;
	private String SKEY_4;
	private String SKEY_5;
	private String SKEY_6;
	private String SKEY_7;
	private String SKEY_8;
	private String SKEY_9;
	private String SKEY_10;
	
	/*easy ui*/
	private String sort;
	private String order;
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String pIdx) {
		idx = pIdx;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotcnt() {
		return totcnt;
	}
	public void setTotcnt(int totcnt) {
		this.totcnt = totcnt;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	
	public String getGubunType1() {
		return gubunType1;
	}
	public void setGubunType1(String gubunType1) {
		this.gubunType1 = gubunType1;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String pSearchType) {
		searchType = pSearchType;
	}

	public String getProcType() {
		return procType;
	}
	public void setProcType(String pProcType) {
		procType = pProcType;
	}
	
	public String getREG_DATE() {
		return REG_DATE;
	}
	public void setREG_DATE(String rEG_DATE) {
		REG_DATE = rEG_DATE;
	}
	public String getMDFY_DATE() {
		return MOD_DATA;
	}
	public void setMDFY_DATE(String mDFY_DATE) {
		MOD_DATA = mDFY_DATE;
	}
	public String getSKEY_1() {
		return SKEY_1;
	}
	public void setSKEY_1(String sKEY_1) {
		SKEY_1 = sKEY_1;
	}
	public String getSKEY_2() {
		return SKEY_2;
	}
	public void setSKEY_2(String sKEY_2) {
		SKEY_2 = sKEY_2;
	}
	public String getSKEY_3() {
		return SKEY_3;
	}
	public void setSKEY_3(String sKEY_3) {
		SKEY_3 = sKEY_3;
	}
	public String getSKEY_4() {
		return SKEY_4;
	}
	public void setSKEY_4(String sKEY_4) {
		SKEY_4 = sKEY_4;
	}
	public String getSKEY_5() {
		return SKEY_5;
	}
	public void setSKEY_5(String sKEY_5) {
		SKEY_5 = sKEY_5;
	}
	public String getSKEY_6() {
		return SKEY_6;
	}
	public void setSKEY_6(String sKEY_6) {
		SKEY_6 = sKEY_6;
	}
	public String getSKEY_7() {
		return SKEY_7;
	}
	public void setSKEY_7(String sKEY_7) {
		SKEY_7 = sKEY_7;
	}
	public String getSKEY_8() {
		return SKEY_8;
	}
	public void setSKEY_8(String sKEY_8) {
		SKEY_8 = sKEY_8;
	}
	public String getSKEY_9() {
		return SKEY_9;
	}
	public void setSKEY_9(String sKEY_9) {
		SKEY_9 = sKEY_9;
	}
	public String getSKEY_10() {
		return SKEY_10;
	}
	public void setSKEY_10(String sKEY_10) {
		SKEY_10 = sKEY_10;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getGubunType2() {
		return gubunType2;
	}
	public void setGubunType2(String gubunType2) {
		this.gubunType2 = gubunType2;
	}
	public String getGubunType3() {
		return gubunType3;
	}
	public void setGubunType3(String gubunType3) {
		this.gubunType3 = gubunType3;
	}
	public String getGubunType4() {
		return gubunType4;
	}
	public void setGubunType4(String gubunType4) {
		this.gubunType4 = gubunType4;
	}
	public String getGubunType5() {
		return gubunType5;
	}
	public void setGubunType5(String gubunType5) {
		this.gubunType5 = gubunType5;
	}
	
}

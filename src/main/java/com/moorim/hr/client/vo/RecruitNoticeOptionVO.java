package com.moorim.hr.client.vo;

public class RecruitNoticeOptionVO {

	private int idx;
	private int rIdx;
	private String rCode1;
	private String rCode2;
	private String rCode3;

	private String depth;

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getrIdx() {
		return rIdx;
	}

	public void setrIdx(int rIdx) {
		this.rIdx = rIdx;
	}

	public String getrCode1() {
		return rCode1;
	}

	public void setrCode1(String rCode1) {
		this.rCode1 = rCode1;
	}

	public String getrCode2() {
		return rCode2;
	}

	public void setrCode2(String rCode2) {
		this.rCode2 = rCode2;
	}

	public String getrCode3() {
		return rCode3;
	}

	public void setrCode3(String rCode3) {
		this.rCode3 = rCode3;
	}

	public String getDepth() {
		return depth;
	}

	public void setDepth(String depth) {
		this.depth = depth;
	}

	@Override
	public String toString() {
		return "RecruitNoticeOptionVO [idx=" + idx + ", rIdx=" + rIdx + ", rCode1=" + rCode1 + ", rCode2=" + rCode2
				+ ", rCode3=" + rCode3 + ", depth=" + depth + "]";
	}

}

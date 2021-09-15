package com.icia.itsmyplace.model;

import java.io.Serializable;

public class ReviewPht implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long rsrvSeq;
	private long phtNum;
	private String phtName; 
	private String phtOrgName;
	private long phtSize;
	private String phtExt;
	private String regDate;
	
	private short phtNumForUpdate;
	
	
	public ReviewPht()
	{
		rsrvSeq = 0;
		phtNum = 0;
		phtName = "";
		phtOrgName = "";
		phtSize = 0;
		phtExt = "";
		regDate = "";
		
		phtNumForUpdate = 0;
	}


	public long getRsrvSeq() {
		return rsrvSeq;
	}

	
	public long getPhtNum() {
		return phtNum;
	}


	public String getPhtOrgName() {
		return phtOrgName;
	}


	public long getPhtSize() {
		return phtSize;
	}


	public String getPhtExt() {
		return phtExt;
	}


	public String getRegDate() {
		return regDate;
	}


	public void setRsrvSeq(long rsrvSeq) {
		this.rsrvSeq = rsrvSeq;
	}


	public void setPhtNum(long phtNum) {
		this.phtNum = phtNum;
	}


	public void setPhtOrgName(String phtOrgName) {
		this.phtOrgName = phtOrgName;
	}


	public void setPhtSize(long phtSize) {
		this.phtSize = phtSize;
	}


	public void setPhtExt(String phtExt) {
		this.phtExt = phtExt;
	}


	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}


	public String getPhtName() {
		return phtName;
	}


	public void setPhtName(String phtName) {
		this.phtName = phtName;
	}


	public short getPhtNumForUpdate() {
		return phtNumForUpdate;
	}


	public void setPhtNumForUpdate(short phtNumForUpdate) {
		this.phtNumForUpdate = phtNumForUpdate;
	}

}
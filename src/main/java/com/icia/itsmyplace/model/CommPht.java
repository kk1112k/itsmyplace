package com.icia.itsmyplace.model;

import java.io.Serializable;

public class CommPht implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long bbsSeq;
	private short phtNum;
	private String phtName;
	private String phtOrgName;
	private long phtSize;
	private String phtExt;
	private String regDate;
	private String adminPublic;
	
	private short phtNumForUpdate;
	
	public CommPht() {
		bbsSeq = 0;
		phtNum = 0;
		phtName = "";
		phtOrgName = "";
		phtSize = 0;
		phtExt = "";
		regDate = "";
		adminPublic = "";
		phtNumForUpdate = 0;
	}

	public long getBbsSeq() {
		return bbsSeq;
	}

	public void setBbsSeq(long bbsSeq) {
		this.bbsSeq = bbsSeq;
	}

	public short getPhtNum() {
		return phtNum;
	}

	public void setPhtNum(short phtNum) {
		this.phtNum = phtNum;
	}

	public String getPhtName() {
		return phtName;
	}

	public void setPhtName(String phtName) {
		this.phtName = phtName;
	}

	public String getPhtOrgName() {
		return phtOrgName;
	}

	public void setPhtOrgName(String phtOrgName) {
		this.phtOrgName = phtOrgName;
	}

	public long getPhtSize() {
		return phtSize;
	}

	public void setPhtSize(long phtSize) {
		this.phtSize = phtSize;
	}

	public String getPhtExt() {
		return phtExt;
	}

	public void setPhtExt(String phtExt) {
		this.phtExt = phtExt;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public short getPhtNumForUpdate() {
		return phtNumForUpdate;
	}

	public void setPhtNumForUpdate(short phtNumForUpdate) {
		this.phtNumForUpdate = phtNumForUpdate;
	}

	public String getAdminPublic() {
		return adminPublic;
	}

	public void setAdminPublic(String adminPublic) {
		this.adminPublic = adminPublic;
	}
	
	
	
}

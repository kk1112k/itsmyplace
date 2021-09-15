package com.icia.itsmyplace.model;

import java.io.Serializable;

public class CafePht implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String cafeNum;
	private short phtNum;
	private short listOrder;
	private String phtName;
	private String phtOrgName;
	private int phtSize;
	private String phtExt;
	private String regDate;

	public CafePht()
	{
		cafeNum = "";
		phtNum = 0;
		listOrder = 0;
		phtName = "";
		phtOrgName = "";
		phtSize = 0;
		phtExt = "";
		regDate = "";
	}

	public String getCafeNum() {
		return cafeNum;
	}

	public void setCafeNum(String cafeNum) {
		this.cafeNum = cafeNum;
	}

	public short getPhtNum() {
		return phtNum;
	}

	public void setPhtNum(short phtNum) {
		this.phtNum = phtNum;
	}

	public short getListOrder() {
		return listOrder;
	}

	public void setListOrder(short listOrder) {
		this.listOrder = listOrder;
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

	public int getPhtSize() {
		return phtSize;
	}

	public void setPhtSize(int phtSize) {
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
	
}

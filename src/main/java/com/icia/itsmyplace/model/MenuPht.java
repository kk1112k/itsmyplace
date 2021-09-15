package com.icia.itsmyplace.model;

import java.io.Serializable;

public class MenuPht implements Serializable{

	private static final long serialVersionUID = 123242L;
	
	private String cafeNum;
	private String menuNum;
	private short phtNum;
	private short listOrder;
	private String phtOrgName;
	private long phtSize;
	private String phtExt;
	private String regDate;
	
	private String menuName;
	private String menuPrice;
	
	private String searchType;
	
	public MenuPht()
	{
		cafeNum = "";
		menuNum = "";
		phtNum = 0;
		listOrder = 0;
		phtOrgName = "";
		phtSize = 0;
		phtExt = "";
		regDate = "";
		menuName="";
		menuPrice="";
	}

	public String getCafeNum() {
		return cafeNum;
	}

	public void setCafeNum(String cafeNum) {
		this.cafeNum = cafeNum;
	}

	public String getMenuNum() {
		return menuNum;
	}

	public void setMenuNum(String menuNum) {
		this.menuNum = menuNum;
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

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuPrice() {
		return menuPrice;
	}

	public void setMenuPrice(String menuPrice) {
		this.menuPrice = menuPrice;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	
	
	
}

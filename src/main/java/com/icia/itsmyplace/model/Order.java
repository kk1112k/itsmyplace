package com.icia.itsmyplace.model;

import java.io.Serializable;

public class Order implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long rsrvSeq;
	private int orderNum;
	private String cafeNum;
	private String menuNum;
	private int menuCount;
	private String menuName;
	
	public Order() {
		
		rsrvSeq = 0;
		orderNum = 0;
		cafeNum = "";
		menuNum = "";
		menuCount = 0;
		menuName = "";
		
	}

	public long getRsrvSeq() {
		return rsrvSeq;
	}

	public void setRsrvSeq(long rsrvSeq) {
		this.rsrvSeq = rsrvSeq;
	}

	public int getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
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

	public int getMenuCount() {
		return menuCount;
	}

	public void setMenuCount(int menuCount) {
		this.menuCount = menuCount;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	
}

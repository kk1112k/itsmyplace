package com.icia.itsmyplace.model;

import java.io.Serializable;

public class Pay implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long rsrvSeq;
	private String payStep;
	private int payPoint;
	private int originPrice;
	private int totalPrice;
	private String payDate;
	
	public Pay() {
		
		rsrvSeq = 0;
		payStep = "";
		payPoint = 0;
		originPrice = 0;
		totalPrice = 0;
		payDate = "";
		
	}

	public long getRsrvSeq() {
		return rsrvSeq;
	}

	public void setRsrvSeq(long rsrvSeq) {
		this.rsrvSeq = rsrvSeq;
	}

	public String getPayStep() {
		return payStep;
	}

	public void setPayStep(String payStep) {
		this.payStep = payStep;
	}

	public int getPayPoint() {
		return payPoint;
	}

	public void setPayPoint(int payPoint) {
		this.payPoint = payPoint;
	}

	public int getOriginPrice() {
		return originPrice;
	}

	public void setOriginPrice(int originPrice) {
		this.originPrice = originPrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getPayDate() {
		return payDate;
	}

	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}
	
	
	
}

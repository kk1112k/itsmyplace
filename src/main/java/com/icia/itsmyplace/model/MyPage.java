package com.icia.itsmyplace.model;

import java.io.Serializable;
import java.util.List;

public class MyPage implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long rsrvSeq;
	private String rsrvDate;
	private String cafeName;
	private int originPrice;
	private int totalPrice;
	private int payPoint;
	private String originPrice_s;
	private String totalPrice_s;
	private String rsrvTime;
    private String payDate;
    private String rsrvSeatList;
    private String payPoint_s;
    private List<Order> orderList;
    private String payStep;
	
	public MyPage() {
		rsrvSeq = 0;
		rsrvDate = "";
		cafeName = "";
		originPrice = 0;
		totalPrice = 0;
		payPoint = 0;
		originPrice_s = "";
		totalPrice_s = "";
		rsrvTime = "";
		payDate = "";
		rsrvSeatList = "";
		payPoint_s = "";
		orderList = null;
		payStep = "";
	}

	public long getRsrvSeq() {
		return rsrvSeq;
	}

	public void setRsrvSeq(long rsrvSeq) {
		this.rsrvSeq = rsrvSeq;
	}

	public String getRsrvDate() {
		return rsrvDate;
	}

	public void setRsrvDate(String rsrvDate) {
		this.rsrvDate = rsrvDate;
	}

	public String getCafeName() {
		return cafeName;
	}

	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
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

	public int getPayPoint() {
		return payPoint;
	}

	public void setPayPoint(int payPoint) {
		this.payPoint = payPoint;
	}

	public String getOriginPrice_s() {
		return originPrice_s;
	}

	public void setOriginPrice_s(String originPrice_s) {
		this.originPrice_s = originPrice_s;
	}

	public String getTotalPrice_s() {
		return totalPrice_s;
	}

	public void setTotalPrice_s(String totalPrice_s) {
		this.totalPrice_s = totalPrice_s;
	}

	public String getRsrvTime() {
		return rsrvTime;
	}

	public void setRsrvTime(String rsrvTime) {
		this.rsrvTime = rsrvTime;
	}

	public String getPayDate() {
		return payDate;
	}

	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}

	public String getRsrvSeatList() {
		return rsrvSeatList;
	}

	public void setRsrvSeatList(String rsrvSeatList) {
		this.rsrvSeatList = rsrvSeatList;
	}

	public String getPayPoint_s() {
		return payPoint_s;
	}

	public void setPayPoint_s(String payPoint_s) {
		this.payPoint_s = payPoint_s;
	}

	public List<Order> getOrderList() {
		return orderList;
	}

	public void setOrderList(List<Order> orderList) {
		this.orderList = orderList;
	}

	public String getPayStep() {
		return payStep;
	}

	public void setPayStep(String payStep) {
		this.payStep = payStep;
	}


	
	
	
	
}

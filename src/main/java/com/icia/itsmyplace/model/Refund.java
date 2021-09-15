package com.icia.itsmyplace.model;

import java.io.Serializable;

public class Refund implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private long rsrvSeq;		//예약번호
    private String userId;		//예약자아이디
    private String userName;	//예약자이름
    private String rsrvDate;	//예약일(결제완료시 날짜-카페에등장할 날짜)
    private String rsrvTime;	//예약시간(카페에예약한사람이등장할시간)
    private int rsrvPplCnt;		//예약인원수
    private String seatList;	//예약된 자리목록
    private String cafeNum;		//선택된 카페 고유번호
    
    private String cafeName;	//카페이름
    private int totalPrice;		//총금액
    private String totalPrice_s;	//총금액 String
    private String payStep;
    private String rfdReason;	//환불사유
    private String rfdMethod;		//환불 코드
    
    private long startRow;		//시작 rownum
	private long endRow;		//끝 rownum
    
    public Refund() {
    	rsrvSeq = 0;
    	userId = "";
    	userName = "";
    	rsrvDate = ""; //예약하는날짜(내가도착할날짜)
    	rsrvTime = ""; //예약한시간(내가예약한카페이용시간)
    	rsrvPplCnt = 0;
    	seatList = "";
    	cafeNum = "";
    	
    	cafeName = "";
    	totalPrice = 0;
    	totalPrice_s = "";
    	
    	startRow = 0;
    	endRow = 0;
    	
    	payStep = "";
    	rfdReason = "";
        rfdMethod = "";
    }

	public long getRsrvSeq() {
		return rsrvSeq;
	}

	public void setRsrvSeq(long rsrvSeq) {
		this.rsrvSeq = rsrvSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRsrvDate() {
		return rsrvDate;
	}

	public void setRsrvDate(String rsrvDate) {
		this.rsrvDate = rsrvDate;
	}

	public String getRsrvTime() {
		return rsrvTime;
	}

	public void setRsrvTime(String rsrvTime) {
		this.rsrvTime = rsrvTime;
	}

	public int getRsrvPplCnt() {
		return rsrvPplCnt;
	}

	public void setRsrvPplCnt(int rsrvPplCnt) {
		this.rsrvPplCnt = rsrvPplCnt;
	}

	public String getSeatList() {
		return seatList;
	}

	public void setSeatList(String seatList) {
		this.seatList = seatList;
	}

	public String getCafeNum() {
		return cafeNum;
	}

	public void setCafeNum(String cafeNum) {
		this.cafeNum = cafeNum;
	}

	public String getCafeName() {
		return cafeName;
	}

	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getTotalPrice_s() {
		return totalPrice_s;
	}

	public void setTotalPrice_s(String totalPrice_s) {
		this.totalPrice_s = totalPrice_s;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}

	public String getPayStep() {
		return payStep;
	}

	public void setPayStep(String payStep) {
		this.payStep = payStep;
	}

	public String getRfdReason() {
		return rfdReason;
	}

	public void setRfdReason(String rfdReason) {
		this.rfdReason = rfdReason;
	}

	public String getRfdMethod() {
		return rfdMethod;
	}

	public void setRfdMethod(String rfdMethod) {
		this.rfdMethod = rfdMethod;
	}
	
    
 }

package com.icia.itsmyplace.model;

import java.io.Serializable;

public class Seat implements Serializable{
	
	private static final long serialVersionUID = 2222333111L;
	
	private String cafeNum;		//카페 번호
	private String seatNum;		//카페 번호
	private String vacancy;		//카페 번호
	
	public Seat()
	{
		cafeNum = "";		//카페 번호
		seatNum = "";		//카페 번호
		vacancy = "";	
	}

	public String getCafeNum() {
		return cafeNum;
	}

	public void setCafeNum(String cafeNum) {
		this.cafeNum = cafeNum;
	}

	public String getSeatNum() {
		return seatNum;
	}
	
	public void setSeatNum(String seatNum) {
		this.seatNum = seatNum;
	}
	
	public String getVacancy() {
		return vacancy;
	}

	public void setVacancy(String vacancy) {
		this.vacancy = vacancy;
	}
	
}

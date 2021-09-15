package com.icia.itsmyplace.model;

import java.io.Serializable;
import java.util.List;

public class Cafe implements Serializable
{
	private static final long serialVersionUID = 863898951233368543L;
	
	private String cafeNum;		//카페 번호
	private String userId;		//회원 번호
	private String areaNum;		//시도 번호
	private String subAreaNum;		//군구 번호
	private String cafeName;		//카페명
	private String cafeContent;		//카페소개글내용
	private String cafeAddr;		//카페주소
	private String cafeOpnHrs;		//영업시작시간		
	private String cafeClsHrs;		//영업종료시간
	private String status; 			//영업상태
	
	private List<CafePht> cafePhtList;	//인덱스에서 사진조회 목적
	private int seatVacancyCnt;			//인덱스에서 자리수 조회 목적
	private String cafeKeyword;			//인덱스에서 #키워드 조회 목적
	
	private String areaName;			//카페모아보기에서 카페지역명 조회 목적
	private String subAreaName;			//카페모아보기에서 카페지역명 조회 목적
	private List<Review> reviewList;				//카페모아보기에서 리뷰 조회 목적
	
	public Cafe()
	{
		cafeNum = "";
	    userId = "";
	    areaNum = "";
	    subAreaNum = "";
	    cafeName = "";
	    cafeContent = "";
	    cafeAddr = "";
	    cafeOpnHrs = "";
	    cafeClsHrs = "";
	    status = "";
	    cafePhtList = null;
	    seatVacancyCnt = 0;
	    cafeKeyword = "";
	    
	    areaName = "";
	    subAreaName = "";
	    reviewList = null;
	}

	public String getCafeNum() {
		return cafeNum;
	}

	public void setCafeNum(String cafeNum) {
		this.cafeNum = cafeNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAreaNum() {
		return areaNum;
	}

	public void setAreaNum(String areaNum) {
		this.areaNum = areaNum;
	}

	public String getSubAreaNum() {
		return subAreaNum;
	}

	public void setSubAreaNum(String subAreaNum) {
		this.subAreaNum = subAreaNum;
	}

	public String getCafeName() {
		return cafeName;
	}

	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}

	public String getCafeContent() {
		return cafeContent;
	}

	public void setCafeContent(String cafeContent) {
		this.cafeContent = cafeContent;
	}

	public String getCafeAddr() {
		return cafeAddr;
	}

	public void setCafeAddr(String cafeAddr) {
		this.cafeAddr = cafeAddr;
	}

	public String getCafeOpnHrs() {
		return cafeOpnHrs;
	}

	public void setCafeOpnHrs(String cafeOpnHrs) {
		this.cafeOpnHrs = cafeOpnHrs;
	}

	public String getCafeClsHrs() {
		return cafeClsHrs;
	}

	public void setCafeClsHrs(String cafeClsHrs) {
		this.cafeClsHrs = cafeClsHrs;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<CafePht> getCafePhtList() {
		return cafePhtList;
	}

	public void setCafePhtList(List<CafePht> cafePhtList) {
		this.cafePhtList = cafePhtList;
	}

	public int getSeatVacancyCnt() {
		return seatVacancyCnt;
	}

	public void setSeatVacancyCnt(int seatVacancyCnt) {
		this.seatVacancyCnt = seatVacancyCnt;
	}

	public String getCafeKeyword() {
		return cafeKeyword;
	}

	public void setCafeKeyword(String cafeKeyword) {
		this.cafeKeyword = cafeKeyword;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public String getSubAreaName() {
		return subAreaName;
	}

	public void setSubAreaName(String subAreaName) {
		this.subAreaName = subAreaName;
	}

	public List<Review> getReviewList() {
		return reviewList;
	}

	public void setReviewList(List<Review> reviewList) {
		this.reviewList = reviewList;
	}

}

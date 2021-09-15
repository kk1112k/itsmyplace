package com.icia.itsmyplace.model;

import java.io.Serializable;

public class User implements Serializable
{
	private static final long serialVersionUID = 8638989512396268543L;
	
	private String userId;		//아이디
	private String userClass;	//회원구분코드
	private String areaNum;		//지역
	private String subAreaNum;	//부지역
	private String userPwd;		//비밀번호
	private String userName;	//이름
	private String userEmail;	//이메일주소
	private String userGender;	//성별
	private String status;		//회원상태
	private String regDate;		//가입일
	private long totalPoint;		//보유포인트
	private long payPoint;		//사용포인트
	
	private String areaName;	//지역이름
	private String subAreaName; //부지역이름
	
	private long startRow;			// 시작 rownum
	private long endRow;			// 끝 rownum
	
	private String searchType;      // 검색타입(1:이름, 2:제목, 3:내용)
	private String searchValue;      // 검색값

	public User()
	{
		userId = "";
		userClass = "";
		areaNum = "";
		subAreaNum = "";
		userPwd = "";
		userName = "";
		userEmail = "";
		userGender = "";
		status = "";
		regDate = "";
		totalPoint = 0;
		payPoint = 0;
		
		areaName = "";
		subAreaName = "";
		
		startRow = 0;
		endRow = 0;
		
		searchType = "";
		searchValue = "";
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserClass() {
		return userClass;
	}

	public void setUserClass(String userClass) {
		this.userClass = userClass;
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

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public long getTotalPoint() {
		return totalPoint;
	}

	public void setTotalPoint(long totalPoint) {
		this.totalPoint = totalPoint;
	}

	public long getPayPoint() {
		return payPoint;
	}

	public void setPayPoint(long payPoint) {
		this.payPoint = payPoint;
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

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	
	
}
package com.icia.itsmyplace.model;

import java.io.Serializable;
import java.util.List;

public class Review implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private long rsrvSeq; 
	private String bbsTitle;
	private String bbsContent;
	private long bbsReadCnt;
	private String regDate;
	private double bbsStar;
	private String bbsPublic;
	private String userId;
	private String cafeNum;
	private String cafeName;
	private long phtNum;
	private String phtName;
	private String phtOrgName;
	private String adminPublic;
	
	private ReviewPht reviewPht;
	
	private List<ReviewPht> reviewPhtList;
	
	private String userGender;
	
	private long startRow;			// 시작 rownum
	private long endRow;			// 끝 rownum
	
	private String searchType;		// 검색타입(1:이름, 2:제목, 3:내용)
	private String searchValue;		// 검색값
	
	
	public Review() {
		
		rsrvSeq = 0; 
		bbsTitle = "";
		bbsContent = "";
		bbsReadCnt = 0;
		regDate = "";
		bbsStar = 0.0;
		bbsPublic = "";	
		userId = "";
		cafeNum = "";
		cafeName = "";
		phtNum = 0;
		phtName = "";
		phtOrgName = "";
		adminPublic = "";
		
		reviewPht = null;
		reviewPhtList = null;
		
		userGender = "";
		
		startRow = 0;			
		endRow = 0;
		
	}

	public long getRsrvSeq() {
		return rsrvSeq;
	}

	public String getBbsTitle() {
		return bbsTitle;
	}

	public String getBbsContent() {
		return bbsContent;
	}

	public long getBbsReadCnt() {
		return bbsReadCnt;
	}

	public String getRegDate() {
		return regDate;
	}

	public double getBbsStar() {
		return bbsStar;
	}

	public String getBbsPublic() {
		return bbsPublic;
	}

	public String getUserId() {
		return userId;
	}

	public long getStartRow() {
		return startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public String getSearchType() {
		return searchType;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setRsrvSeq(long rsrvSeq) {
		this.rsrvSeq = rsrvSeq;
	}

	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}

	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}

	public void setBbsReadCnt(long bbsReadCnt) {
		this.bbsReadCnt = bbsReadCnt;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public void setBbsStar(double bbsStar) {
		this.bbsStar = bbsStar;
	}

	public void setBbsPublic(String bbsPublic) {
		this.bbsPublic = bbsPublic;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public String getCafeNum() {
		return cafeNum;
	}

	public String getCafeName() {
		return cafeName;
	}

	public void setCafeNum(String cafeNum) {
		this.cafeNum = cafeNum;
	}

	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
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

	public ReviewPht getReviewPht() {
		return reviewPht;
	}

	public void setReviewPht(ReviewPht reviewPht) {
		this.reviewPht = reviewPht;
	}

	public List<ReviewPht> getReviewPhtList() {
		return reviewPhtList;
	}

	public void setReviewPhtList(List<ReviewPht> reviewPhtList) {
		this.reviewPhtList = reviewPhtList;
	}

	public long getPhtNum() {
		return phtNum;
	}

	public void setPhtNum(long phtNum) {
		this.phtNum = phtNum;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	
	public String getAdminPublic() {
		return adminPublic;
	}

	public void setAdminPublic(String adminPublic) {
		this.adminPublic = adminPublic;
	}
	
}

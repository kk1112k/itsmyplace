package com.icia.itsmyplace.model;

import java.io.Serializable;
import java.util.List;

public class Comm implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private long bbsSeq;
	private String userId;
	private String bbsTitle;
	private String bbsContent;
	private int bbsReadCnt;
	private String regDate;
	private String bbsPublic;
	private String adminPublic;
	private int rNum;
	
	private String userName;
	
	private long startRow;
	private long endRow;
	
	private String searchType;
	private String searchValue;
	
	private List<CommPht> commPhtList;
	private List<CommCmt> commCmtList;
	
	private int commCmtCnt;
	
	private String ArsrvCafe;
	private String ArsrvSeat;
	private String ArsrvTime;
	private String ArsrvDate;
	
	public Comm(){
		bbsSeq = 0;
		userId = "";
		bbsTitle = "";
		bbsContent = "";
		bbsReadCnt = 0;
		regDate = "";
		bbsPublic = "";
		adminPublic = "";
		rNum = 0;
		
		userName = "";
		
		startRow = 0;
		endRow = 0;
		
		searchType = "";
		searchValue = "";
		
		commPhtList = null;
		commCmtList = null;
		commCmtCnt = 0;
		
		ArsrvCafe = "";
		ArsrvSeat = "";
		ArsrvTime = "";
		ArsrvDate = "";
	}

	public long getBbsSeq() {
		return bbsSeq;
	}

	public void setBbsSeq(long bbsSeq) {
		this.bbsSeq = bbsSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBbsTitle() {
		return bbsTitle;
	}

	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}

	public String getBbsContent() {
		return bbsContent;
	}

	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}

	public int getBbsReadCnt() {
		return bbsReadCnt;
	}

	public void setBbsReadCnt(int bbsReadCnt) {
		this.bbsReadCnt = bbsReadCnt;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getBbsPublic() {
		return bbsPublic;
	}

	public void setBbsPublic(String bbsPublic) {
		this.bbsPublic = bbsPublic;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public List<CommPht> getCommPhtList() {
		return commPhtList;
	}

	public void setCommPhtList(List<CommPht> commPhtList) {
		this.commPhtList = commPhtList;
	}

	public int getCommCmtCnt() {
		return commCmtCnt;
	}

	public void setCommCmtCnt(int commCmtCnt) {
		this.commCmtCnt = commCmtCnt;
	}

	public String getArsrvCafe() {
		return ArsrvCafe;
	}

	public void setArsrvCafe(String arsrvCafe) {
		ArsrvCafe = arsrvCafe;
	}

	public String getArsrvSeat() {
		return ArsrvSeat;
	}

	public void setArsrvSeat(String arsrvSeat) {
		ArsrvSeat = arsrvSeat;
	}

	public String getArsrvTime() {
		return ArsrvTime;
	}

	public void setArsrvTime(String arsrvTime) {
		ArsrvTime = arsrvTime;
	}

	public String getArsrvDate() {
		return ArsrvDate;
	}

	public void setArsrvDate(String arsrvDate) {
		ArsrvDate = arsrvDate;
	}	
	
	public String getAdminPublic() {
		return adminPublic;
	}

	public void setAdminPublic(String adminPublic) {
		this.adminPublic = adminPublic;
	}

	public int getrNum() {
		return rNum;
	}

	public void setrNum(int rNum) {
		this.rNum = rNum;
	}

	public List<CommCmt> getCommCmtList() {
		return commCmtList;
	}

	public void setCommCmtList(List<CommCmt> commCmtList) {
		this.commCmtList = commCmtList;
	}	
	
	
	
}

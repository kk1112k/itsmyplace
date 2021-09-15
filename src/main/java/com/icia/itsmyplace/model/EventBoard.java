package com.icia.itsmyplace.model;

import java.io.Serializable;

public class EventBoard implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long bbsSeq;
	private String userId;
	private String userClass;
	private String bbsTitle;
	private String bbsContent;
	private int bbsReadCnt;
	private String regDate;
	private String evtOpnDate;
	private String evtClsDate;
	private String bbsPublic;
	private String fileName;
	private String fileOrgName;
	private String adminPublic;
	
	private String searchStatus;
	private String searchType;
	private String searchValue;
	
	
	private String userName;		// 사용자 이름
	private String userEmail;		// 사용자 이메일
	
	private long startRow;			// 시작 rownum
	private long endRow;			// 끝 rownum
	
	private EventBoardFile eventBoardFile;	// 첨부파일

	
	public EventBoard()
	{
		bbsSeq = 0;
		userId = "";
		userClass = "";
		bbsTitle = "";
		bbsContent = "";
		bbsReadCnt = 0;
		regDate = "";
		evtOpnDate = "";
		evtClsDate = "";
		bbsPublic = "";
		fileName = "";
		fileOrgName = "";
		adminPublic = "";
		
		searchStatus = "";
		searchType = "";
		searchValue = "";
		
		userName = "";
		userEmail = "";
		
		startRow = 0;
		endRow = 0;
		
		eventBoardFile = null;
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

	public String getEvtOpnDate() {
		return evtOpnDate;
	}

	public void setEvtOpnDate(String evtOpnDate) {
		this.evtOpnDate = evtOpnDate;
	}

	public String getEvtClsDate() {
		return evtClsDate;
	}

	public void setEvtClsDate(String evtClsDate) {
		this.evtClsDate = evtClsDate;
	}

	public String getBbsPublic() {
		return bbsPublic;
	}

	public void setBbsPublic(String bbsPublic) {
		this.bbsPublic = bbsPublic;
	}

	public String getSearchStatus() {
		return searchStatus;
	}

	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
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

	public EventBoardFile getEventBoardFile() {
		return eventBoardFile;
	}

	public void setEventBoardFile(EventBoardFile eventBoardFile) {
		this.eventBoardFile = eventBoardFile;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUserClass() {
		return userClass;
	}

	public void setUserClass(String userClass) {
		this.userClass = userClass;
	}

	public String getFileOrgName() {
		return fileOrgName;
	}

	public void setFileOrgName(String fileOrgName) {
		this.fileOrgName = fileOrgName;
	}

	public String getAdminPublic() {
		return adminPublic;
	}

	public void setAdminPublic(String adminPublic) {
		this.adminPublic = adminPublic;
	}
	
	
	
		
}


	

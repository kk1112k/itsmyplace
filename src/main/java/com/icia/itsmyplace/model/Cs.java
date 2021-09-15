package com.icia.itsmyplace.model;

import java.io.Serializable;

public class Cs implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long bbsSeq;			// 게시물 번호
	private String userId;			// 사용자 아이디
	private long bbsGroup;		// 게시물 그룹 번호
	private int bbsOrder;			// 게시물 그룹 내 순서
	private int bbsIndent;			// 게시물 들여쓰기
	private long bbsParent;			// 부모 게시물 번호
	private String bbsTitle;		// 게시물 제목
	private String bbsContent;		// 게시물 내용
	private int bbsReadCnt;			// 게시물 조회수
	private String adminPublic;		// 관리자 차단여부
	
	private String regDate;			// 게시물 등록일(작성일)
	private String bbsPublic;		// 공개여부
	
	private String userName;
	private String userEmail;
	
	private long startRow;			// 시작 rownum
	private long endRow;			// 끝 rownum
	
	private String searchType;		// 검색타입(1:이름, 2:제목, 3:내용)
	private String searchValue;		// 검색값

	public Cs() {
		bbsSeq = 0;			// 게시물 번호
		userId = "";			// 사용자 아이디
		bbsGroup = 0;		// 게시물 그룹 번호
		bbsOrder = 0;			// 게시물 그룹 내 순서
		bbsIndent = 0;			// 게시물 들여쓰기
		bbsParent = 0;			// 부모 게시물 번호
		bbsTitle = "";		// 게시물 제목
		bbsContent = "";		// 게시물 내용
		bbsReadCnt = 0;			// 게시물 조회수
		adminPublic = "";		// 관리자 차단 여부
		
		regDate = "";			// 게시물 등록일(작성일)
		bbsPublic = "";		// 공개여부
		
		userName = "";
		userEmail = "";
		
		startRow = 0;			// 시작 rownum
		endRow = 0;			// 끝 rownum
		
		searchType = "";		// 검색타입(1:이름, 2:제목, 3:내용)
		searchValue = "";		// 검색값
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

	public long getBbsGroup() {
		return bbsGroup;
	}

	public void setBbsGroup(long bbsGroup) {
		this.bbsGroup = bbsGroup;
	}

	public int getBbsOrder() {
		return bbsOrder;
	}

	public void setBbsOrder(int bbsOrder) {
		this.bbsOrder = bbsOrder;
	}

	public int getBbsIndent() {
		return bbsIndent;
	}

	public void setBbsIndent(int bbsIndent) {
		this.bbsIndent = bbsIndent;
	}

	public long getBbsParent() {
		return bbsParent;
	}

	public void setBbsParent(long bbsParent) {
		this.bbsParent = bbsParent;
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
	
	public String getAdminPublic() {
		return adminPublic;
	}

	public void setAdminPublic(String adminPublic) {
		this.adminPublic = adminPublic;
	}
	
}

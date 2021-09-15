package com.icia.itsmyplace.model;

import java.io.Serializable;

public class Board implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private long bbsSeq; 			// 게시물 번호
	private String userId;			// 사용자 아이디
	private long bbsGroup;		// 게시물 그룹 번호
	private int bbsOrder;			// 게시물 그룹 내 순서
	private int bbsIndent;		// 게시물 들여쓰기
	private String bbsTitle;		// 게시물 제목
	private String bbsContent;	// 게시물 내용
	private int bbsReadCnt;		// 게시물 조회수
	private String regDate;			// 게시물 등록일
	private long bbsParent;		// 부모 게시물 번호
	
	private String userName;		// 사용자 이름
	private String userEmail;		// 사용자 이메일
	
	private long startRow;			// 시작 rownum
	private long endRow;			// 끝 rownum
	
	private String searchType;		// 검색타입(1:이름, 2:제목, 3:내용)
	private String searchValue;		// 검색값
	
	private BoardFile boardFile;	// 첨부파일
	
	public Board() {
		bbsSeq = 0; 			
		userId = "";			
		bbsGroup = 0;		
		bbsOrder = 0;			
		bbsIndent = 0;		
		bbsTitle = "";		
		bbsContent = "";	
		bbsReadCnt = 0;		
		regDate = "";		
		
		bbsParent = 0;		
		userName = "";		
		userEmail = "";		
		
		startRow = 0;			
		endRow = 0;	
		boardFile = null;
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

	public long getBbsParent() {
		return bbsParent;
	}

	public void setBbsParent(long bbsParent) {
		this.bbsParent = bbsParent;
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

	public BoardFile getBoardFile() {
		return boardFile;
	}

	public void setBoardFile(BoardFile boardFile) {
		this.boardFile = boardFile;
	}
	
	
}

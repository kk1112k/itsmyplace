package com.icia.itsmyplace.model;

import java.io.Serializable;

public class UserPostList implements Serializable{

	private static final long serialVersionUID = -4519924161422183488L;

	private long bbsSeq;
	private long rsrvSeq;
	private String userId;
	private String bbsTitle;
	private String bbsContent;
	private String regDate;
	private String bbsPublic;
	private String adminPublic;
	
	private long startRow;
	private long endRow;
	
	public UserPostList(){
		userId = "";
		bbsSeq = 0;
		rsrvSeq = 0;
		bbsTitle = "";
		bbsContent = "";
		regDate = "";
		bbsPublic = "";
		adminPublic = "";
		
	}
	
	

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public long getRsrvSeq() {
		return rsrvSeq;
	}

	public void setRsrvSeq(long rsrvSeq) {
		this.rsrvSeq = rsrvSeq;
	}

	public long getBbsSeq() {
		return bbsSeq;
	}

	public void setBbsSeq(long bbsSeq) {
		this.bbsSeq = bbsSeq;
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

	public String getAdminPublic() {
		return adminPublic;
	}

	public void setAdminPublic(String adminPublic) {
		this.adminPublic = adminPublic;
	}

}	

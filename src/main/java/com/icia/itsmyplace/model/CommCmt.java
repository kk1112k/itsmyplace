package com.icia.itsmyplace.model;

import java.io.Serializable;

public class CommCmt implements Serializable{

	private static final long serialVersionUID = 1L;

	private long bbsSeq;
	private long cmtSeq;
	private String userId;
	private String userName;
	private long cmtGroup;
	private int cmtOrder;
	private int cmtIndent;
	private String cmtContent;
	private String regDate;
	private String adminPublic;
	
	private String commentMe;
	
	public CommCmt() {
		bbsSeq = 0;
		cmtSeq = 0;
		userId = "";
		userName = "";
		cmtGroup = 0;
		cmtOrder = 0;
		cmtIndent = 0;
		cmtContent = "";
		regDate = "";
		adminPublic = "";
		
		commentMe = "";
	}

	public long getBbsSeq() {
		return bbsSeq;
	}

	public void setBbsSeq(long bbsSeq) {
		this.bbsSeq = bbsSeq;
	}

	public long getCmtSeq() {
		return cmtSeq;
	}

	public void setCmtSeq(long cmtSeq) {
		this.cmtSeq = cmtSeq;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public long getCmtGroup() {
		return cmtGroup;
	}

	public void setCmtGroup(long cmtGroup) {
		this.cmtGroup = cmtGroup;
	}

	public int getCmtOrder() {
		return cmtOrder;
	}

	public void setCmtOrder(int cmtOrder) {
		this.cmtOrder = cmtOrder;
	}

	public int getCmtIndent() {
		return cmtIndent;
	}

	public void setCmtIndent(int cmtIndent) {
		this.cmtIndent = cmtIndent;
	}

	public String getCmtContent() {
		return cmtContent;
	}

	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getCommentMe() {
		return commentMe;
	}

	public void setCommentMe(String commentMe) {
		this.commentMe = commentMe;
	}
	
	public String getAdminPublic() {
		return adminPublic;
	}

	public void setAdminPublic(String adminPublic) {
		this.adminPublic = adminPublic;
	}
	
}

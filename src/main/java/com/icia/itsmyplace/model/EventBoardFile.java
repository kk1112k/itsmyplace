package com.icia.itsmyplace.model;

import java.io.Serializable;

public class EventBoardFile implements Serializable
{
	private static final long serialVersionUID = 1L;

	private long bbsSeq;
	private int fileNum;
	private String fileName;
	private String fileOrgName;
	private long fileSize;
	private String fileExt;
	private String regDate;
	
	public EventBoardFile() { // 생성자 초기화
		bbsSeq = 0;			
		fileNum = 0;
		fileName = "";
		fileOrgName = "";
		fileSize = 0;
		fileExt = "";
		regDate = "";
	}

	public long getBbsSeq() {
		return bbsSeq;
	}

	public void setBbsSeq(long bbsSeq) {
		this.bbsSeq = bbsSeq;
	}

	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileOrgName() {
		return fileOrgName;
	}

	public void setFileOrgName(String fileOrgName) {
		this.fileOrgName = fileOrgName;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	
	
	
}

package com.icia.itsmyplace.model;

import java.io.Serializable;

public class NoticeFile implements Serializable {

	private static final long serialVersionUID = 1L;
	private long bbsSeq;				// 게시물 번호
	private short fileNum;				// 게시물 번호별 파일 번호
	private String fileName;			// 저장 파일명
	private String fileOrgName;			// 원본 파일명
	private long fileSize;				// 파일 크기(byte)
	private String fileExt;				// 파일 확장자
	private String regDate;				// 등록일
	
	public NoticeFile() {
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

	public short getFileNum() {
		return fileNum;
	}

	public void setFileNum(short fileNum) {
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

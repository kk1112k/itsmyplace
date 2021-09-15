package com.icia.itsmyplace.model;

import java.io.Serializable;

public class Point implements Serializable{

	private static final long serialVersionUID = 1L;

	private long pointSeq;
	private String userId;
	private int savePoint;
	private String savePath;
	private String saveDate;
	private String delDate;
	
	private long rsrvSeq;
	
	private String status;
	private long startRow;			// 시작 rownum
	private long endRow;			// 끝 rownum
	
	
	public Point() {
		pointSeq = 0;
		userId = "";
		savePoint = 0;
		savePath = "";
		saveDate = "";
		delDate = "";
		
		rsrvSeq = 0;
		
		status = "";
		startRow = 0;
		endRow = 0;
	}

	public long getPointSeq() {
		return pointSeq;
	}

	public void setPointSeq(long pointSeq) {
		this.pointSeq = pointSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getSavePoint() {
		return savePoint;
	}

	public void setSavePoint(int savePoint) {
		this.savePoint = savePoint;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String getSaveDate() {
		return saveDate;
	}

	public void setSaveDate(String saveDate) {
		this.saveDate = saveDate;
	}

	public String getDelDate() {
		return delDate;
	}

	public void setDelDate(String delDate) {
		this.delDate = delDate;
	}

	public long getRsrvSeq() {
		return rsrvSeq;
	}

	public void setRsrvSeq(long rsrvSeq) {
		this.rsrvSeq = rsrvSeq;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
	
	
}

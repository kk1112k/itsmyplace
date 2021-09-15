package com.icia.itsmyplace.model;

import java.io.Serializable;

public class SubArea implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String areaNum;
	private String subAreaNum;
	
	private String subAreaName;
	private String areaName;			//카페 모아보기 페이지 지역명 조회에서 쓸것임
	
	public SubArea() {
		areaNum = "";
		subAreaNum = "";
		subAreaName = "";
		
		areaName = "";
	}

	public String getAreaNum() {
		return areaNum;
	}

	public void setAreaNum(String areaNum) {
		this.areaNum = areaNum;
	}

	public String getSubAreaNum() {
		return subAreaNum;
	}

	public void setSubAreaNum(String subAreaNum) {
		this.subAreaNum = subAreaNum;
	}

	public String getSubAreaName() {
		return subAreaName;
	}

	public void setSubAreaName(String subAreaName) {
		this.subAreaName = subAreaName;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	
	
	
}

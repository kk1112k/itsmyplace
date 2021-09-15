package com.icia.itsmyplace.model;

import java.io.Serializable;

public class Area implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String areaNum;		//지역
	private String areaName;	//부지역
	
	public Area() {
		areaNum = "";
		areaName = "";
	}

	public String getAreaNum() {
		return areaNum;
	}

	public void setAreaNum(String areaNum) {
		this.areaNum = areaNum;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	
	
}

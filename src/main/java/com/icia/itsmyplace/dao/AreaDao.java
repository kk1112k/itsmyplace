package com.icia.itsmyplace.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Area;
import com.icia.itsmyplace.model.Cafe;
import com.icia.itsmyplace.model.SubArea;

@Repository("areaDao")
public interface AreaDao
{
	public List<SubArea> subAreaSelect();
	public Area myArea(String areaNum);
	public SubArea mySubArea(String subAreaNum);
	public List<Area> areaSelect();
	public List<SubArea> subAreaList(String areaNum);
	
	//카페모아보기 페이지 지역명 조회
	public SubArea areaNameSelect(String subAreaNum);
}
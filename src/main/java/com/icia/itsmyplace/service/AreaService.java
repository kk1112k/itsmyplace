package com.icia.itsmyplace.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.itsmyplace.dao.AreaDao;
import com.icia.itsmyplace.model.Area;
import com.icia.itsmyplace.model.SubArea;

@Service("areaService")
public class AreaService {
	
	private static Logger logger = LoggerFactory.getLogger(AreaService.class);
	
	@Autowired
	private AreaDao areaDao;
	
	public List<SubArea> subAreaSelect(){
		
		List<SubArea> list = null;
		
		try {
			list = areaDao.subAreaSelect();
		}
		catch(Exception e)
		{
			logger.error("[AreaService] subAreaList Exception", e);
		}
		
		return list;
	}
	
	public Area myArea(String areaNum) {
		Area area = null;
		
		try {
			area = areaDao.myArea(areaNum);
		}
		catch(Exception e){
			logger.error("[AreaService] myArea Exception", e);
		}
		
		return area;
		
	}
	public SubArea mySubArea(String subAreaNum) {
		
		SubArea subArea = null;
		
		try {
			subArea = areaDao.mySubArea(subAreaNum);
		}
		catch(Exception e){
			logger.error("[AreaService] mySubArea Exception", e);
		}
		
		return subArea;
	}

	
	public List<Area> areaSelect()
	{
		List<Area> area = null;
	
		try
		{
			area = areaDao.areaSelect();
		}
		catch(Exception e)
		{
			logger.error("[AreaService] areaSelect Exception", e);
		}
		
		return area;
	}

	//회원가입페이지 세부지역조회
	public List<SubArea> subAreaList(String areaNum)
	{
		List<SubArea> subAreaList = null;
		
		try {
			subAreaList = areaDao.subAreaList(areaNum);
		}
		catch(Exception e)
		{
			logger.error("[AreaService] subAreaList Exception", e);
		}
		
		return subAreaList;
	}
	
	//카페모아보기 페이지 소속 지역명 조회
	public SubArea areaNameSelect(String subAreaNum)
	{
		SubArea subArea = null;
		
		try
		{
			subArea = areaDao.areaNameSelect(subAreaNum);
		}
		catch(Exception e)
		{
			logger.error("[AreaService] areaNameSelect Exception", e);
		}
		
		return subArea;
	}

}

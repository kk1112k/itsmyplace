package com.icia.itsmyplace.dao;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.MenuPht;

@Repository("menuDao")
public interface MenuDao{
	
	public long menuPhtInsert(MenuPht menuPht);
	
	//카페소개 페이지 베스트 메뉴사진 조회 목적
	public MenuPht bestMenuPhtSelect(MenuPht menuPht);
}

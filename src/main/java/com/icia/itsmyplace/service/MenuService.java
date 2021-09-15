package com.icia.itsmyplace.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.icia.itsmyplace.dao.MenuDao;
import com.icia.itsmyplace.model.MenuPht;

@Service("menuService")
public class MenuService {
	
	private static Logger logger = LoggerFactory.getLogger(MenuService.class);
	
	@Value("#{env['uploadMenu.save.dir']}")
	private String UPLOADMENU_SAVE_DIR;
	
	@Autowired
	private MenuDao menuDao;

	public long menuInsert(MenuPht menuPht) throws Exception{
		
		long count = menuDao.menuPhtInsert(menuPht);
		
		return count;
		
	
		
	}
	
}

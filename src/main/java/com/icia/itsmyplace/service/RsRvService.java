package com.icia.itsmyplace.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.itsmyplace.dao.RsRvDao;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.User;

@Service("rsRvService")
public class RsRvService {

	private static Logger logger = LoggerFactory.getLogger(RsRvService.class);
	
	@Autowired
	private RsRvDao rsRvDao;
	
	//결제정보 불러오기
	public List<RsRv> myOrderInfo(RsRv rsRv) {
		List<RsRv> list = null;
		try {
			list = rsRvDao.myOrderInfo(rsRv);
		}
		catch(Exception e){
			logger.error("[MyPageService] myOrderInfo Exception", e);
		}
		return list;
	}
	
	//결제 횟수 불러오기
	public long myOrderCount(User user) {
		long count = 0;
		try {
			count = rsRvDao.myOrderCount(user);
		} catch(Exception e) {
			logger.error("[MyPageService] myOrderCount Exception", e);
		}
		
		return count;
	}
	
	public RsRv rsRvSelect(long rsrvSeq)
	{
		   RsRv rsrv = null;
		   
		   try
		   {
			   rsrv = rsRvDao.rsRvSelect(rsrvSeq);
		   } 
		   catch(Exception e)
		   {
			   logger.error("[RsRvService] rsRvSelect Exception", e);
		   }
		   
		   return rsrv;
	   }
	
}

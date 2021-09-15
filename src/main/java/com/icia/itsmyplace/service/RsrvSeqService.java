package com.icia.itsmyplace.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.itsmyplace.dao.RsrvSeqDao;


@Service("rsrvSeqService")
public class RsrvSeqService {

	private static Logger logger = LoggerFactory.getLogger(RsrvSeqService.class);
	
	@Autowired
	private RsrvSeqDao rsrvSeqDao;
	
	public long selectRsrvSeq()
	   {
	      long count = 0;
	      
	      try
	      {
	         count = rsrvSeqDao.selectRsrvSeq();
	      }
	      catch(Exception e)
	      {
	         logger.error("[RsRvSeqService] selectRsrvSeq Exception", e);
	      }
	      
	      return count;
	   }
}

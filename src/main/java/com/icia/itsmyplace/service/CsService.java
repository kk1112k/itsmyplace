package com.icia.itsmyplace.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.itsmyplace.dao.CsDao;
import com.icia.itsmyplace.model.Cs;

@Service("csService")
public class CsService {
	
	private static Logger logger = LoggerFactory.getLogger(CsService.class);
	
	
	@Autowired
	private CsDao csDao;
	
	//게시물 생성
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public long csInsert(Cs cs) throws Exception{
		
		long count = csDao.csInsert(cs);
		
		return count;
		
	}
		
	//게시물 리스트 카운트
	public long csListCount(Cs cs)
	{
		long count = 0;
		
		try
		{
			count = csDao.csListCount(cs);
		}
		catch(Exception e)
		{
			logger.error("[CsService] csListCount Exception", e);
		}
		
		return count;
	}
	
	//게시물 리스트
	public List<Cs> csList(Cs cs)
	{
		List<Cs> list = null;
		
		try
		{
			list = csDao.csList(cs);
		}
		catch(Exception e)
		{
			logger.error("[CsService] csList Exception", e);
		}
		
		return list;
	}
	
	//게시물 조회
	public Cs csSelect(long bbsSeq) {
		
		Cs cs = null;
		
		try
		{
			cs = csDao.csSelect(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[CsService] csSelect Exception", e);
		}
		
		return cs;
	}
	
	//게시물 삭제시 답변글 체크
    public int csAnswersCount(long bbsSeq) {
	    int count = 0;
	   
	    try {
		    count = csDao.csAnswersCount(bbsSeq);
	    } catch(Exception e) {
		    logger.error("[CsService] csAnswersCount Exception", e);
	    }
	   
	    return count;
    }
	   
    
    //게시물 삭제(파일이 있으면 같이 삭제)
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
    public int csDelete(long bbsSeq) throws Exception
    {
       int count = 0;
       
       Cs cs = csDao.csSelect(bbsSeq);
       
       if(cs != null)
       {
          count = csDao.csDelete(bbsSeq);  
       }
       
       return count;
    }
    
    //게시물 수정
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
    public int csUpdate(Cs cs) throws Exception
    {
       int count = csDao.csUpdate(cs);
       
       return count;
    }
    
	//게시물 보기
	public Cs csView(long BbsSeq)
	{
		Cs cs = null;
		
		try
		{
			cs = csDao.csSelect(BbsSeq);
			
			if(cs != null)
			{
				csDao.csReadCntPlus(BbsSeq);
				
			}
		}
		catch(Exception e)
		{
			logger.error("[CsService] csView Exception", e);
		}
		
		return cs;
	}
	
	
	//답글 등록, 같은 그룹내 순서 업데이트
    @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class) //테이블 2개 걸기 위해 트랜잭션 사용
    public int csReplyInsert(Cs cs) throws Exception{
	    csDao.csGroupOrderUpdate(cs);
	   
	    int count = csDao.csReplyInsert(cs);
	   
	    return count;
    }
	
	
}

package com.icia.itsmyplace.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.model.FileData;
import com.icia.itsmyplace.dao.CommDao;
import com.icia.itsmyplace.model.Comm;
import com.icia.itsmyplace.model.CommCmt;
import com.icia.itsmyplace.model.CommPht;

@Service("commService")
public class CommService {
	
	private static Logger logger = LoggerFactory.getLogger(CommService.class);
	
	@Value("#{env['uploadComm.save.dir']}")
	private String UPLOADCOMM_SAVE_DIR;
	
	@Autowired
	private CommDao commDao;
	
	//게시물 조회수 증가
	public int bbsReadCntPlus(long bbsSeq)
	{
		int count = 0;
		
		try
		{
			count = commDao.bbsReadCntPlus(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[CommService] bbsReadCntPlus Exception", e);
		}
		
		return count;
		
	}
	
	//게시물 리스트 카운트
	public long commListCount(Comm comm)
	{
		long count = 0;
		
		try
		{
			count = commDao.commListCount(comm);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commListCount Exception", e);
		}
		
		return count;
	}
	
	//게시물 리스트
	public List<Comm> commList(Comm comm)
	{
		List<Comm> list = null;
		
		try
		{
			list = commDao.commList(comm);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commList Exception", e);
		}
		
		return list;
	}
	
	//게시물 조회
	public Comm commSelect(long bbsSeq) {
		
		Comm comm = null;
		
		try
		{
			comm = commDao.commSelect(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commSelect Exception", e);
		}
		
		return comm;
	}
	
	//게시물 생성
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commInsert(Comm comm) throws Exception
	{
		int count = commDao.commInsert(comm);
		
		List<CommPht> commPhtList = comm.getCommPhtList();
		
		if(count > 0 && commPhtList != null)
		{			
			for( int i = 0; i<commPhtList.size(); i++)
			{								
				commPhtList.get(i).setBbsSeq(comm.getBbsSeq());
				commPhtList.get(i).setPhtNum((short)(i+1));
				
				commDao.commPhtInsert(commPhtList.get(i));
			}
		}
	
		return count;
		
	}
	
	//댓글 달기
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commCmtInsert(CommCmt commCmt) {
				
		int count = 0;
		
		try
		{
			count = commDao.commCmtInsert(commCmt);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commCmtInsert Exception", e);
		}
				
		return count;
	}
	
	//댓글 리스트
	public List<CommCmt> commCmtList(CommCmt commCmt)
	{
		List<CommCmt> list = null;
		
		try
		{
			list = commDao.commCmtList(commCmt);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commCmtList Exception", e);
		}
		
		return list;
	}
	
	//댓글 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commCmtDelete(CommCmt commCmt)
	{
		int count = 0;
		
		try
		{
			count = commDao.commCmtDelete(commCmt);
			
//			Comm comm = commDao.commSelect(commCmt.getBbsSeq());
//			
//			if(count > 0 && comm != null)
//			{
//				List<CommCmt> list = commDao.commCmtList(commCmt);
//				
//				comm.setCommCmt(list);
//			}
		}
		catch(Exception e)
		{
			logger.error("[CommService] commCmtDelete Exception", e);
		}
		
		return count;
	}
	
	//사진 리스트 조회
	public List<CommPht> commPhtList(long bbsSeq)
	{
		List<CommPht> commPhtList = null;
		
		try
		{
			commPhtList = commDao.commPhtList(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commPhtList Exception", e);
		}
		
		return commPhtList;
	}
	
	//게시물 사진 조회
	public CommPht commPhtSelect(CommPht commPht)
	{
		CommPht commPhtResult = null;
		
		try
		{
			commPhtResult = commDao.commPhtSelect(commPht);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commPhtSelect Exception", e);
		}
		
		return commPhtResult;
	}
	
	//게시글 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commUpdate(Comm comm, List<FileData> fileData)
	{
		int count = 0;
				
		List<CommPht> commPhtList  = commDao.commPhtList(comm.getBbsSeq());
		int phtListCnt = commPhtList.size();
		
		int fileDataCnt = 0;	
		
		if(fileData != null)
		{
			fileDataCnt = fileData.size();
		}
				
		try
		{			
			count = commDao.commUpdate(comm);		
			
			if(count > 0 &&  fileDataCnt > 0)
			{					
				for(int i=0; i<fileDataCnt; i++)
				{
					commDao.commPhtInsert(comm.getCommPhtList().get((i)+phtListCnt));
				}
			}
		}
		catch(Exception e)
		{
			logger.error("[CommService] commUpdate Exception", e);
		}
				
		return count;
	}
	
	//댓글 단일 조회
	public CommCmt commCmtSelect(long bbsSeq, long cmtSeq)
	{
		CommCmt commCmt = new CommCmt();
		commCmt.setBbsSeq(bbsSeq);
		commCmt.setCmtSeq(cmtSeq);
		
		try
		{
			commCmt = commDao.commCmtSelect(commCmt);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commCmtSelect Exception", e);
		}
		
		return commCmt;
	}
	
	//댓글 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commCmtUpdate(CommCmt commCmt)
	{
		int count = 0;
		
		try
		{
			count = commDao.commCmtUpdate(commCmt);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commCmtUpdate Exception", e);
		}
		
		return count;
	}
	
	//댓글 전부 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commCmtDeleteAll(CommCmt commCmt) {
		
		int count = 0;
		
		try {
			count = commDao.commCmtDeleteAll(commCmt);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commCmtDeleteAll Exception", e);
		}
		
		return count;
	}
	
	//게시글 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commDelete(long bbsSeq) {
		
		int count = 0;
		
		try {
			count = commDao.commDelete(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commDelete Exception", e);
		}
		
		return count;
	}
	
	//게시글 첨부사진 전부 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commPhtDeleteAll(long bbsSeq) {
		
		int count = 0;
		
		try
		{
			count = commDao.commPhtDeleteAll(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commPhtDeleteAll Exception", e);
		}
		
		return count;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commPhtDelete(CommPht commPht) {
		
		int count = 0;
		
		try
		{
			count = commDao.commPhtDelete(commPht);

		}
		catch(Exception e)
		{
			logger.error("[CommService] commPhtDelete Exception", e);
		}
		
		return count;
		
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int commPhtUpdate(CommPht commPht) {
		
		int count = 0;
		
		try
		{
			count = commDao.commPhtUpdate(commPht);

		}
		catch(Exception e)
		{
			logger.error("[CommService] commPhtDelete Exception", e);
		}
		
		return count;
		
	}
}

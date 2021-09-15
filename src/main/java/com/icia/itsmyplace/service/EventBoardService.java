package com.icia.itsmyplace.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.util.FileUtil;
import com.icia.itsmyplace.dao.EventBoardDao;
import com.icia.itsmyplace.model.EventBoard;
import com.icia.itsmyplace.model.EventBoardFile;





@Service("eventBoardService")
public class EventBoardService 
{
	   private static Logger logger = LoggerFactory.getLogger(EventBoardService.class);
	   
	   //파일 저장 디렉토리
	   @Value("#{env['uploadEvent.save.dir']}")
	   private String UPLOADEVENT_SAVE_DIR;
	   
	   @Autowired
	   private EventBoardDao eventBoardDao;

	   
		//게시물 등록
		@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
		public int eventBoardInsert(EventBoard eventBoard) throws Exception
		{
			int count = eventBoardDao.eventBoardInsert(eventBoard);
					
			if(count > 0 && eventBoard.getEventBoardFile() != null)
			{
				EventBoardFile eventBoardFile = eventBoard.getEventBoardFile();
				
				eventBoardFile.setBbsSeq(eventBoard.getBbsSeq());
				eventBoardFile.setFileNum((short)1);
				
				eventBoardDao.eventBoardFileInsert(eventBoard.getEventBoardFile());				
			}
			
			return count;
		}	   
	   
	   
	   //게시물 리스트
	   public List<EventBoard> eventBoardList(EventBoard eventBoard) 
	   {   
		   List<EventBoard> list = null;
		   
		   try
		   {
			   logger.error("이벤트 보드 성공");
			   list = eventBoardDao.eventBoardList(eventBoard);
		   }
		   catch(Exception e)
		   {
			   logger.error("[EventBoardService] eventBoardList Exception", e);
		   }
	      
		   return list;
		}
	  
	   
	   //게시물 카운트
	   public long eventBoardListCount(EventBoard eventBoard)
	   {
		   long count = 0;
		   
		   try
		   {
			   count = eventBoardDao.eventBoardListCount(eventBoard);
			   logger.error("이벤트 보드 게시물 카운트 성공");
		   }
		   catch(Exception e)
		   {
			   logger.error("[EventBoardService] eventBoardListCount Exception", e);
		   }
		   
		   return count;
	   }
	   
	   
	    //게시물 조회
		public EventBoard eventBoardSelect(long bbsSeq)
		{
				EventBoard eventBoard = null;
				logger.error("이벤트 보드 게시물 조회 성공");
					
			try
			{
				eventBoard = eventBoardDao.eventBoardSelect(bbsSeq);
			}
			catch(Exception e)
			{
				logger.error("[EventBoardService] eventBoardSelect Exception", e);
			}
					
			return eventBoard;
		}
		
		
		//게시물 보기        
		public EventBoard eventBoardDetail(long bbsSeq)
		{
			EventBoard eventBoard = null;
			
			try
			{
				eventBoard = eventBoardDao.eventBoardSelect(bbsSeq);
				
				if(eventBoard != null)
				{
					//조회수 증가
					eventBoardDao.eventBoardReadCntPlus(bbsSeq);
					
					//첨부파일 조회
					EventBoardFile eventBoardFile = eventBoardDao.eventBoardFileSelect(bbsSeq);
					
					if(eventBoardFile != null)
					{
						eventBoard.setEventBoardFile(eventBoardFile);
					}
				}
			}
			catch(Exception e)
			{
				logger.error("[EventBoardService] eventBoardDetail Exception", e);
			}
			
			return eventBoard;
		}		

		
		//게시물 삭제(파일이 있으면 같이 삭제)
		@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
		public int eventBoardDelete(long bbsSeq) throws Exception
		{
			int count = 0;
			
			EventBoard eventBoard = eventBoardDao.eventBoardSelect(bbsSeq);
			
			if(eventBoard != null)
			{
				EventBoardFile eventBoardFile = eventBoardDao.eventBoardFileSelect(bbsSeq);
				
				
				if(eventBoardDao.eventBoardFileDelete(bbsSeq) > 0)
				{
					FileUtil.deleteFile(UPLOADEVENT_SAVE_DIR + FileUtil.getFileSeparator() + eventBoardFile.getFileName());
				}
				
				count = eventBoardDao.eventBoardDelete(bbsSeq);	
			}
			return count;
		}
	
		
		//게시물 수정
		@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)	
		public int eventBoardUpdate(EventBoard eventBoard) throws Exception	
		{
			int count = eventBoardDao.eventBoardUpdate(eventBoard);
			
			if(count > 0 && eventBoard.getEventBoardFile() != null)
			{
				EventBoardFile delEventBoardFile = eventBoardDao.eventBoardFileSelect(eventBoard.getBbsSeq());
				
				//기존파일이 있으면 삭제
				if(delEventBoardFile != null)
				{
					FileUtil.deleteFile(UPLOADEVENT_SAVE_DIR + FileUtil.getFileSeparator() + delEventBoardFile.getFileName());
					
					eventBoardDao.eventBoardFileDelete(eventBoard.getBbsSeq());
				}
				
				EventBoardFile eventBoardFile = eventBoard.getEventBoardFile();
				
				eventBoardFile.setBbsSeq(eventBoard.getBbsSeq());
				eventBoardFile.setFileNum((short)1);
				
				eventBoardDao.eventBoardFileInsert(eventBoardFile);
			}
			
			return count;
		}
				
		
		//Public 업데이트			
		public int eventPublicUpdate()	
		{
			int count = 0;
			
			try
			{
				count = eventBoardDao.eventPublicUpdate();
			}
			catch(Exception e)
			{
				logger.error("[EventBoardService] eventBoardPublicUpdate Exception", e);
			}
			
			return count;
		}
		
		
		//첨부 이미지 조회
		public EventBoardFile eventBoardFileSelect(long bbsSeq)
		{
			EventBoardFile eventBoardFile = null;
			
			try {
				eventBoardFile = eventBoardDao.eventBoardFileSelect(bbsSeq);
			}
			catch(Exception e){
				logger.error("[EventBoardService] eventBoardFileSelect Exception", e);
			}
			
			return eventBoardFile;
		}	
}

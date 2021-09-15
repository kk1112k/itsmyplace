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
import com.icia.itsmyplace.dao.NoticeDao;
import com.icia.itsmyplace.model.Notice;
import com.icia.itsmyplace.model.NoticeFile;

@Service("noticeService")
public class NoticeService {
	private static Logger logger = LoggerFactory.getLogger(NoticeService.class);
	   
   //파일 저장 디렉토리
   @Value("#{env['uploadNotice.save.dir']}")
   private String UPLOADNOTICE_SAVE_DIR;
   
   @Autowired
   private NoticeDao noticeDao;
   
   //게시물 등록
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   public int noticeInsert(Notice notice) throws Exception
   {
      int count = noticeDao.noticeInsert(notice);
      
      //게시물 정상 등록 되고, 첨부파일이 있다면 첨부파일 등록
      if(count > 0 && notice.getNoticeFile() != null)
      {
    	 NoticeFile noticeFile = notice.getNoticeFile();
         
         noticeFile.setBbsSeq(notice.getBbsSeq());
         noticeFile.setFileNum((short)1);
         
         noticeDao.noticeFileInsert(notice.getNoticeFile());
      }
      
      return count;
   }
   
   //게시물 리스트
   public List<Notice> noticeList(Notice notice)
   {
      List<Notice> list = null;
      
      try
      {
         list = noticeDao.noticeList(notice);
      }
      catch(Exception e)
      {
         logger.error("[NoticeService] noticeList Exception", e);
      }
      
      return list;
   }
   
   //총 게시물 수
   public long noticeListCount(Notice notice)
   {
      long count = 0;
      
      try
      {
         count = noticeDao.noticeListCount(notice);
      }
      catch(Exception e)
      {
         logger.error("[NoticeService] noticeListCount Exception", e);
      }
      
      return count;
   }
   
   //게시물 보기
   public Notice noticeView(long bbsSeq)
   {
      Notice notice = null;
      
      try
      {
         notice = noticeDao.noticeSelect(bbsSeq);
         
         if(notice != null)
         {
            //조회수 증가
        	noticeDao.noticeReadCntPlus(bbsSeq);
            
            //첨부파일 조회
        	NoticeFile noticeFile = noticeDao.noticeFileSelect(bbsSeq);
            
            if(noticeFile != null)
            {
            	notice.setNoticeFile(noticeFile);
            }
         }
         
      }
      catch(Exception e)
      {
         logger.error("[NoticeService] noticeView Exception", e);
      }
      
      return notice;
   }
   
   //게시물 조회
   public Notice noticeSelect(long bbsSeq) {
	   Notice notice = null;
	   
	   try {
		   notice = noticeDao.noticeSelect(bbsSeq);
	   } catch(Exception e) {
		   logger.error("[NoticeService] noticeSelect Exception", e);
	   }
	   return notice;
   }
   
   //첨부파일 조회
   public NoticeFile noticeFileSelect(long bbsSeq) {
	   NoticeFile noticeFile = null;
	   
	   try {
		   noticeFile = noticeDao.noticeFileSelect(bbsSeq);
	   } catch(Exception e) {
		   logger.error("[NoticeService] noticeFileSelect Exception", e);
	   }
	   
	   return noticeFile;
   }
   
   //게시물 삭제(파일이 있으면 같이 삭제)
   //@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   public int noticeDelete(long bbsSeq)// throws Exception
   {
      int count = 0;
      
      try {
    	  count = noticeDao.noticeDelete(bbsSeq);
      }
      catch(Exception e) {
    	  logger.error("[noticeService] noticeDelete Exception", e);
      }
      
      return count;
   }
   
   public int noticeFileDelete(long bbsSeq)// throws Exception
   {
      int count = 0;
      
      try {
    	  count = noticeDao.noticeFileDelete(bbsSeq);
      }
      catch(Exception e) {
    	  logger.error("[noticeService] noticeDelete Exception", e);
      }
      
      return count;
   }
   
   //게시물 수정
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   public int noticeUpdate(Notice notice) throws Exception
   {
      int count = noticeDao.noticeUpdate(notice);
      
      if(count > 0 && notice.getNoticeFile() != null)
      {
    	 NoticeFile delNoticeFile = noticeDao.noticeFileSelect(notice.getBbsSeq());
         
         //기존 파일이 있으면 삭제
         if(delNoticeFile != null)
         {
            FileUtil.deleteFile(UPLOADNOTICE_SAVE_DIR + FileUtil.getFileSeparator() + delNoticeFile.getFileName());
            
            noticeDao.noticeFileDelete(notice.getBbsSeq());
         }
         
         NoticeFile noticeFile = notice.getNoticeFile();
         
         noticeFile.setBbsSeq(notice.getBbsSeq());
         noticeFile.setFileNum((short)1);
         
         noticeDao.noticeFileInsert(noticeFile);
      }
      else
      {
         
      }
      
      return count;
   }
   
   
}

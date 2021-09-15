package com.icia.itsmyplace.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.itsmyplace.dao.AdminBoardDao;
import com.icia.itsmyplace.model.Notice;
import com.icia.itsmyplace.model.Refund;
import com.icia.itsmyplace.model.EventBoard;
import com.icia.itsmyplace.model.Cs;
import com.icia.itsmyplace.model.Comm;
import com.icia.itsmyplace.model.CommCmt;
import com.icia.itsmyplace.model.Review;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.User;

@Service("adminBoardService")
public class AdminBoardService {
		private static Logger logger = LoggerFactory.getLogger(AdminBoardService.class);
		
		@Autowired
		private AdminBoardDao adminBoardDao;
		
      public List<RsRv> cafeList(RsRv rsRv) 
      {
         List<RsRv> list0 = null;
         
         try 
         {
            list0 = adminBoardDao.cafeList(rsRv);
         }
         
         catch(Exception e)
         {
            logger.error("[adminBoardService] cafeList Exception", e);
         }
         return list0;
      }
      public List<RsRv> cafe1List(RsRv rsRv) 
         {
            List<RsRv> list1 = null;
            
            try 
            {
               list1 = adminBoardDao.cafe1List(rsRv);
            }
            
            catch(Exception e)
            {
               logger.error("[adminBoardService] cafe1List Exception", e);
            }
            return list1;
         }
      
      public List<RsRv> cafe2List(RsRv rsRv) 
         {
            List<RsRv> list2 = null;
            
            try 
            {
               list2 = adminBoardDao.cafe2List(rsRv);
            }
            
            catch(Exception e)
            {
               logger.error("[adminBoardService] cafe2List Exception", e);
            }
            return list2;
         }
      
      public List<RsRv> cafe3List(RsRv rsRv) 
         {
            List<RsRv> list3 = null;
            
            try 
            {
               list3 = adminBoardDao.cafe3List(rsRv);
            }
            
            catch(Exception e)
            {
               logger.error("[adminBoardService] cafe3List Exception", e);
            }
            return list3;
         }
      
      public List<RsRv> cafe4List(RsRv rsRv) 
         {
            List<RsRv> list4 = null;
            
            try 
            {
               list4 = adminBoardDao.cafe4List(rsRv);
            }
            
            catch(Exception e)
            {
               logger.error("[adminBoardService] cafe4List Exception", e);
            }
            return list4;
         }
      
      public List<RsRv> user1List(RsRv rsRv) 
         {
            List<RsRv> list5 = null;
            
            try 
            {
               list5 = adminBoardDao.user1List(rsRv);
            }
            
            catch(Exception e)
            {
               logger.error("[adminBoardService] user1List Exception", e);
            }
            return list5;
         }
      
      
      
      public List<RsRv> totalList(RsRv rsRv) 
      {
         List<RsRv> list6 = null;
         
         try 
         {
            list6 = adminBoardDao.totalList(rsRv);
         }
         
         catch(Exception e)
         {
            logger.error("[adminBoardService] totalList Exception", e);
         }
         return list6;
      }	
		
		//Notice
		//게시물 전체 수 조회
		public int noticeListCount(Notice notice)
		{
			int count = 0;
			
			try
			{
				count = adminBoardDao.noticeListCount(notice);
			}
			catch(Exception e)
			{
				logger.error("[adminBoardService] noticeListCount Exception", e);
			}
			
			return count;
		}
		
		//Notice
		//게시물 리스트
		public List<Notice> noticeList(Notice notice)
		{
			List<Notice> list = null;
			
			try
			{
				list = adminBoardDao.noticeList(notice);
			}
			catch(Exception e)
			{
				logger.error("[adminBoardService] noticeList Exception", e);
			}
			
			return list;
		}
		
		
		//Event
		//게시물 전체 수 조회
		public int EventBoardListCount(EventBoard eventBoard)
		{
			int count = 0;
			
			try
			{
				count = adminBoardDao.eventBoardListCount(eventBoard);
			}
			catch(Exception e)
			{
				logger.error("[adminBoardService] EventBoardListCount Exception", e);
			}
			
			return count;
		}
		
		//Event
		//게시물 리스트
		public List<EventBoard> EventBoardList(EventBoard eventBoard)
		{
			List<EventBoard> list = null;
			
			try
			{
				list = adminBoardDao.eventBoardList(eventBoard);
			}
			catch(Exception e)
			{
				logger.error("[adminBoardService] EventBoardList Exception", e);
			}
			
			return list;
		}
		
		//Event
		//이벤트 관리자 차단
	   public int EventBoardAdminPublicUpdate(EventBoard eventBoard)
	   {
	      int count = 0;
	      
	      try
	      {
	         count = adminBoardDao.eventBoardAdminPublicUpdate(eventBoard);
	      }
	      catch(Exception e)
	      {
	         logger.error("[AdminBoardService] EventBoardAdminPublicUpdate Exception", e);
	      }
	      
	      return count;
	   }   
		
		
		
		//Review
		//게시물 전체 수 조회
		public int ReviewListCount(Review review)
		{
			int count = 0;
			
			try
			{
				count = adminBoardDao.reviewListCount(review);
			}
			catch(Exception e)
			{
				logger.error("[adminBoardService] ReviewListCount Exception", e);
			}
			
			return count;
		}
		
		//Review
		//게시물 리스트
		public List<Review> ReviewList(Review review)
		{
			List<Review> list = null;
			
			try
			{
				list = adminBoardDao.reviewList(review);
			}
			catch(Exception e)
			{
				logger.error("[adminBoardService] ReviewList Exception", e);
			}
			
			return list;
		}
		
		//Review
		//리뷰 관리자 차단
		   public int ReviewAdminPublicUpdate(Review review)
		   {
		      int count = 0;
		      
		      try
		      {
		         count = adminBoardDao.reviewAdminPublicUpdate(review);
		      }
		      catch(Exception e)
		      {
		         logger.error("[AdminBoardService] ReviewAdminPublicUpdate Exception", e);
		      }
		      
		      return count;
		   }   
		
		
		
		//cs
		//게시물 리스트 카운트
		public int CsListCount(Cs cs)
		{
			int count = 0;
			
			try
			{
				count = adminBoardDao.csListCount(cs);
			}
			catch(Exception e)
			{
				logger.error("[adminBoardService] CsListCount Exception", e);
			}
			
			return count;
		}
		
		
		//cs
		//게시물 리스트
		public List<Cs> CsList(Cs cs)
		{
			List<Cs> list = null;
			
			try
			{
				list = adminBoardDao.csList(cs);
			}
			catch(Exception e)
			{
				logger.error("[adminBoardService] CsList Exception", e);
			}
			
			return list;
		}
		
		//Review
		//리뷰 관리자 차단
		   public int csAdminPublicUpdate(Cs cs)
		   {
		      int count = 0;
		      
		      try
		      {
		         count = adminBoardDao.csAdminPublicUpdate(cs);
		      }
		      catch(Exception e)
		      {
		         logger.error("[AdminBoardService] csAdminPublicUpdate Exception", e);
		      }
		      
		      return count;
		   }   
		
		
		
		
		
		//comm
		//게시물 리스트 카운트
		public long CommListCount(Comm comm)
		{
			long count = 0;
			
			try
			{
				count = adminBoardDao.commListCount(comm);
			}
			catch(Exception e)
			{
				logger.error("[adminBoardService] CommListCount Exception", e);
			}
			
			return count;
		}
		
		
		//comm
		//게시물 리스트
		public List<Comm> commList(Comm comm)
		{
			List<Comm> list = null;
			
			try
			{
				list = adminBoardDao.commList(comm);
			}
			catch(Exception e)
			{
				logger.error("[adminBoardService] CommList Exception", e);
			}
			
			return list;
		}
		
		//Comm
		//커뮤니티 관리자 차단
	   public int commAdminPublicUpdate(Comm comm)
	   {
	      int count = 0;
	      
	      try
	      {
	         count = adminBoardDao.commAdminPublicUpdate(comm);
	      }
	      catch(Exception e)
	      {
	         logger.error("[AdminBoardService] CommAdminPublicUpdate Exception", e);
	      }
	      
	      return count;
	   }   
		
	 //comm
	//게시물 리스트 카운트
	public long commCmtListCount(CommCmt commCmt)
	{
		long count = 0;
		
		try
		{
			count = adminBoardDao.commCmtListCount(commCmt);
		}
		catch(Exception e)
		{
			logger.error("[adminBoardService] commCmtListCount Exception", e);
		}
		
		return count;
	}
	   
	   
	   
	 //commCmt
	 //게시물 리스트
 	 public List<CommCmt> commCmtList(CommCmt commCmt)
     {
 		 List<CommCmt> list = null;
		
		try
		{
			list = adminBoardDao.commCmtList(commCmt);
		}
		catch(Exception e)
		{
			logger.error("[adminBoardService] CommCmtList Exception", e);
		}
		
		return list;
	}
	   
 	 	//CommCmt
		//커뮤니티 댓글 관리자 차단
	   public int commCmtAdminPublicUpdate(CommCmt commCmt)
	   {
	      int count = 0;
	      
	      try
	      {
	         count = adminBoardDao.commCmtAdminPublicUpdate(commCmt);
	      }
	      catch(Exception e)
	      {
	         logger.error("[AdminBoardService] CommCmtAdminPublicUpdate Exception", e);
	      }
	      
	      return count;
	   } 
	   
	   
	   
	   
		
		public List<RsRv> rsRvList(RsRv rsRv) 
	   {
	      List<RsRv> list = null;
	      
	      try 
	      {
	         list = adminBoardDao.rsRvList(rsRv);
	      }
	      
	      catch(Exception e)
	      {
	         logger.error("[adminBoardService] rsRvList Exception", e);
	      }
	      return list;
	   }
	   
	   //게시물 리스트 카운트
	   public long rsRvListCount(RsRv rsRv)
	   {
	      long count = 0;
	      
	      try
	      {
	         count = adminBoardDao.rsRvListCount(rsRv);
	      }
	      catch(Exception e)
	      {
	         logger.error("[adminBoardService] rsRvListCount Exception", e);
	      }
	      
	      return count;
	   }
	   
	   public List<Refund> refundList(Refund refund) 
	   {
	      List<Refund> list = null;
	      
	      try 
	      {
	         list = adminBoardDao.refundList(refund);
	      }
	      
	      catch(Exception e)
	      {
	         logger.error("[adminBoardService] refundList Exception", e);
	      }
	      return list;
	   }
	   
	   //게시물 리스트 카운트
	   public long refundListCount(Refund refund)
	   {
	      long count = 0;
	      
	      try
	      {
	         count = adminBoardDao.refundListCount(refund);
	      }
	      catch(Exception e)
	      {
	         logger.error("[adminBoardService] refundListCount Exception", e);
	      }
	      
	      return count;
	   }
}

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
import com.icia.common.util.FileUtil;
import com.icia.itsmyplace.dao.ReviewDao;
import com.icia.itsmyplace.model.CommPht;
import com.icia.itsmyplace.model.Pay;
import com.icia.itsmyplace.model.Review;
import com.icia.itsmyplace.model.ReviewPht;

@Service("reviewService")
public class ReviewService
{
	private static Logger logger = LoggerFactory.getLogger(ReviewService.class);
 
	@Autowired
	private ReviewDao reviewDao;
	
	//리뷰 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewInsert(Review review) throws Exception
	{
		int count = reviewDao.reviewInsert(review);
		
		List<ReviewPht> reviewPhtList = review.getReviewPhtList();
		
		//게시물 정상 등록 되고, 첨부파일이 있다면 첨부파일 등록
		if(count > 0 && reviewPhtList != null)
		{
			for(int i = 0; i < reviewPhtList.size(); i++)
			{
				reviewDao.reviewPhtInsert(reviewPhtList.get(i));
			}
		}
		
		if(count > 0)
		{
			reviewDao.payStatusUpdate(review.getRsrvSeq());
		}
      
		return count;
	}
	
	//카페 별 리뷰 조회
	public List<Review> cafeReviewList(String cafeNum)
	{
		List<Review> cafe = null;
      
		try
		{
			cafe = reviewDao.cafeReviewList(cafeNum);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] cafeReviewList Exception", e);
		}
      
		return cafe;
	}
	
	//카페 모아보기 리뷰 조회
	public List<Review> allCafeReviewList(String cafeNum)
	{
		List<Review> cafeList = null;
	      
		try
		{
			cafeList = reviewDao.allCafeReviewList(cafeNum);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] allCafeReviewList Exception", e);
		}
		
		return cafeList;
	}
   
	//리뷰 전체 리스트
	public List<Review> reviewList(Review review)
	{
		List<Review> list = null;
      
		try
		{
			list = reviewDao.reviewList(review);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewList Exception", e);
		}
      
		return list;
	}
	   
   //총 리뷰 개수
   public long reviewListCount(Review review)
   {
      long count = 0;
      
      try
      {
         count = reviewDao.reviewListCount(review);
      }
      catch(Exception e)
      {
         logger.error("[ReviewService] reviewListCount Exception", e);
      }
      
      return count;
   }
   
   //리뷰 조회
   public Review reviewSelect(long rsrvSeq)
   {
	   Review review = null;
	   
	   try
	   {
		   review = reviewDao.reviewSelect(rsrvSeq);
	   } 
	   catch(Exception e)
	   {
		   logger.error("[ReviewService] reviewSelect Exception", e);
	   }
	   
	   return review;
   }

   //리뷰 수정(업데이트)
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class) //테이블 2개 걸기 위해 트랜잭션 사용
   public int reviewUpdate(Review review, List<FileData> fileData) throws Exception
   {
	   int count = reviewDao.reviewUpdate(review);
	   
	   List<ReviewPht> reviewPhtList = reviewDao.modalPhtList(review.getRsrvSeq());
	   
	   int phtListCnt = reviewPhtList.size();
	   
	   int fileDataCnt = 0;
	   
	   if(fileData != null)
		{
			fileDataCnt = fileData.size();
		}
				
		try
		{			
			count = reviewDao.reviewUpdate(review);		
			
			if(count > 0 &&  fileDataCnt > 0)
			{					
				for(int i=0; i<fileDataCnt; i++)
				{
					reviewDao.reviewPhtInsert(review.getReviewPhtList().get((i)+phtListCnt));
				}
			}
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewUpdate Exception", e);
		}
				
		return count;
   }  

   //게시물 삭제(파일이 있으면 같이 삭제)
   @Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
   public int reviewDelete(long rsrvSeq) throws Exception
   {
	   int count = 0;
	   
	   Review review = reviewDao.reviewSelect(rsrvSeq);
	   
	   if(review != null)
	   {
			List<ReviewPht> reviewPhtList = reviewDao.modalPhtList(rsrvSeq);
			   
			if(reviewPhtList != null)
			{
			   //테이블 삭제, 파일 삭제
				reviewDao.reviewPhtDeleteAll(rsrvSeq);
				/*
				 * if(reviewDao.reviewPhtDeleteAll(rsrvSeq) > 0) {
				 * FileUtil.deleteFile(UPLOADREVIEW_SAVE_DIR + FileUtil.getFileSeparator() +
				 * reviewPhtList.getPhtName()); }
				 */
			}
		   
			count = reviewDao.reviewDelete(rsrvSeq);
	   }
	   
	   return count;
   }
   
	//게시글 첨부사진 전부 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewPhtDeleteAll(long rsrvSeq) {
		
		int count = 0;
		
		try
		{
			count = reviewDao.reviewPhtDeleteAll(rsrvSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewPhtDeleteAll Exception", e);
		}
		
		return count;
	}
	
	//게시글 첨부사진 개별 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewPhtDelete(ReviewPht reviewPht) {
		
		int count = 0;
		
		try
		{
			count = reviewDao.reviewPhtDelete(reviewPht);

		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewPhtDelete Exception", e);
		}
		
		return count;
		
	}
   
   //리뷰 사진 리스트
   public List<ReviewPht> modalPhtList(long rsrvSeq)
   {
	   
	   List<ReviewPht> modalPhtList = null;
	   
	   try
	   {
		   modalPhtList = reviewDao.modalPhtList(rsrvSeq);
	   } 
	   catch(Exception e)
	   {
		   logger.error("[ReviewService] modalPhtList Exception", e);
	   }
	   
	   return modalPhtList;
   }
   
   
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewPhtUpdate(ReviewPht reviewPht) {
		
		int count = 0;
		
		try
		{
			count = reviewDao.reviewPhtUpdate(reviewPht);

		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewPhtUpdate Exception", e);
		}
		
		return count;
		
	}
		
   //인덱스 리뷰 리스트
    public List<Review> reviewList2(Review review)
    {
       List<Review> list = null;
       
       try
       {
          list = reviewDao.reviewList2(review);
       }
       catch(Exception e)
       {
          logger.error("[ReviewService] reviewList2 Exception", e);
       }
       
       return list;
    }
	   
}

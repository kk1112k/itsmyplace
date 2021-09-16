package com.icia.itsmyplace.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Pay;
import com.icia.itsmyplace.model.Review;
import com.icia.itsmyplace.model.ReviewPht;

@Repository("reviewDao")
public interface ReviewDao
{
	//리뷰 등록
	public int reviewInsert(Review review);
	
	//리뷰 사진 등록
	public int reviewPhtInsert(ReviewPht reviewPht);
	
	//리뷰 리스트 총개수
	public long reviewListCount(Review review);
	
	public List<Review> reviewList(Review review);
	public List<Review> reviewList2(Review review);
	
	//리뷰 조회
	public Review reviewSelect(long rsrvSeq);
	
	//리뷰 사진 조회
	public ReviewPht reviwPhtSelect(long rsrvSeq);
	
	//리뷰 수정(업데이트)
	public int reviewUpdate (Review review);
	
	//게시물 개별 삭제
	public int reviewPhtDelete(ReviewPht reviewPht);
	
	//게시물 전체 삭제(전체)
	public int reviewPhtDeleteAll(long rsrvSeq);
	
	//게시글 삭제
	public int reviewDelete(long rsrvSeq);
	
	//첨부사진 리스트
	public List<ReviewPht> modalPhtList(long rsrvSeq);
	
	//결제단계 조정
	public int payStatusUpdate(long rsrvSeq);
	
	//게시물 첨부사진 삭제후 phtNum 업데이트
	public int reviewPhtUpdate(ReviewPht reviewPht);
	
	//카페별 후기 조회
	public List<Review> cafeReviewList(String cafeNum);
	
	//입점카페 모아보기 리뷰 리스트
	public List<Review> allCafeReviewList(String cafeNum);
	
	

}

package com.icia.itsmyplace.dao;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Notice;
import com.icia.itsmyplace.model.Refund;
import com.icia.itsmyplace.model.EventBoard;
import com.icia.itsmyplace.model.Cs;
import com.icia.itsmyplace.model.Comm;
import com.icia.itsmyplace.model.CommCmt;
import com.icia.itsmyplace.model.Review;
import com.icia.itsmyplace.model.RsRv;


@Repository("adminBoardDao")
public interface AdminBoardDao {

	public List<RsRv> cafeList(RsRv rsRv);
	   
    public List<RsRv> cafe1List(RsRv rsRv);
    
    public List<RsRv> cafe2List(RsRv rsRv);
   
    public List<RsRv> cafe3List(RsRv rsRv);
    
    public List<RsRv> cafe4List(RsRv rsRv);
   
    public List<RsRv> user1List(RsRv rsRv);
   
    public List<RsRv> totalList(RsRv rsRv);

   
	
	//Notice
	//게시물 전체 수 조회
	public int noticeListCount(Notice notice);
	
	//Notice	
	//게시물 리스트
	public List<Notice> noticeList(Notice notice);
	
	//Event
	//게시물 전체 수 조회
	public int eventBoardListCount(EventBoard eventBoard);
	
	//Event	
	//게시물 리스트
	public List<EventBoard> eventBoardList(EventBoard eventBoard);
	
	//Event
	//게시물 관리자 차단
	public int eventBoardAdminPublicUpdate(EventBoard eventBoard);
	
	//Review
	//게시물 전체 수 조회
	public int reviewListCount(Review review);
	
	//Review	
	//게시물 리스트
	public List<Review> reviewList(Review review);
	
	//Reveiw
	//리뷰 게시물 관리자 차단
	public int reviewAdminPublicUpdate(Review review);
	
	//Cs
	//게시물 전체 수 조회
	public int csListCount(Cs cs);
	
	//Cs	
	//게시물 리스트
	public List<Cs> csList(Cs cs);
	
	//Cs
	//고객센터 게시물 관리자 차단
	public int csAdminPublicUpdate(Cs cs);
	
	//comm
	//게시물 전체 수 조회
	public int commListCount(Comm comm);
	
	//comm	
	//게시물 리스트
	public List<Comm> commList(Comm comm);
	
	//comm
	//커뮤니티 게시물 관리자 차단
	public int commAdminPublicUpdate(Comm comm);
	
	//commCmt
	//게시물 댓글 전체 수 조회
	public int commCmtListCount(CommCmt commCmt);
	
	//commCmt	
	//게시물 댓글 리스트
	public List<CommCmt> commCmtList(CommCmt commCmt);
	
	//comm
	//커뮤니티 댓글 관리자 차단
	public int commCmtAdminPublicUpdate(CommCmt commCmt);
	
	//rsrv
	//예약 조회
	public long rsRvListCount(RsRv rsRv);
	
	//rsrv   
	//예약 리스트
	public List<RsRv> rsRvList(RsRv rsRv);
	
	//refund
	//환불 조회
	public long refundListCount(Refund refund);
		
	//refund
	//환불 조회
	public List<Refund> refundList(Refund refund);
	
	}

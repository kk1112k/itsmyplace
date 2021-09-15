package com.icia.itsmyplace.service;

import java.util.List;

//import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.itsmyplace.dao.MyPageDao;
import com.icia.itsmyplace.dao.OrderDao;
import com.icia.itsmyplace.model.Cafe;
import com.icia.itsmyplace.model.CommCmt;
import com.icia.itsmyplace.model.MyPage;
import com.icia.itsmyplace.model.Order;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.model.UserPostList;

@Service("myPageService")
public class MyPageService {
	
	private static Logger logger = LoggerFactory.getLogger(MyPageService.class);
	
	@Autowired
	private MyPageDao myPageDao;
	
	@Autowired
	private OrderDao orderDao;
	
	//결제정보 불러오기
	public MyPage myOrderInfo(User user) {
		MyPage myPage = null;
		try {
			myPage = myPageDao.myOrderInfo(user);
		}
		catch(Exception e){
			logger.error("[MyPageService] myOrderInfo Exception", e);
		}
		return myPage;
	}
	
	public MyPage myOrderDetail(long rsrvSeq) {
		MyPage myPage = null;
		try {
			myPage = myPageDao.myOrderDetail(rsrvSeq);
		}
		catch(Exception e) {
			logger.error("[MyPageService] myOrderInfo Exception", e);
		}
		return myPage;
	}
	
	public List<Order> myOrderList(long rsrvSeq){
		List<Order> list = null;
		
		try
		{
			list = orderDao.myOrderList(rsrvSeq);
		}
		catch(Exception e) {
			logger.error("[MyPageService] myOrderList Exception", e);
		}
		
		return list;
		
	}
	
	
	//내 게시물 리스트
	public List<UserPostList> userPostList(UserPostList post)
	{
		List<UserPostList> list = null;
		
		try
		{
			list = myPageDao.userPostList(post);
		}
		catch(Exception e)
		{
			logger.error("[MyPageService] UserPostList Exception", e);
		}
		
		return list;
	}
	
	// 게시물 리스트 카운트
	public long userPostListCount(String userId)
	{
		long count = 0;
		
		try
		{
			count = myPageDao.userPostListCount(userId);
		}
		catch(Exception e)
		{
			logger.error("[MyPageService] userPostListCount Exception", e);
		}
		
		return count;
	}
	
	//내 리뷰 리스트
	public List<UserPostList> userReviewPostList(UserPostList post)
	{
		List<UserPostList> list = null;
		
		try
		{
			list = myPageDao.userReviewPostList(post);
		}
		catch(Exception e)
		{
			logger.error("[MyPageService] userReviewPostList Exception", e);
		}
		
		return list;
	}
	
	// 리뷰 리스트 카운트
	public long userReviewPostListCount(String userId)
	{
		long count = 0;
		
		try
		{
			count = myPageDao.userReviewPostListCount(userId);
		}
		catch(Exception e)
		{
			logger.error("[MyPageService] userReviewPostListCount Exception", e);
		}
		
		return count;
	}
	
	//체크박스 조회
	public UserPostList chkListSelect(long bbsSeq)
	{
		UserPostList userPostList  = null;
		
		try
		{
			userPostList = myPageDao.chkListSelect(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[CommService] commCmtSelect Exception", e);
		}
		
		return userPostList;
	}
	
	//체크박스 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int chkDelete(long bbsSeq)
	{
		int count = 0;
		
		try
		{
			count = myPageDao.chkDelete(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[MyPageService] chkDelete Exception", e);
		}
		
		return count;
	}
	
	//체크박스 조회
	public UserPostList chkReviewSelect(long rsrvSeq)
	{
		UserPostList userPostList  = null;
		
		try
		{
			userPostList = myPageDao.chkReviewSelect(rsrvSeq);
		}
		catch(Exception e)
		{
			logger.error("[MyPageService] chkReviewSelect Exception", e);
		}
		
		return userPostList;
	}
	
	//체크박스 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int chkReviewDelete(long rsrvSeq)
	{
		int count = 0;
		
		try
		{
			count = myPageDao.chkReviewDelete(rsrvSeq);
		}
		catch(Exception e)
		{
			logger.error("[MyPageService] chkReviewDelete Exception", e);
		}
		
		return count;
	}
		
	
	//마이페이지 카페관리자 예약현황 조회용
	public List<RsRv> myCafeRsrvList(RsRv rsrv)
	{
		List<RsRv> rsrvList = null;
		
		try
		{
			rsrvList = myPageDao.myCafeRsrvList(rsrv);
		}
		catch(Exception e)
		{
			logger.error("[MyPageService] myCafeRsrvList Exception", e);
		}
		
		return rsrvList;
	}
	
	//마이페이지 카페관리자 예약현황 조회용
	public long myCafeRsrvCnt(String userId)
	{
		long count = 0;
		
		try
		{
			count = myPageDao.myCafeRsrvCnt(userId);
		}
		catch(Exception e)
		{
			logger.error("[MyPageService] myCafeRsrvCnt Exception", e);
		}
		
		return count;
	}
	
	//마이페이지 카페관리자 예약현황 조회용
	public Cafe myCafeSelect(String userId)
	{
		Cafe cafe = null;
		
		try
		{
			cafe = myPageDao.myCafeSelect(userId);
		}
		catch(Exception e)
		{
			logger.error("[MyPageService] myCafeSelect Exception", e);
		}
		
		return cafe;
	}
}

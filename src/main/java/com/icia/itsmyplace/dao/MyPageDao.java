package com.icia.itsmyplace.dao;

import java.util.List;

//import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Cafe;
import com.icia.itsmyplace.model.MyPage;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.model.UserPostList;

@Repository("myPageDao")
public interface MyPageDao {
	public MyPage myOrderInfo(User user);
	public MyPage myOrderDetail(long rsrvSeq);
	
	public List<UserPostList> userPostList(UserPostList comm);
	public long userPostListCount(String userId);
	
	public List<UserPostList> userReviewPostList(UserPostList review);
	public long userReviewPostListCount(String userId);
	
	public UserPostList chkListSelect(long bbsSeq);
	public UserPostList chkReviewSelect(long rsrvSeq);
	public int chkDelete(long bbsSeq);
	public int chkReviewDelete(long rsrvSeq);
	
	//마이페이지 카페관리자 예약현황 조회용
	public List<RsRv> myCafeRsrvList(RsRv rsrv);
	public long myCafeRsrvCnt(String userId);
	public Cafe myCafeSelect(String userId);
}

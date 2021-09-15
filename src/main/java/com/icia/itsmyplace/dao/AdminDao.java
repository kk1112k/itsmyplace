package com.icia.itsmyplace.dao;
import java.util.List;

import org.springframework.stereotype.Repository;


import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.model.Notice;
import com.icia.itsmyplace.model.Point;
import com.icia.itsmyplace.model.RsRv;


@Repository("adminDao")
public interface AdminDao {
   //////////
   //유저관련//
   //////////
   
   //사용자 전체 수 조회
   public int userListCount(User user);
   
   //사용자 리스트
   public List<User> userList(User user);
   
   //사용자 수정을 위한 조회
   public User userSelect(String userId);
   
   //사용자 정보 수정
   public int userUpdate(User user);
   
   
   /////////
   //포인트//
   /////////
   
   //포인트 내역 전체 수 조회
   public int pointListCount(Point point);
   
   //사용자 리스트
   public List<Point> pointList(Point point);
      
   //포인트 적립
   public int userPointRewardUpdate(User user);
    
   //포인트 지급 목록
   public int userPointInsert(Point point);
    
    
    //RSRV
	//예약 전체 수 조회
	public int rsrvListCount(RsRv rsrv);
	
	//RSRV	
	//예약 리스트
	public List<RsRv> rsrvList(RsRv rsrv);
    
}
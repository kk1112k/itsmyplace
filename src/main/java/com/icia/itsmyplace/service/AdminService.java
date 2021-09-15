package com.icia.itsmyplace.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;
import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.dao.AdminDao;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.model.Point;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.RsRv;


@Service("adminService")
public class AdminService {
   private static Logger logger = LoggerFactory.getLogger(AdminService.class);
   
   @Autowired
   private AdminDao adminDao;
   
   //사용자 전체 수 조회
   public int userListCount(User user)
   {
      int count = 0;
      
      try
      {
         count = adminDao.userListCount(user);
      }
      catch(Exception e)
      {
         logger.error("[adminService] userListCount Exception", e);
      }
      
      return count;
   }
   
   //사용자 리스트
   public List<User> userList(User user)
   {
      List<User> list = null;
      
      try
      {
         list = adminDao.userList(user);
      }
      catch(Exception e)
      {
         logger.error("[adminService] userList Exception", e);
      }
      
      return list;
   }
   
   //사용자 조회
   public User userSelect(String userId)
   {
      User user = null;
      
      try
      {
         user = adminDao.userSelect(userId);
      }
      catch(Exception e)
      {
         logger.error("[adminService] userSelect Exception", e);
      }
      
      return user;
   }
   
   //사용자 정보 수정[김호준]
   public int userUpdate(User user)
   {
      int count = 0;
      
      try
      {
         count = adminDao.userUpdate(user);
      }
      catch(Exception e)
      {
         logger.error("[AdminService] userUpdate Exception", e);
      }
      
      return count;
   }   
      
   // 포인트 관련
   
   //사용자 전체 수 조회
   public int pointListCount(Point point)
   {
      int count = 0;
      
      try
      {
         count = adminDao.pointListCount(point);
      }
      catch(Exception e)
      {
         logger.error("[adminService] pointListCount Exception", e);
      }
      
      return count;
   }
   
   //사용자 리스트
   public List<Point> pointList(Point point)
   {
      List<Point> list = null;
      
      try
      {
         list = adminDao.pointList(point);
      }
      catch(Exception e)
      {
         logger.error("[adminService] pointList Exception", e);
      }
      
      return list;
   }
   
   public int userPointRewardUpdate(User user)
   {
      int count = 0;
      
      try
      {
         count = adminDao.userPointRewardUpdate(user);
      }
      catch(Exception e)
      {
         logger.error("[AdminService] userPointRewardUpdate Exception", e);
      }
      
      return count;
   } 
   
   public int userPointInsert(Point point)
   {
      int count = 0;
      
      try
      {
         count = adminDao.userPointInsert(point);
      }
      catch(Exception e)
       {
            logger.error("[AdminService] userPointInsert Exception", e);
       }
         
         return count;
   }
   
   
   
   
   //예약리스트 전체 수 조회
   public int rsrvListCount(RsRv rsrv)
   {
      int count = 0;
      
      try
      {
         count = adminDao.rsrvListCount(rsrv);
      }
      catch(Exception e)
      {
         logger.error("[adminService] rsrvListCount Exception", e);
      }
      
      return count;
   }
   
   //예약 리스트
   public List<RsRv> rsrvList(RsRv rsrv)
   {
      List<RsRv> list = null;
      
      try
      {
         list = adminDao.rsrvList(rsrv);
      }
      catch(Exception e)
      {
         logger.error("[adminService] rsrvList Exception", e);
      }
      
      return list;
   }
   
}
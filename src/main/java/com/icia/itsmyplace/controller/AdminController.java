package com.icia.itsmyplace.controller;



import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.Notice;
import com.icia.itsmyplace.model.Paging;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.model.Point;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.service.AdminService;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;



@Controller("adminController")
public class AdminController
{
   private static Logger logger = LoggerFactory.getLogger(AdminController.class);

   @Autowired
   private AdminService adminService;
   
   private static final int LIST_COUNT = 5;
   private static final int PAGE_COUNT = 5;   
   
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
       
   

   @RequestMapping(value = "/admin/userWrite", method=RequestMethod.GET)
   public String userWrite(HttpServletRequest request, HttpServletResponse response)
   {
      return "/admin/userWrite";
   }
   
   @RequestMapping(value = "/admin/userList", method=RequestMethod.GET)
   public String userList(Model model, HttpServletRequest request, HttpServletResponse response)
   {
      String status = HttpUtil.get(request, "status");
      int curPage = HttpUtil.get(request, "curPage", 1);
      
      //총 사용자 수
      int totalCount = 0;
      //페이징 객체
      Paging paging = null;
      //리스트
      List<User> list = null;
      
      User param = new User();
      
      param.setStatus(status);

      totalCount = adminService.userListCount(param);
      logger.debug("totalCount : ", totalCount);
      
      
      if(totalCount > 0)
      {
         paging = new Paging("/admin/index", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
         
         paging.addParam("status", status);
         
         list = adminService.userList(param);
      }
      
      
      
      model.addAttribute("list", list);
      model.addAttribute("status", status);
      model.addAttribute("curPage", curPage);
      model.addAttribute("paging", paging);
      logger.debug("list.size() : ", list.size());
      
      return "/admin/userList";
   }
   
   @RequestMapping(value = "/admin/userPoint")
   public String userPoint(Model model, HttpServletRequest request, HttpServletResponse response)
   {
      String status = HttpUtil.get(request, "status");
      int curPage = HttpUtil.get(request, "curPage", 1);      
      
      //총 사용자 수
      int totalCount = 0;
      //페이징 객체
      Paging paging = null;
      //리스트
      List<Point> list = null;
      
      Point param = new Point();
      param.setStatus(status);

      totalCount = adminService.pointListCount(param);
      
      if(totalCount > 0)
      {
         paging = new Paging("/admin/userPoint", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
         
         paging.addParam("status", status);
         paging.addParam("curPage", curPage);
         
         list = adminService.pointList(param);
      }
      
      model.addAttribute("list", list);
      model.addAttribute("status", status);
      model.addAttribute("curPage", curPage);
      model.addAttribute("paging", paging);
      
      return "/admin/userPoint";
   }

   //회원 정보 수정
   @RequestMapping(value="/admin/updateProc", method = {RequestMethod.GET, RequestMethod.POST})
   @ResponseBody
   public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response)
   {
      String userId = HttpUtil.get(request, "userId");
      String status = HttpUtil.get(request, "status");
      
      logger.debug("[AdminController] /admin/updateProc userId" + userId);
      logger.debug("[AdminController] /admin/updateProc status" + status);
      
      Response<Object> res = new Response<Object>();
      
      if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(status))
      {
         User user = adminService.userSelect(userId);
         
         if(user != null)
         {
            user.setStatus(status);
            
            if(adminService.userUpdate(user) > 0)
            {
               res.setResponse(0, "Success");
            }
            else
            {
               res.setResponse(-1, "Fail");
            }
         }
         else
         {
            res.setResponse(404, "Not Found");
         }
      }
      else
      {
         res.setResponse(400, "Bad Request");
      }
      
      logger.debug("[AdminController] /admin/updateProc response\n" + JsonUtil.toJsonPretty(res));
      
      return res;
   }

   //포인트지급
   @RequestMapping(value="/admin/userPointReward", method = {RequestMethod.GET, RequestMethod.POST})
   @ResponseBody
   public Response<Object> userPointReward(HttpServletRequest request, HttpServletResponse response)
   {
      String userId = HttpUtil.get(request, "userId");
      int point = Integer.parseInt(HttpUtil.get(request, "point"));     
      String savePath = HttpUtil.get(request, "savePath");
      
      Response<Object> res = new Response<Object>();
      
      if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(point))
      {
         User user = adminService.userSelect(userId);
         Point point1 = new Point();
         
         point1.setUserId(userId);
         point1.setSavePath(savePath);
         point1.setSavePoint(point);

         if(user != null)
         {
            user.setPayPoint(point);
            
            if(adminService.userPointInsert(point1) > 0)
            {
            	res.setResponse(0, "Success");
            }
            else
            {
            	res.setResponse(-1, "userPointInsert Fail");
            }
            
            if(adminService.userPointRewardUpdate(user) > 0)
            {
               res.setResponse(0, "Success");
            }
            else
            {
               res.setResponse(-1, "userPointRewardUpdate Fail");
            }
         }
         else
         {
            res.setResponse(404, "Not Found");
         }
      }
      else
      {
         res.setResponse(400, "Bad Request");
      }
      
      logger.debug("[AdminController] /admin/userPointReward response\n" + JsonUtil.toJsonPretty(res));
      
      return res;
   }
   
   //포인트지급
   @RequestMapping(value="/admin/userPointInsert", method = {RequestMethod.GET, RequestMethod.POST})
   @ResponseBody
   public Response<Object> userPointInsert(HttpServletRequest request, HttpServletResponse response)
   {
      String userId = HttpUtil.get(request, "userId");
      int point = Integer.parseInt(HttpUtil.get(request, "point"));  
      String savePath = HttpUtil.get(request, "savePath");
      
      Response<Object> res = new Response<Object>();
      
      if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(point) && !StringUtil.isEmpty(savePath))
      {
         User user = adminService.userSelect(userId);
         Point point1 = new Point();
         
         if(user != null)
         {
            user.setPayPoint(point);
            
            point1.setSavePath(savePath);
            point1.setSavePoint(point);
            
            if(adminService.userPointInsert(point1) > 0)
            {
               res.setResponse(0, "Success");
            }
            else
            {
               res.setResponse(-1, "Fail");
            }
         }
         else
         {
            res.setResponse(404, "Not Found");
         }
      }
      else
      {
         res.setResponse(400, "Bad Request");
      }
      
      logger.debug("[AdminController] /admin/userPointInsert response\n" + JsonUtil.toJsonPretty(res));
      
      return res;
   }
   
   
}
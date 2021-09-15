package com.icia.itsmyplace.controller;

import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.Area;
import com.icia.itsmyplace.model.Point;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.SubArea;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.service.AreaService;
import com.icia.itsmyplace.service.CafeService;
import com.icia.itsmyplace.service.UserService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;

@Controller("userController")
public class UserController {
   private static Logger logger = LoggerFactory.getLogger(IndexController.class);
   
   //쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
   
   @Autowired
   private UserService userService;
   
   @Autowired
   private AreaService areaService;
   
   @Autowired
   private CafeService cafeService;
   
   @Autowired
   private JavaMailSender mailSender;
   
   //로그인
   @RequestMapping(value="/user/login", method=RequestMethod.GET)
   public String login(HttpServletRequest request, HttpServletResponse response)
   {
         return "/user/login";
   }
   
 //로그인 체크
   @RequestMapping(value="/user/loginCheck", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> loginCheck(HttpServletRequest request, HttpServletResponse response)
   {
      String userId = HttpUtil.get(request, "userId");
      String userPwd = HttpUtil.get(request, "userPwd");
      String userClass = HttpUtil.get(request, "userClass");
      Response<Object> ajaxResponse = new Response<Object>();
      
      if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd))
      {
         User user = userService.userSelect(userId);
         
         if(user != null)
         {
            if(StringUtil.equals(user.getUserPwd(), userPwd))
            {
            		
            	if(StringUtil.equals(user.getStatus(), "Y")) {
            		if(StringUtil.equals(user.getUserClass(), userClass)) {
            			CookieUtil.addCookie(response, "/",  -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userId));

            			ajaxResponse.setResponse(0, "Success");
            		}
            		else {
                		ajaxResponse.setResponse(-2, "Permissions do not match");
                	}
            		
            	}
            	else {
        			ajaxResponse.setResponse(-3, "Not User");
        		}
            }
        	
            else
            {
               ajaxResponse.setResponse(-1, "Passwords do not match");
            }
         }
         else
         {
            ajaxResponse.setResponse(404, "Not Found");
         }
      }
      else
      {
         ajaxResponse.setResponse(400, "Bad Request");
      }
      
      logger.debug("[UserController] /user/login response\n" 
               + JsonUtil.toJsonPretty(ajaxResponse));
      
      return ajaxResponse;
   }
   
   //회원가입폼
   @RequestMapping(value="/user/regForm", method=RequestMethod.GET)
   public String regForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {
	   List<Area> areaList = areaService.areaSelect();
   	   model.addAttribute("areaList", areaList);
       return "/user/regForm";
   }
   
   //아이디 중복 체크
   @RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> idCheck(HttpServletRequest request, HttpServletResponse response)
   {
      String userId = HttpUtil.get(request, "userId");
      Response<Object> ajaxResponse = new Response<Object>();
      
      if(!StringUtil.isEmpty(userId))
      {
         if(userService.userSelect(userId) == null)
         {
            //사용 가능 아이디인경우
            ajaxResponse.setResponse(0, "Success");
         }
         else
         {
            ajaxResponse.setResponse(100, "Duplicate ID");
         }
      }
      else
      {
         ajaxResponse.setResponse(400, "Bad Request");
      }
      
      logger.debug("[UserController] /user/idCheck response\n" 
            + JsonUtil.toJsonPretty(ajaxResponse));
      
      return ajaxResponse;
   }
   
   //회원 등록
   @RequestMapping(value="/user/regProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> regProc(HttpServletRequest request, HttpServletResponse response)
   {
      String userId = HttpUtil.get(request, "userId");
      String userClass = HttpUtil.get(request, "userClass");
      String areaNum = HttpUtil.get(request, "areaNum");
      String subAreaNum = HttpUtil.get(request, "subAreaNum");
      String userPwd = HttpUtil.get(request, "userPwd");
      String userName = HttpUtil.get(request, "userName");
      String userEmail = HttpUtil.get(request, "userEmail");
      String userGender = HttpUtil.get(request, "userGender");
      
      Response<Object> ajaxResponse = new Response<Object>();

      if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userClass) && !StringUtil.isEmpty(areaNum) && !StringUtil.isEmpty(subAreaNum) 
      && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userGender))
      {

         if(userService.userSelect(userId) == null)
         {

            User user = new User();
            
            user.setUserId(userId);
            user.setUserClass(userClass);
            user.setAreaNum(areaNum);
            user.setSubAreaNum(subAreaNum);
            user.setUserPwd(userPwd);
            user.setUserName(userName);
            user.setUserEmail(userEmail);
            user.setUserGender(userGender);
            user.setStatus("Y");
            user.setTotalPoint(1000);
            
            Point point = new Point();
    		point.setUserId(userId);
    		point.setSavePoint(1000);
    		point.setSavePath("가입축하포인트");
            
    		try {
    			if(userService.userInsert(user) <= 0) {
    				ajaxResponse.setResponse(403, "Empty element in area and subarea");
    				return ajaxResponse;
    			}
    				
    			if(cafeService.pointInsert(point) > 0) {
    				ajaxResponse.setResponse(0, "Success");
    			}
    			else {
    				ajaxResponse.setResponse(300, "Internal Server Error");
    			}
    			
    		} catch(Exception e) {
    			logger.error("[UserController] /user/regProc Exception", e);
    			ajaxResponse.setResponse(500, "Empty element and Internal Server Error");
    		}
         }
         else
         {
            ajaxResponse.setResponse(100, "Duplicate ID");
         }
      }
      else
      {
 
         ajaxResponse.setResponse(400, "Empty element");
      }
      
      logger.debug("[UserController] /user/regProc response\n"  + JsonUtil.toJsonPretty(ajaxResponse));
      
      return ajaxResponse;
   }
   
   //로그아웃
   @RequestMapping(value="/user/loginOut", method=RequestMethod.GET)
   public String loginOut(HttpServletRequest request, HttpServletResponse response)
   {
      if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
      {
         CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
      }
      
      return "redirect:/";
   }
   
   //회원정보 수정 반영
   @RequestMapping(value="/user/updateProc",method= RequestMethod.POST)
   @ResponseBody
   public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String userPwd = HttpUtil.get(request, "userPwd");
      String userName = HttpUtil.get(request, "userName");
      String userEmail = HttpUtil.get(request, "userEmail");
      String areaNum = HttpUtil.get(request, "areaNum");
      String subAreaNum = HttpUtil.get(request, "subAreaNum");

  	  System.out.println("###################");
  	  System.out.println("areaNum = " + areaNum);
  	  System.out.println("subAreaNum = " + subAreaNum);
  	  System.out.println("###################");
	  
      Response<Object> ajaxResponse = new Response<Object>();
      
      if(!StringUtil.isEmpty(cookieUserId))
      {
         User user = userService.userSelect(cookieUserId);
         
         if(user != null)
         {
            if(StringUtil.equals(user.getStatus(), "Y"))
            {
               if(!StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) &&
                  !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(areaNum) && !StringUtil.isEmpty(subAreaNum))
               {
                  user.setUserPwd(userPwd);
                  user.setUserName(userName);
                  user.setUserEmail(userEmail);
                  user.setAreaNum(areaNum);
                  user.setSubAreaNum(subAreaNum);
                  
                  if(userService.userUpdate(user) > 0)
                  {
                     ajaxResponse.setResponse(0, "success");
                  }   
                  else
                  {
                     ajaxResponse.setResponse(500, "Internal server Error");
                  }   
               }
               else
               {
                  ajaxResponse.setResponse(400, "Bad Requset");
               }   
            }   
            else
            {
               CookieUtil.deleteCookie(request, response,  AUTH_COOKIE_NAME);
               ajaxResponse.setResponse(400, "Bad Request400");
               
            }   
         }   
         else
         {
            CookieUtil.deleteCookie(request, response,  AUTH_COOKIE_NAME);
            
            ajaxResponse.setResponse(404, "Bad Request404");
         }   
      }   
      else
      {
         ajaxResponse.setResponse(400, "Bad Requset");
      }   

         return ajaxResponse;
   }
   
   //비번찾기-폼으로이동
   @RequestMapping(value="/user/findPwd")
   public String findPwd(HttpServletRequest request, HttpServletResponse response)
   {
      return "/user/findPwd";
   }

   //비번찾기- 인증번호 메일전송
   @RequestMapping(value="/user/sendMail", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> sendMail(HttpServletRequest request, HttpServletResponse response)
   {      
	  String userId = HttpUtil.get(request, "id");
      String userEmail = HttpUtil.get(request, "mailAddress");
      String userPwd = StringUtil.uniqueValue().substring(0,9);

      System.out.println("###################");
      System.out.println("userId = " + userId + "  userEmail = " + userEmail);
      System.out.println("###################");
      Response<Object> ajaxResponse = new Response<Object>();
      
      if(!StringUtil.isEmpty(userEmail))
      {
    	 User user = userService.userSelect(userId);
    	 if(user == null) {
    		 ajaxResponse.setResponse(404, "Not User Info");
             return ajaxResponse; 
    	 }
    	 
    	 if(user.getUserEmail().equals(userEmail)) {
    	 
	    	 if(user.getUserId().equals(userId) && user.getUserEmail().equals(userEmail)) {
	    		 user.setUserPwd(userPwd);
	    		 userService.userUpdate(user);
	    	 }
	    	 else {
	    		 ajaxResponse.setResponse(404, "Not User Info");
	             return ajaxResponse; 
	    	 }

	         if(userPwd != null)
	         {
	            String subject = "[내자리얌] 비밀번호를 확인하세요.";
	            String content = "당신의 비밀번호는 "+ userPwd +" 입니다\n\n [내자리얌]";
	            String from = "itsmyplace1@naver.com";   //네이버 메일주소 입력
	            
	            try
	            {
	               MimeMessage mail = mailSender.createMimeMessage();
	               MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
	               
	               mailHelper.setSubject(subject);
	               mailHelper.setText(content);
	               mailHelper.setFrom(from);
	               mailHelper.setTo(userEmail);
	               
	               mailSender.send(mail);
	               ajaxResponse.setResponse(0, "Success");
	            }
	            catch(Exception e)
	            {
	               System.out.println("usercontroller sendmail 오류");
	               e.printStackTrace();
	            }
         	  }
	          else
	          {
	         	 ajaxResponse.setResponse(500, "Internal Server Error");
	          }
    	 }
    	 else {
    		 ajaxResponse.setResponse(403, "Email not equals");
    	 }
      }
      else
      {
     	 ajaxResponse.setResponse(500, "Internal Server Error2");
      }
      
      
      return ajaxResponse;
   }
   
   
	//회원가입 세부지역 선택
   @RequestMapping(value="/user/areaProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> areaProc(HttpServletRequest request, HttpServletResponse response)
   {
	   Response<Object> ajaxResponse = new Response<Object>();
	   
	   String areaNum = HttpUtil.get(request, "areaNum", "");
	   
	   List<SubArea> subAreaList = areaService.subAreaList(areaNum);
	   
	   if(!StringUtil.isEmpty(subAreaList))
	   {
		   ajaxResponse.setResponse(0, "Success", subAreaList);
	   }
	   else
	   {
		   ajaxResponse.setResponse(500, "Internal Server Error");
	   }
	   
	   return ajaxResponse;
   }
   
   
}
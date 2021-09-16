package com.icia.itsmyplace.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.Area;
import com.icia.itsmyplace.model.Cafe;
import com.icia.itsmyplace.model.Comm;
import com.icia.itsmyplace.model.CommCmt;
import com.icia.itsmyplace.model.CommPht;
import com.icia.itsmyplace.model.MyPage;
import com.icia.itsmyplace.model.Order;
import com.icia.itsmyplace.model.Paging;
import com.icia.itsmyplace.model.Pay;
import com.icia.itsmyplace.model.Point;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.Review;
import com.icia.itsmyplace.model.ReviewPht;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.SubArea;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.model.UserPostList;
import com.icia.itsmyplace.service.AdminService;
import com.icia.itsmyplace.service.AreaService;
import com.icia.itsmyplace.service.CafeService;
import com.icia.itsmyplace.service.CommService;
import com.icia.itsmyplace.service.MyPageService;
import com.icia.itsmyplace.service.ReviewService;
import com.icia.itsmyplace.service.RsRvService;
import com.icia.itsmyplace.service.UserService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;

@Controller("myPageController")
public class MyPageController {

	 private static Logger logger = LoggerFactory.getLogger(MyPageController.class);
	//쿠키명
   @Value("#{env['auth.cookie.name']}")
   private String AUTH_COOKIE_NAME;
   
   @Value("#{env['uploadReview.save.dir']}")
   private String UPLOADREVIEW_SAVE_DIR;
   
   @Autowired
   private UserService userService;
   
   @Autowired
   private CafeService cafeService;
   
   @Autowired
   private CommService commService;
   
   @Autowired
   private ReviewService reviewService;
   
   @Autowired
   private RsRvService rsRvService;
   
   @Autowired
   private MyPageService myPageService;
   
   @Autowired
   private AreaService areaService;
   
   @Autowired
   private AdminService adminService;
   
   DecimalFormat formatter = new DecimalFormat("###,###");
   
   private static final int LIST_COUNT = 10; //한 페이지의 게시물 수
   private static final int PAGE_COUNT = 5;  //페이징 수
   
   
   //마이페이지 - 결제 내역
   @RequestMapping(value="/mypage/userPayment")
   public String userPayment(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	   
	   String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   User user = userService.userSelect(cookieUserId);
	   long rsrvSeq = HttpUtil.get(request, "rsrvSeq", (long)0);
	   long curPage = HttpUtil.get(request, "curPage", (long)1);
	   long totalCount = 0;
	   Paging paging = null;
	   RsRv search = new RsRv();
	   
	   totalCount = rsRvService.myOrderCount(user);
	   
	   logger.debug("totalCount : " + totalCount);
	   
	   if(totalCount > 0) {
		   paging = new Paging("/mypage/userPayment", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
		   
		   paging.addParam("curPage", curPage);
		   
		   search.setUserId(user.getUserId());
		   search.setStartRow(paging.getStartRow());
		   search.setEndRow(paging.getEndRow());
	   }
	   
	   List<RsRv> rsRv = rsRvService.myOrderInfo(search);

	   for(int i=0; i<rsRv.size(); i++) {
		   Pay pay = cafeService.paySelect(rsRv.get(i).getRsrvSeq());
		   String str = rsRv.get(i).getRsrvTime();
		   str = str.substring(0, 2) + ":" + str.substring(2, str.length());
		   rsRv.get(i).setRsrvTime(str); // 시간 12:00 같은 형식으로 변환
		   rsRv.get(i).setTotalPrice_s(formatter.format(rsRv.get(i).getTotalPrice()));
		   
		   if(pay.getPayStep().equals("100")) pay.setPayStep("결제대기");
		   else if(pay.getPayStep().equals("200")) pay.setPayStep("결제완료");
		   else if(pay.getPayStep().equals("300")) pay.setPayStep("사용완료");
		   else if(pay.getPayStep().equals("400")) pay.setPayStep("후기완료");
		   else if(pay.getPayStep().equals("500")) pay.setPayStep("환불완료");
		   else if(pay.getPayStep().equals("600")) pay.setPayStep("결제취소");
		   
		   rsRv.get(i).setPayStep(pay.getPayStep());
		   //금액 3자리마다 , 넣어줌
	   }
	   
	   model.addAttribute("user", user);
	   model.addAttribute("rsRv", rsRv);
	   model.addAttribute("curPage", curPage);
	   model.addAttribute("paging", paging);
	   model.addAttribute("rsrvSeq", rsrvSeq);
	
	   return "/mypage/userPayment";
	}
   
   //마이페이지 - 프로필
	@RequestMapping(value="/mypage/userProfile")
	public String userProfile(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

	    User user = userService.userSelect(cookieUserId);
	    User userArea = userService.userAreaSelect(cookieUserId);
	    
	    user.setAreaName(userArea.getAreaName());
	    user.setSubAreaName(userArea.getSubAreaName());
	    model.addAttribute("user", user);
	    
		return "/mypage/userProfile";
	}
	
	//회원정보 수정
   //회원정보수정창에서 기본적으로 로그인이 되어있어야함
   //이름, 이메일주소 기본으로 가져갈거 (userID에 해당하는 회원정보건)

   @RequestMapping(value="/mypage/updateInfo", method=RequestMethod.GET)
   public String updateInfo(ModelMap model, HttpServletRequest request,
         HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);//쿠키정보가져옴

      User user = userService.userSelect(cookieUserId);//유저정보 select
      User userArea = userService.userAreaSelect(cookieUserId);
      user.setAreaName(userArea.getAreaName());
	  user.setSubAreaName(userArea.getSubAreaName());
	  
      List<Area> areaList = areaService.areaSelect();
    
      for(int i=0;i<areaList.size();i++){
          String str = user.getAreaNum();
          if(str.equals(areaList.get(i).getAreaNum())) {
        	  areaList.remove(i);
          }
      }
      
      
  	  model.addAttribute("areaList", areaList);
      model.addAttribute("user", user);//userupdateForm에서 무슨이름으로 쓸지
   
      return "/mypage/updateInfo";
   }
   
   @RequestMapping(value="/mypage/withdrawal",method= RequestMethod.POST)
   @ResponseBody
   public Response<Object> withdrawal(HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      
      Response<Object> ajaxResponse = new Response<Object>();
      
      if(!StringUtil.isEmpty(cookieUserId))
      {
         User user = userService.userSelect(cookieUserId);
         
         if(user != null)
         {
            if(StringUtil.equals(user.getStatus(), "Y"))
            {
                  if(userService.userWithdrawal(user) > 0)
                  {
                	  if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
                      {
                         CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
                         ajaxResponse.setResponse(0, "success");
                      }
                	  else {
                		  ajaxResponse.setResponse(500, "Internal server Error");
                	  }
                  }   
                  else
                  {
                     ajaxResponse.setResponse(500, "Internal server Error");
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

 //내 게시물 리스트
 	@RequestMapping(value="/mypage/userPost")
 	public String userPostList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
 	{	
 		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
 		User user = userService.userSelect(cookieUserId);
 		//현재 페이지
 		long curPage = HttpUtil.get(request, "curPage", (long)1);	
 		long curPage2 = HttpUtil.get(request, "curPage2", (long)1);
 		//총 게시물 수
 		long totalCount = 0;
 		long totalCount2 = 0;
 		//게시물 리스트
 		List<UserPostList> list = null;
 		List<UserPostList> list2 = null;
 		//조회 객체
 		UserPostList search = new UserPostList();
 		UserPostList search2 = new UserPostList();
 		//페이징 객체
 		Paging paging = null;
 		Paging paging2 = null;
 		
 		search.setUserId(cookieUserId);
 		search2.setUserId(cookieUserId);
 		
 		totalCount = myPageService.userPostListCount(search.getUserId());
 		totalCount2 = myPageService.userReviewPostListCount(search2.getUserId());
 		
 		logger.debug("totalCount : " + totalCount);
 		logger.debug("totalCount2 : " + totalCount2);
 		
 		if(totalCount > 0) {
 			paging = new Paging("/mypage/userPost", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
 			paging.addParam("curPage", curPage);

 			search.setStartRow(paging.getStartRow());
 			search.setEndRow(paging.getEndRow());
 			
 			list = myPageService.userPostList(search);
 		}
 		
 		if(totalCount2 > 0) {
 			paging2 = new Paging("/mypage/userPost", totalCount2, LIST_COUNT, PAGE_COUNT, curPage2, "curPage2");
 			paging2.addParam("curPage2", curPage2);

 			search2.setStartRow(paging2.getStartRow());
 			search2.setEndRow(paging2.getEndRow());
 			
 			list2 = myPageService.userReviewPostList(search2); 
 			
 		}
// 		System.out.println("#########################################");
// 		System.out.println(list.get(0).getAdminPublic());
// 		System.out.println("#########################################");
 		model.addAttribute("user", user); 
 		model.addAttribute("list", list);   
 		model.addAttribute("list2", list2);
 		model.addAttribute("curPage", curPage);
 		model.addAttribute("curPage2", curPage2);
 		model.addAttribute("paging", paging);
 		model.addAttribute("paging2", paging2);
 		
 		return "/mypage/userPost";		
 	}
	
	//게시글삭제 컨트롤러입니다.
   @RequestMapping(value="/mypage/chkDeleteProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> chkDeleteProc(HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      String bbsSeqList = HttpUtil.get(request, "checkBoxArr");
      
      String[] seqList = bbsSeqList.split(" ");
      
      Response<Object> ajaxResponse = new Response<Object>();
      User user = userService.userSelect(cookieUserId);
      
      for(int i=0; i<seqList.length; i++) {
    	  System.out.println("#########################");
    	  System.out.println("seqList["+i+"] = " + seqList[i]);
    	  System.out.println("Integer seqList["+i+"] = " + Integer.parseInt(seqList[i]));
    	  System.out.println("#########################");
    	  Comm comm = commService.commSelect(Integer.parseInt(seqList[i]));
         CommCmt commCmt = new CommCmt();
         commCmt.setBbsSeq(Integer.parseInt(seqList[i]));
         
         //UserPostList postList = myPageService.chkListSelect(Integer.parseInt(seqList[i]));
         
         List<CommCmt> commCmtList = commService.commCmtList(commCmt);
         List<CommPht> commPhtList = commService.commPhtList(Integer.parseInt(seqList[i]));
         System.out.println("#########################");
         System.out.println("cmt, pht = " + (commCmtList == null) + "  " + (commPhtList == null));
         System.out.println("#########################");
         if(user != null && comm != null && user.getUserId().equals(comm.getUserId()))
         {      
            if(commCmtList != null)
            {
               if(commService.commCmtDeleteAll(commCmt) == 0)
               {
                  ajaxResponse.setResponse(500, "Internal Server Error");
                  //return ajaxResponse;
               }
               
            }
            if(commPhtList != null)
            {
               if(commService.commPhtDeleteAll(Integer.parseInt(seqList[i])) == 0)
               {
                  ajaxResponse.setResponse(501, "Internal Server Error");
                  //return ajaxResponse;
               }
            }
            
            if(myPageService.chkDelete(Integer.parseInt(seqList[i])) > 0)
            {
               ajaxResponse.setResponse(0, "Success");
            }
            else
            {
               ajaxResponse.setResponse(502, "Internal Server Error");
            }
         }
         else
         {
            ajaxResponse.setResponse(404, "Bad Request");
         }
      }
      
      logger.debug("[myPageController] /mypage/chkDeleteProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
      
      return ajaxResponse;
   }
	
	//리뷰게시글삭제
	@RequestMapping(value="/mypage/chkReviewDeleteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> chkReviewDelete(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String rsrvSeqList = HttpUtil.get(request, "checkBoxArr2");
		
		String[] seqList = rsrvSeqList.split(" ");
		Response<Object> ajaxResponse = new Response<Object>();
		User user = userService.userSelect(cookieUserId);
		
		for(int i=0; i<seqList.length; i++) {
			UserPostList postList = myPageService.chkReviewSelect(Integer.parseInt(seqList[i]));
			List<ReviewPht> reviewList = reviewService.modalPhtList(Integer.parseInt(seqList[i]));
			
			if(user != null && postList != null && user.getUserId().equals(postList.getUserId()))
			{		
				if(reviewList != null)
	            {
					if(reviewService.reviewPhtDeleteAll(Integer.parseInt(seqList[i])) <= 0) {
						ajaxResponse.setResponse(403, "Pht Delete Error");
					}
	            }
					
				if(myPageService.chkReviewDelete(Integer.parseInt(seqList[i])) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
		
			}
			else
			{
				ajaxResponse.setResponse(400, "Bad Request");
			}
		}
		
		logger.debug("[myPageController] /mypage/chkReviewDeleteProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
 	

	//구매목록 상세
	@RequestMapping(value = "/mypage/userPurchaseConfirmation")
	public String userPurchaseConfirmation(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		//String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long rsrvSeq = Integer.parseInt(HttpUtil.get(request, "rsrvSeq"));
		MyPage myPage = myPageService.myOrderDetail(rsrvSeq);

		List<Order> order = myPageService.myOrderList(rsrvSeq);
		myPage.setOrderList(order);

	    String strTime = myPage.getRsrvTime();
	    strTime = strTime.substring(0, 2) + ":" + strTime.substring(2, strTime.length());
	    myPage.setRsrvTime(strTime); // 시간 12:00 같은 형식으로 변환
	    myPage.setOriginPrice_s(formatter.format(myPage.getOriginPrice()));
	    myPage.setTotalPrice_s(formatter.format(myPage.getTotalPrice()));
	    myPage.setPayPoint_s(formatter.format(myPage.getPayPoint()));
		//금액 3자리마다 , 넣어줌
		
		
		Pay pay = cafeService.paySelect(myPage.getRsrvSeq());
		if(pay.getPayStep().equals("100")) pay.setPayStep("결제대기");
		else if(pay.getPayStep().equals("200")) pay.setPayStep("결제완료");
		else if(pay.getPayStep().equals("300")) pay.setPayStep("사용완료");
		else if(pay.getPayStep().equals("400")) pay.setPayStep("후기완료");
		else if(pay.getPayStep().equals("500")) pay.setPayStep("환불완료");
		else if(pay.getPayStep().equals("600")) pay.setPayStep("결제취소");   
		myPage.setPayStep(pay.getPayStep());
		//myPage.setOriginPrice(pay.getOriginPrice());
		
		model.addAttribute("myPage", myPage);
		//User user = userService.userSelect(cookieUserId);
		//model.addAttribute("user", user);
		
		return "/mypage/userPurchaseConfirmation";
	}
	
	//후기쓰기 화면
	@RequestMapping(value="/review/reviewWrite")
	public String reviewWrite(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
	{
		//쿠키값
		//String cookieUserId = CookieUtil.getHexValue(request,AUTH_COOKIE_NAME);
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//예약번호
		long rsrvSeq = HttpUtil.get(request, "rsrvSeq", (long)0);
		RsRv rsRv = rsRvService.rsRvSelect(rsrvSeq);
		
		//User user = userService.userSelect(cookieUserId);
		model.addAttribute("curPage", curPage);
		model.addAttribute("rsRv", rsRv);
		//model.addAttribute("rsrvSeq", rsrvSeq);
		//model.addAttribute("user", user);
		 
		return "/review/reviewWrite";
	}
	
	//후기 등록 처리하는 폼
	@RequestMapping(value="/review/reviewWriteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> reviewwriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long rsrvSeq = HttpUtil.get(request, "rsrvSeq", (long)0);		
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		double bbsStar = HttpUtil.get(request, "bbsStar", 5.0);
		String bbsPublic = HttpUtil.get(request, "bbsPublic", "Y");
		
		Pay pay = cafeService.paySelect(rsrvSeq);
		long rewardPoint = (long)(pay.getTotalPrice()*0.02);
		
		List<FileData> fileDataList = HttpUtil.getFiles(request, "reviewPht", UPLOADREVIEW_SAVE_DIR);
		Response<Object> ajaxResponse = new Response<Object>();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userSelect(userId);
		user.setTotalPoint(rewardPoint);
		
		Point point = new Point();
		
		point.setUserId(user.getUserId());
		point.setSavePoint((int)rewardPoint);
		point.setSavePath("후기완료포인트적립");
		point.setRsrvSeq(rsrvSeq);
		
		
		
		int fileDataCnt = fileDataList.size();
		int nullCnt = 0;
		
		for(int k=0; k<fileDataList.size(); k++)
		{
			if(fileDataList.get(k).getFileSize() == 0)
			{
				nullCnt += 1;
				
				if(StringUtil.trim(fileDataList.get(k).getFileOrgName()).length() > 0)
	            {
	               ajaxResponse.setResponse(999, "Invalidate File");
	               return ajaxResponse;
	            }
			}
		}
		
		if(nullCnt > 0)
		{
			fileDataList = null;
			fileDataCnt = 0;
		}
		
		
		if(!StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent) && !StringUtil.isEmpty(bbsStar) && !StringUtil.isEmpty(bbsPublic))
		{
			Review review = new Review();
			
			review.setRsrvSeq(rsrvSeq);
			review.setBbsTitle(bbsTitle);
			review.setBbsContent(bbsContent);
			review.setBbsStar(bbsStar);
			review.setBbsPublic(bbsPublic);
		
			 //첨부파일확인
			 if(fileDataList != null && fileDataCnt > 0)
			 {
				 List<ReviewPht> reviewPhtList = new ArrayList<ReviewPht>();

				 for(int i=0; i<fileDataCnt; i++)
				{
					ReviewPht reviewPht = new ReviewPht();
						
					reviewPht.setPhtName(fileDataList.get(i).getFileName());
					reviewPht.setPhtOrgName(fileDataList.get(i).getFileOrgName());
					reviewPht.setPhtSize(fileDataList.get(i).getFileSize());
					reviewPht.setRsrvSeq(rsrvSeq);
					reviewPht.setPhtNum(i+1);
					
					String fileExt = fileDataList.get(i).getFileExt();
					
					if(!StringUtil.isEmpty(fileExt))
					{
						if(fileExt.equals("png") || fileExt.equals("jpg") || fileExt.equals("jpeg") || fileExt.equals("gif") || fileExt.equals("jfif"))
						{
							reviewPht.setPhtExt(fileExt);
						}
						else
						{
							ajaxResponse.setResponse(900, "Invalidate Ext");
							
							return ajaxResponse;
						}
					}
					
					reviewPhtList.add(reviewPht);
				}
				
				 review.setReviewPhtList(reviewPhtList);
			 }
			 
			try
			{
				if(adminService.userPointRewardUpdate(user) <= 0) {
					ajaxResponse.setResponse(404, "2% point Reward Error");
				}
				if(cafeService.pointInsert(point) <= 0) {
					ajaxResponse.setResponse(405, "point Insert Error");
				}
				if(reviewService.reviewInsert(review) > 0)
				{
					ajaxResponse.setResponse(0, "Success / 500 in try in if");
				}
				else
				{
					ajaxResponse.setResponse(500, "Internal Server Error / 500 in try in else");
				}
				
			} 
			catch(Exception e)
			{
				logger.error("[MyPageController]/review/reviewWriteProc Exception", e);
				
				ajaxResponse.setResponse(500, "Internal Server Error / 500 in catch");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request / 400");
		}
		
		logger.debug("[MyPageController] /review/reviewWriteProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	//마이페이지 카페관리자 예약현황 조회용
	@RequestMapping(value="/mypage/rsrvInfo")
   public String rsrvInfo(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	   
	   String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	   User user = userService.userSelect(cookieUserId);
	   long curPage = HttpUtil.get(request, "curPage", (long)1);
	   long totalCount = 0;
	   Paging paging = null;
	   RsRv search = new RsRv();
	     
	   totalCount = myPageService.myCafeRsrvCnt(user.getUserId());
	   	   
	   if(totalCount > 0) {
		   paging = new Paging("/mypage/rsrvInfo", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
		   
		   paging.addParam("curPage", curPage);
		   
		   search.setUserId(user.getUserId());
		   search.setStartRow(paging.getStartRow());
		   search.setEndRow(paging.getEndRow());
	   }
	   
	   List<RsRv> rsRv = myPageService.myCafeRsrvList(search);

	   for(int i=0; i<rsRv.size(); i++) {
		   String str = rsRv.get(i).getRsrvTime();
		   str = str.substring(0, 2) + ":" + str.substring(2, str.length());
		   rsRv.get(i).setRsrvTime(str); // 시간 12:00 같은 형식으로 변환
		   		   
		   MyPage myPage = myPageService.myOrderDetail(rsRv.get(i).getRsrvSeq());
		   
		   List<Order> order = myPageService.myOrderList(rsRv.get(i).getRsrvSeq());
		   myPage.setOrderList(order);
		   
			myPage.setOriginPrice_s(formatter.format(myPage.getOriginPrice()));
			myPage.setTotalPrice_s(formatter.format(myPage.getTotalPrice()));
			myPage.setPayPoint_s(formatter.format(myPage.getPayPoint()));
		   
			Pay pay = cafeService.paySelect(rsRv.get(i).getRsrvSeq());
			if(pay.getPayStep().equals("100")) pay.setPayStep("결제대기");
			else if(pay.getPayStep().equals("200")) pay.setPayStep("결제완료");
			else if(pay.getPayStep().equals("300")) pay.setPayStep("사용완료");
			else if(pay.getPayStep().equals("400")) pay.setPayStep("후기완료");
			else if(pay.getPayStep().equals("500")) pay.setPayStep("환불완료");
			else if(pay.getPayStep().equals("600")) pay.setPayStep("결제취소");   
			rsRv.get(i).setPayStep(pay.getPayStep());
			
		   rsRv.get(i).setMypage(myPage);
	   }
	   
	   Cafe cafe = myPageService.myCafeSelect(user.getUserId());
	   
	   model.addAttribute("cafe", cafe);
	   model.addAttribute("user", user);
	   model.addAttribute("rsRv", rsRv);
	   model.addAttribute("curPage", curPage);
	   model.addAttribute("paging", paging);
	
	   return "/mypage/rsrvInfo";
	}
		
	
}

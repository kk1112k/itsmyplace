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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.Notice;
import com.icia.itsmyplace.model.Paging;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.model.Point;
import com.icia.itsmyplace.model.Refund;
import com.icia.itsmyplace.model.EventBoard;
import com.icia.itsmyplace.model.Cs;
import com.icia.itsmyplace.model.Comm;
import com.icia.itsmyplace.model.CommCmt;
import com.icia.itsmyplace.model.Review;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.service.AdminBoardService;
import com.icia.itsmyplace.service.EventBoardService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;

	



@Controller("adminBoardController")
public class AdminBoardController
{
	private static Logger logger = LoggerFactory.getLogger(AdminBoardController.class);

	@Autowired
	private AdminBoardService adminBoardService;
	
	private static final int LIST_COUNT = 100;
	private static final int PAGE_COUNT = 100;	
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	
	@RequestMapping(value="/admin/index", method=RequestMethod.GET)
	   public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	   
	    //게시물 리스트
	      List<RsRv> list0 = null;
	      //조회 객체
	      RsRv search0 = new RsRv();                
	      list0 = adminBoardService.cafeList(search0);      
	      model.addAttribute("list0", list0);   
	      
	      int totalCount = 0;
	      int noticeCount = 0;
	      Notice nCount = new Notice();
	            
	      int eventCount = 0;
	      EventBoard eCount = new EventBoard();
	      
	      int csCount = 0;
	      Cs csCount1 = new Cs();
	      
	      long communityCount = 0;
	      Comm cCount = new Comm();
	      
	      int reviewCount = 0;
	      Review rCount = new Review();
	      
	      noticeCount = adminBoardService.noticeListCount(nCount);
	      eventCount = adminBoardService.EventBoardListCount(eCount);
	      csCount = adminBoardService.CsListCount(csCount1);  //.EventBoardListCount(eCount);
	      communityCount = adminBoardService.CommListCount(cCount);  //.EventBoardListCount(eCount);
	      reviewCount = adminBoardService.ReviewListCount(rCount); //.EventBoardListCount(eCount);
	      
	      totalCount = (int) (noticeCount + eventCount + csCount + communityCount + reviewCount);
	      
	      model.addAttribute("totalCount", totalCount);
	      
	      logger.debug("noticeCount : " + noticeCount);
	      logger.debug("eventCount : " + eventCount);
	      logger.debug("csCount : " + csCount);
	      logger.debug("communityCount : " + communityCount);
	      logger.debug("reviewCount : " + reviewCount);
	      
	      //게시물 리스트
	      List<RsRv> list1 = null;
	      //조회 객체
	      RsRv search1 = new RsRv();                
	      list1 = adminBoardService.cafe1List(search1);      
	      model.addAttribute("list1", list1);   
	      
	      //게시물 리스트
	      List<RsRv> list2 = null;
	      //조회 객체
	      RsRv search2 = new RsRv();             
	      list2 = adminBoardService.cafe2List(search2);   
	      model.addAttribute("list2", list2);   
	      
	      //게시물 리스트
	      List<RsRv> list3 = null;
	      //조회 객체
	      RsRv search3 = new RsRv();                
	      list3 = adminBoardService.cafe3List(search3);      
	      model.addAttribute("list3", list3);   
	      
	      //게시물 리스트
	      List<RsRv> list4 = null;
	      //조회 객체
	      RsRv search4 = new RsRv();                
	      list4 = adminBoardService.cafe4List(search4);      
	      model.addAttribute("list4", list4); 
	      
	    //게시물 리스트
	      List<RsRv> list5 = null;
	      //조회 객체
	      RsRv search5 = new RsRv();                
	      list5 = adminBoardService.user1List(search5);      
	      model.addAttribute("list5", list5);      
	      
	      List<RsRv> list = null;
	      //조회 객체
	      RsRv search = new RsRv();
	      list = adminBoardService.rsRvList(search);
	      model.addAttribute("list", list);      
	      
	      List<RsRv> list6 = null;
	      //조회 객체
	      RsRv search6 = new RsRv();
	      list6 = adminBoardService.totalList(search6);
	      model.addAttribute("list6", list6);
	      
	      //System.out.println("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"+list6.get(0)+ list6.get(1)+ list6.get(2) );
	      
	      return "/admin/index"; 
	      
	   }  	
	
	
	// notice
	@RequestMapping(value = "/admin/notice", method=RequestMethod.GET)
	public String notice(Model model, HttpServletRequest request, HttpServletResponse response)
	{
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<Notice> list = null;
		//조회 객체
		Notice search = new Notice();
		
		totalCount = adminBoardService.noticeListCount(search);
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0)
		{
			list = adminBoardService.noticeList(search);  
		}	

		model.addAttribute("list", list);   

		return "/admin/notice";

	}
	
	
	// event
	@RequestMapping(value = "/admin/event", method=RequestMethod.GET)
	public String event(Model model, HttpServletRequest request, HttpServletResponse response)
	{	
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<EventBoard> list = null;
		//조회객체
		EventBoard search = new EventBoard();

		
		totalCount = adminBoardService.EventBoardListCount(search);	      
	    logger.debug("totalCount : " + totalCount);
	    
	    if(totalCount > 0)
	    {
	    	list = adminBoardService.EventBoardList(search);
	    }
	    
	    model.addAttribute("list", list);
		
		return "/admin/event";
	}
	
	
	
	//이벤트 관리자 차단
	   @RequestMapping(value="/admin/eventAdminPublicUpdateProc", method = {RequestMethod.GET, RequestMethod.POST})
	   @ResponseBody
	   public Response<Object> eventAdminPublicUpdateProc(HttpServletRequest request, HttpServletResponse response)
	   {
	      
	      long bbsSeq = Long.parseLong(HttpUtil.get(request, "bbsSeq"));
	      String adminPublic = HttpUtil.get(request, "adminPublic");

	      logger.debug("[AdminBoardController] /admin/eventAdminPublicUpdateProc bbsSeq" + bbsSeq);
	      logger.debug("[AdminBoardController] /admin/eventAdminPublicUpdateProc adminPublic" + adminPublic);
	      
	      //조회객체
	      EventBoard search = new EventBoard();
	      
	      Response<Object> res = new Response<Object>();
	      
	      if(!StringUtil.isEmpty(bbsSeq) && !StringUtil.isEmpty(adminPublic))
	      {
	    	 search.setBbsSeq(bbsSeq);
	    	 search.setAdminPublic(adminPublic);
	            
            if(adminBoardService.EventBoardAdminPublicUpdate(search) > 0 )
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
	         res.setResponse(400, "Bad Request");
	      }
	      
	      logger.debug("[AdminBoardController] /admin/eventAdminPublicUpdateProc response\n" + JsonUtil.toJsonPretty(res));
	      
	      return res;
	   }
	   
	   
	
	
	//review
	@RequestMapping(value = "/admin/review", method=RequestMethod.GET)
	public String review(Model model, HttpServletRequest request, HttpServletResponse response)
	{
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<Review> list = null;
		//조회 객체
		Review search = new Review();
				
		totalCount = adminBoardService.ReviewListCount(search);
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0)
		{
			list = adminBoardService.ReviewList(search);
		}
		
		model.addAttribute("list", list);   
		
		return "/admin/review";
	}
	
	
	//리뷰 관리자 차단
   @RequestMapping(value="/admin/reviewAdminPublicUpdateProc", method = {RequestMethod.GET, RequestMethod.POST})
   @ResponseBody
   public Response<Object> reviewAdminPublicUpdateProc(HttpServletRequest request, HttpServletResponse response)
   {
      
      long rsrvSeq = Long.parseLong(HttpUtil.get(request, "rsrvSeq"));
      String adminPublic = HttpUtil.get(request, "adminPublic");

      logger.debug("[AdminBoardController] /admin/reviewAdminPublicUpdateProc rsrvSeq" + rsrvSeq);
      logger.debug("[AdminBoardController] /admin/reviewAdminPublicUpdateProc adminPublic" + adminPublic);
      
      //조회객체
      Review search = new Review();
      
      Response<Object> res = new Response<Object>();
      
      if(!StringUtil.isEmpty(rsrvSeq) && !StringUtil.isEmpty(adminPublic))
      {
    	 search.setRsrvSeq(rsrvSeq);
    	 search.setAdminPublic(adminPublic);
            
     if(adminBoardService.ReviewAdminPublicUpdate(search) > 0 )
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
         res.setResponse(400, "Bad Request");
      }
      
      logger.debug("[AdminBoardController] /admin/reviewAdminPublicUpdateProc response\n" + JsonUtil.toJsonPretty(res));
      
      return res;
   }
	   

	
	
	//community
	@RequestMapping(value="/admin/community", method=RequestMethod.GET)
	public String community(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{		
		//커뮤니티 게시글 총 게시물 수
		long totalCount = 0;
		//커뮤니티 게시글 게시물 리스트
		List<Comm> list = null;
		//조회 객체
		Comm search = new Comm();
		
		List<CommCmt> s = null;
		CommCmt searchS = new CommCmt();
		
		
		//커뮤니티 댓글 총 댓글 수
		long totalCount2 = 0;
		//커뮤니티 댓글 댓글 리스트
		List<CommCmt> list2 = null;
		//커뮤니티 댓글 조회객체
		CommCmt search2 = new CommCmt();
				
		totalCount = adminBoardService.CommListCount(search);		
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0) 
		{
			list = adminBoardService.commList(search);
		}
		
		totalCount2 = adminBoardService.commCmtListCount(search2);
		logger.debug("totalCount : " + totalCount2);
		
		if(totalCount2 > 0)
		{
			logger.debug("토탈리스트카운트2 타냐?");
			list2 = adminBoardService.commCmtList(search2);
		}
		
		
		for(int i=0; i<totalCount; i++)
		{
			searchS.setBbsSeq(list.get(i).getBbsSeq());
			s = adminBoardService.commCmtList(searchS);
			
			list.get(i).setCommCmtList(s);
		}
		
		model.addAttribute("list", list);   
		model.addAttribute("list2", list2);
		
		return "/admin/community";		
	}
	
	//커뮤니티 게시글 관리자 차단
   @RequestMapping(value="/admin/commAdminPublicUpdateProc", method = {RequestMethod.GET, RequestMethod.POST})
   @ResponseBody
   public Response<Object> commAdminPublicUpdateProc(HttpServletRequest request, HttpServletResponse response)
   {
      
      long bbsSeq = Long.parseLong(HttpUtil.get(request, "bbsSeq"));
      System.out.println("##########################");
      System.out.println("bbsSeq = " + bbsSeq);
      System.out.println("##########################");
      String adminPublic = HttpUtil.get(request, "adminPublic");

      logger.debug("[AdminBoardController] /admin/commAdminPublicUpdateProc bbsSeq" + bbsSeq);
      logger.debug("[AdminBoardController] /admin/commAdminPublicUpdateProc adminPublic" + adminPublic);
      
      //조회객체
      Comm search = new Comm();
      
      Response<Object> res = new Response<Object>();
      
      if(!StringUtil.isEmpty(bbsSeq) && !StringUtil.isEmpty(adminPublic))
      {
    	 search.setBbsSeq(bbsSeq);
    	 search.setAdminPublic(adminPublic);
            
     if(adminBoardService.commAdminPublicUpdate(search) > 0 )
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
         res.setResponse(400, "Bad Request");
      }
      
      logger.debug("[AdminBoardController] /admin/commAdminPublicUpdateProc response\n" + JsonUtil.toJsonPretty(res));
      
      return res;
   }
	
   //커뮤니티 댓글 관리자 차단
   @RequestMapping(value="/admin/commCmtAdminPublicUpdateProc", method = {RequestMethod.GET, RequestMethod.POST})
   @ResponseBody
   public Response<Object> commCmtAdminPublicUpdateProc(HttpServletRequest request, HttpServletResponse response)
   {
      
      long cmtSeq = Long.parseLong(HttpUtil.get(request, "cmtSeq"));
      String adminPublic = HttpUtil.get(request, "adminPublic");

      logger.debug("[AdminBoardController] /admin/commAdminPublicUpdateProc cmtSeq" + cmtSeq);
      logger.debug("[AdminBoardController] /admin/commAdminPublicUpdateProc adminPublic" + adminPublic);
      
      //조회객체
      CommCmt search = new CommCmt();
      
      Response<Object> res = new Response<Object>();
      
      if(!StringUtil.isEmpty(cmtSeq) && !StringUtil.isEmpty(adminPublic))
      {
    	 search.setCmtSeq(cmtSeq);
    	 search.setAdminPublic(adminPublic);
            
     if(adminBoardService.commCmtAdminPublicUpdate(search) > 0 )
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
         res.setResponse(400, "Bad Request");
      }
      
      logger.debug("[AdminBoardController] /admin/commCmtAdminPublicUpdateProc response\n" + JsonUtil.toJsonPretty(res));
      
      return res;
   }
	
	
			
	@RequestMapping(value="/admin/cs", method=RequestMethod.GET)
	public String cs(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<Cs> list = null;
		//조회 객체
		Cs search = new Cs();

		totalCount = adminBoardService.CsListCount(search);	
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0) 
		{
			list = adminBoardService.CsList(search);
		}
		
		model.addAttribute("list", list);   
		
		return "/admin/cs";		
	}

	//리뷰 관리자 차단
	   @RequestMapping(value="/admin/csAdminPublicUpdateProc", method = {RequestMethod.GET, RequestMethod.POST})
	   @ResponseBody
	   public Response<Object> csAdminPublicUpdateProc(HttpServletRequest request, HttpServletResponse response)
	   {
	      
	      long bbsSeq = Long.parseLong(HttpUtil.get(request, "bbsSeq"));
	      String adminPublic = HttpUtil.get(request, "adminPublic");

	      logger.debug("[AdminBoardController] /admin/reviewAdminPublicUpdateProc bbsSeq" + bbsSeq);
	      logger.debug("[AdminBoardController] /admin/reviewAdminPublicUpdateProc adminPublic" + adminPublic);
	      
	      //조회객체
	      Cs search = new Cs();
	      
	      Response<Object> res = new Response<Object>();
	      
	      if(!StringUtil.isEmpty(bbsSeq) && !StringUtil.isEmpty(adminPublic))
	      {
	    	 search.setBbsSeq(bbsSeq);
	    	 search.setAdminPublic(adminPublic);
	            
	     if(adminBoardService.csAdminPublicUpdate(search) > 0 )
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
	         res.setResponse(400, "Bad Request");
	      }
	      
	      logger.debug("[AdminBoardController] /admin/csAdminPublicUpdateProc response\n" + JsonUtil.toJsonPretty(res));
	      
	      return res;
	   }
	
	
	
	
	
   @RequestMapping(value="/admin/rsRv", method=RequestMethod.GET)
   public String rsRv(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	   //총 게시물 수
	   long totalCount = 0;
	   //게시물 리스트
	   List<RsRv> list = null;
	   //조회 객체
	   RsRv search = new RsRv();
	   	   
	   totalCount = adminBoardService.rsRvListCount(search);
	   logger.debug("totalCount : " + totalCount);
	   
	   if(totalCount > 0) 
	   {
	      list = adminBoardService.rsRvList(search);
	   }
	   
	   model.addAttribute("list", list);   
	   
	   return "/admin/rsRv";      
}	
	   
   @RequestMapping(value="/admin/refund", method=RequestMethod.GET)
   public String refund(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
	   //총 게시물 수
	   long totalCount = 0;
	   //게시물 리스트
	   List<Refund> list = null;
	   //조회 객체
	   Refund search = new Refund();
	   
	   totalCount = adminBoardService.refundListCount(search);
	   logger.debug("totalCount : " + totalCount);
	   
	   if(totalCount > 0) 
	   {
	      list = adminBoardService.refundList(search);
	   }
	   
	   model.addAttribute("list", list);   
	   
	   return "/admin/refund";      
	}	
}

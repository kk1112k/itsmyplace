package com.icia.itsmyplace.controller;

import org.slf4j.LoggerFactory;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.Cs;
import com.icia.itsmyplace.model.Paging;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.service.CsService;
import com.icia.itsmyplace.service.UserService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;

@Controller("csController")
public class CsController {
	private static Logger logger = LoggerFactory.getLogger(CsController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CsService csService;
	
	private static final int LIST_COUNT = 10; 	// 한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;	// 페이징 수
	
	
	@RequestMapping(value="/cs/list")
	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userSelect(cookieUserId);
		
		//조회항목(1:작성자조회, 2:제목조회, 3:내용조회)
		String searchType = HttpUtil.get(request, "searchType");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<Cs> list = null;
		//조회 객체
		Cs search = new Cs();
		//페이징 객체
		Paging paging = null;
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		else {
			searchType = "";
			searchValue = "";
		}
		
		totalCount = csService.csListCount(search);
		
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0) {
			paging = new Paging("/cs/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = csService.csList(search);  
		}
		
		model.addAttribute("user", user);
		model.addAttribute("list", list);   
		model.addAttribute("searchType", searchType);   
		model.addAttribute("searchValue", searchValue); 
		model.addAttribute("curPage", curPage); 
		model.addAttribute("paging", paging);  
		
		return "/cs/list";		
	}
	
	
	
	//게시물 등록 폼
	@RequestMapping(value="/cs/writeForm")
	public String writeForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		//쿠키값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//조회항목(1:작성자조회, 2:제목조회, 3:내용조회)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		User user = userService.userSelect(cookieUserId);
		model.addAttribute("searchType", searchType);//writeform.jsp에서 사용할 이름
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		// --- list 페이지에 가기 위한 용도
		model.addAttribute("user", user); // user객체도 담음
		System.out.println("###########################");
		System.out.println("userClass = " + user.getUserClass());
		System.out.println("###########################");
		return "/cs/writeForm";
	}
	
	//게시물 등록 처리하는 폼
	@RequestMapping(value="/cs/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent)) {
			Cs cs = new Cs();
			cs.setUserId(cookieUserId);
			cs.setBbsTitle(bbsTitle);
			cs.setBbsContent(bbsContent);
			
			try {
				if(csService.csInsert(cs) > 0) {
					ajaxResponse.setResponse(0, "Success / 500 in try in if");
				}
				else {
					ajaxResponse.setResponse(500, "Internal Server Error / 500 in try in else");
				}
				
			} catch(Exception e) {
				
				logger.error("[CsController]/cs/writeProc Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error / 500 in catch");
			}
		}
		
		else {
			ajaxResponse.setResponse(400, "Bad Request / 400");
		}
		
		logger.debug("[CsController] /cs/writeProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	//게시물 조회
	@RequestMapping(value="/cs/view")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		//쿠키값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시물 번호
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		//조회항목(1.작성자, 2.제목, 3.내용)
		String searchType = HttpUtil.get(request, "searchType");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//본인글 여부
		String csMe = "N";
		
		User user = userService.userSelect(cookieUserId);
		
		Cs cs = null;
		
		if(bbsSeq > 0)
		{
			cs = csService.csView(bbsSeq);
			if(cs != null && StringUtil.equals(cs.getUserId(), cookieUserId)) {
				csMe = "Y"; // 본인 글임
			}
		}
		
		model.addAttribute("user", user);
		model.addAttribute("bbsSeq", bbsSeq);
		model.addAttribute("cs", cs);
		model.addAttribute("csMe", csMe);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		
		return "/cs/view";
	}
	
	//게시물 삭제
	@RequestMapping(value="/cs/delete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> delete(HttpServletRequest request, HttpServletResponse response){ //ajax통신에대한결과값리턴
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(bbsSeq > 0) {
			Cs cs = csService.csSelect(bbsSeq);
			
			if(cs != null) {
				if(StringUtil.equals(cs.getUserId(), cookieUserId)) {
					try {
						if(csService.csAnswersCount(cs.getBbsSeq()) > 0) {
							ajaxResponse.setResponse(-999, "Answers exist and cannot be deleted");
						}
						else {
							if(csService.csDelete(cs.getBbsSeq()) > 0) {
								ajaxResponse.setResponse(0, "success");
							}
							else {//게시물삭제실패
								ajaxResponse.setResponse(500, "Internal Server Error 500");
							}
						}		
					} catch(Exception e) {
						logger.error("[CsController] /cs/delete Exception", e);
						}
				}
				else {
					ajaxResponse.setResponse(400, "Not Found 400");
				}
			}
			else {
				ajaxResponse.setResponse(400, "Not Found 400");
			}
		}
		else {
			ajaxResponse.setResponse(400, "Bad Request 400");
		}
		
		logger.debug("[CsController] /cs/delete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	//게시물 수정 화면
	@RequestMapping(value="/cs/updateForm")
	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		//dispatcherservlet에서 받아서 
		//쿠키값 - 로그인확인용도 env에 들어있는 유저의 값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시물번호
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0); // 맨 마지막은 값 안들어왔을 때 대체하기 위한 디폴트값
		//조회항목(1:작성자, 2:제목, 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		// 
		// --------- 게시물보기화면인 view.jsp에서 수정버튼을 눌렀을 때 처리되는 값들을 담기 위한 변수 선언
		//링크치고 한번에 들어오는거 방지
		Cs cs = null;
		User user = null;
		
		if(bbsSeq > 0) { //클라이언트에서 요청이 들어왔을 경우
			cs = csService.csView(bbsSeq);
			//삭제는 별도페이지를가져올필요가 없음 아작스통신으로 서버프로그램호출하고 결과값만가져오기만하면됨
			//수정은 따로 가져가야댐 현재잇는페이지 데이터를 가지고가서 수정할수잇는화면으로이동
			
			if(cs != null) {
				if(StringUtil.equals(cs.getUserId(), cookieUserId)) {
					user = userService.userSelect(cookieUserId);
				}
				else {
					cs = null;
				}
			}
		}
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("cs", cs);
		model.addAttribute("user", user);
		return "/cs/updateForm";
	}
	
	//게시물 수정 폼
	   @RequestMapping(value="/cs/updateProc", method=RequestMethod.POST)
	   @ResponseBody
	   public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	   {
	      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	      long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
	      String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
	      String bbsContent = HttpUtil.get(request, "bbsContent", "");
	      
	      Response<Object> ajaxResponse = new Response<Object>();
	      
	      if(bbsSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
	      {
	         Cs cs = csService.csSelect(bbsSeq);
	         
	         if(cs != null)
	         {
	            if(StringUtil.equals(cs.getUserId(), cookieUserId))
	            {
	               cs.setBbsSeq(bbsSeq);
	               cs.setBbsTitle(bbsTitle);
	               cs.setBbsContent(bbsContent);
	               
	            }
	            
	            try
	            {
	               if(csService.csUpdate(cs) > 0)
	               {
	                  ajaxResponse.setResponse(0, "Success"); 
	               }
	               else
	               {
	                  ajaxResponse.setResponse(500, "500 Internal Server Error");
	               }
	            }
	            catch(Exception e)
	            {
	               logger.error("[CsController] /cs/updateProc Exception", e);
	               ajaxResponse.setResponse(500, "500 Internal Server Error in catch"); 
	            }
	         }      
	         else {
	            ajaxResponse.setResponse(404, "404 Not Found");  //본인 게시물이 아닙니다.
	         }
	      
	      }
	      else {
	         ajaxResponse.setResponse(400, "400 Bad Request");
	      }
	      logger.debug("[CsController] /cs/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
	      
	      return ajaxResponse;
	   }
	
	// 게시판 답변
	@RequestMapping(value="/cs/replyForm", method=RequestMethod.POST)
	public String replyForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		Cs cs = null;
		User user = null;
		System.out.println("########################");
		System.out.println("bbsSeq = " + bbsSeq);
		System.out.println("########################");
		if(bbsSeq > 0) { //클라이언트에서 요청이 들어왔을 경우
			cs = csService.csSelect(bbsSeq);

			if(cs != null) {
				user = userService.userSelect(cookieUserId);
			}
		}
		System.out.println("########################");
		System.out.println("userClass = " + user.getUserClass());
		System.out.println("########################");
		
		if(user.getUserClass().equals("S")) {
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("curPage", curPage);
			model.addAttribute("cs", cs);
			model.addAttribute("user", user);
			
			return "/cs/replyForm";
		}
		
		return "redirect:/";
	}
	
	// 게시물 답변 폼
	@RequestMapping(value="/cs/replyProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> replyProc(MultipartHttpServletRequest request, HttpServletResponse response){
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		
		Response<Object> ajaxResponse = new Response<Object>();
		if(bbsSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent)) {
			Cs parentCs = csService.csSelect(bbsSeq);
			
			if(parentCs != null) {
				Cs cs = new Cs();
				
				//cs에 대한 것 적용
				cs.setUserId(cookieUserId);
				cs.setBbsGroup(parentCs.getBbsGroup());
				cs.setBbsOrder(parentCs.getBbsOrder() + 1);
				cs.setBbsIndent(parentCs.getBbsIndent() + 1);
				cs.setBbsParent(bbsSeq);
				cs.setBbsTitle(bbsTitle);
				cs.setBbsContent(bbsContent);
				cs.setBbsPublic(parentCs.getBbsPublic());
				
			try {
				if(csService.csReplyInsert(cs) > 0) {
					ajaxResponse.setResponse(0,  "Success");
				}
				else {
					ajaxResponse.setResponse(500, "500 Internal Server Error in try else");
				}
				
			} catch(Exception e) {
				logger.error("[CsController] /cs/replyProc Exception");
				ajaxResponse.setResponse(500, "500 Internal Server Error in catch");
			}
				
			}
			else {
				//부모글이 없다면
				ajaxResponse.setResponse(404, "404 Not Found");
			}
		}
		else {
			ajaxResponse.setResponse(400, "400 Bad Request");
		}
		
		logger.debug("[CsController] /cs/replyProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	// FAQ 페이지
    @RequestMapping(value="/cs/faq", method=RequestMethod.GET)
    public String faq(HttpServletRequest request, HttpServletResponse response)
    {
          return "/cs/faq";
    }
    
    // FAQ 페이지
    @RequestMapping(value="/cs/toitsmyplace", method=RequestMethod.GET)
    public String toitsmyplace(HttpServletRequest request, HttpServletResponse response)
    {
          return "/cs/toitsmyplace";
    }
	
}

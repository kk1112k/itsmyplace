package com.icia.itsmyplace.controller;

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
import com.icia.itsmyplace.model.EventBoard;
import com.icia.itsmyplace.model.EventBoardFile;
import com.icia.itsmyplace.model.Paging;
import com.icia.itsmyplace.service.EventBoardService;
import com.icia.itsmyplace.service.UserService;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.util.JsonUtil;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.util.CookieUtil;


@Controller("eventBoardController")
public class EventBoardController 
{
	private static Logger logger = LoggerFactory.getLogger(EventBoardController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['uploadEvent.save.dir']}")
	private String UPLOADEVENT_SAVE_DIR;
	
	@Autowired
	private EventBoardService eventBoardService;
	
	@Autowired
	private UserService userService;
	
	private static final int LIST_COUNT = 4;		//한 페이지의 게시물 수 
	private static final int PAGE_COUNT = 5;		//페이징 수
	
	@RequestMapping(value="/event/list")
	public String eventBoardList(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		//쿠키 값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//공개 여부('Y': 공개 , 'N' : 비공개)
		String searchStatus = HttpUtil.get(request, "searchStatus", "");
		//조회 항목(1:작성자조회, 2:제목조회, 3:내용조회)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회 값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재 페이지 
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//총 게시물 수
		long totalCount = 0;
		//publicUpdate 수
		long totalUpdaetCount = 0;
		
		
		//회원구분 여부 (Y = 카페사장과 내자리얌관리자로 글쓰기 가능  ,  N = 회원으로 글쓰기 불가능)
		String boardClass = "";
		//회원구분 객체
		User user = new User();
		//게시물 리스트
		List<EventBoard> list = null;
		//조회객체
		EventBoard search = new EventBoard();
		//페이징 객체
		Paging paging = null;
		
		
		if(cookieUserId != null && cookieUserId != "")
		{
			user = userService.userSelect(cookieUserId);
			
			if(StringUtil.equals(user.getUserId(), cookieUserId))
			{
				if(StringUtil.equals(user.getUserClass(), "C") || StringUtil.equals(user.getUserClass(), "S"))
				{
					boardClass = "Y";
				}
			}
		}
		
		if(!StringUtil.isEmpty(searchStatus))
		{
			search.setSearchStatus(searchStatus);
		}
		else
		{
			searchStatus = "";
		}
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchType))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		else
		{
			searchType = "";
			searchValue = "";
		}
		
		totalCount = eventBoardService.eventBoardListCount(search);
	      
	    logger.debug("totalCount : " + totalCount);
	    
	    if(totalCount > 0)
		{
			paging = new Paging("/board/eventBoard", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("searchStatus", searchStatus);
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = eventBoardService.eventBoardList(search);
				
		}
	    
	    model.addAttribute("list", list);
		model.addAttribute("searchStatus", searchStatus);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("boardClass", boardClass);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		
		logger.debug("/event/list Controller 타는중입니다.");
		return "/event/list";
		
	}
	
	
	//게시물 등록 화면
	@RequestMapping(value="/event/writeForm")
	public String eventBoardWriteForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		//쿠키 값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//공개 여부('Y': 공개 , 'N' : 비공개)
		String searchStatus = HttpUtil.get(request, "searchStatus", "");
		//조회 항목(1:작성자 조회, 2:제목 조회, 3:내용 조회)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회 값 
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		//사용자정보 조회
		User user = userService.userSelect(cookieUserId);
		
		model.addAttribute("searchStatus", searchStatus);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("user", user);
		logger.debug("eventBoardWrite Controller 타는중입니다. 안전벨트 메세요. ");
		return "/event/writeForm";	
	}
	
	//게시물 등록 Proc
	@RequestMapping(value="/event/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String evtOpnDate = HttpUtil.get(request, "evtOpnDate", "");
		String evtClsDate = HttpUtil.get(request, "evtClsDate", "");
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		FileData fileData = HttpUtil.getFile(request, "bbsFile", UPLOADEVENT_SAVE_DIR);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
		{
			EventBoard eventBoard = new EventBoard();
			
			eventBoard.setUserId(cookieUserId);
			eventBoard.setBbsTitle(bbsTitle);
			eventBoard.setBbsContent(bbsContent);
			eventBoard.setEvtOpnDate(evtOpnDate);
			eventBoard.setEvtClsDate(evtClsDate);
			
			if(fileData != null && fileData.getFileSize() > 0)
			{
				EventBoardFile eventBoardFile = new EventBoardFile();
				
				eventBoardFile.setFileName(fileData.getFileName());
				eventBoardFile.setFileOrgName(fileData.getFileOrgName());
				eventBoardFile.setFileExt(fileData.getFileExt());
				eventBoardFile.setFileSize(fileData.getFileSize());
				
				eventBoard.setEventBoardFile(eventBoardFile);
			}
			
			try
			{
				if(eventBoardService.eventBoardInsert(eventBoard) > 0 )
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
			}
			catch(Exception e)
			{
				logger.error("[EventBoardController]/event/writeProc Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error");
			}
			
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		logger.debug("[EventBoardController] /event/writeProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	

	
	//게시물 조회
	@RequestMapping(value="/event/view")
	public String eventBoardDetail(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키 값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시물 번호
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		//게시물 공개여부
		String searchStatus = HttpUtil.get(request, "searchStatus");
		//조회 항목(1:작성자, 2:제목, 3:내용)
		String searchType = HttpUtil.get(request, "searchType");
		//조회값	
		String searchValue = HttpUtil.get(request, "searchValue", "");
		
		
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//본인 글 여부
		String boardMe = "N";
		
		EventBoard eventBoard = null;		
		
		if(bbsSeq > 0)
		{
			eventBoard = eventBoardService.eventBoardDetail(bbsSeq);
			
			if(eventBoard != null && StringUtil.equals(eventBoard.getUserId(), cookieUserId))
			{
				boardMe = "Y";  //본인 글
			}
		}
		
		model.addAttribute("bbsSeq", bbsSeq);
		model.addAttribute("eventBoard", eventBoard);
		model.addAttribute("boardMe", boardMe);
		model.addAttribute("searchStatus", searchStatus);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		
		return "/event/view";
	}
	
	
	//게시이물 삭제
	@RequestMapping(value="/event/eventDelete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> eventBoardDelete(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(bbsSeq > 0)
		{
			EventBoard eventBoard = eventBoardService.eventBoardSelect(bbsSeq);
			
			if(eventBoard != null)
			{
				if(StringUtil.equals(eventBoard.getUserId(), cookieUserId))
				{
					try
					{
						if(eventBoardService.eventBoardDelete(eventBoard.getBbsSeq()) > 0)
						{
							ajaxResponse.setResponse(0, "success");
						}
						else
						{
							ajaxResponse.setResponse(500, "internal Server Error");
						}
					}
					catch(Exception e)
					{
						logger.error("[EventBoardController] /event/eventBoardDelete Exception", e);
						ajaxResponse.setResponse(500, "internal Server Error");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "Not Found");
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
		logger.debug("[EventBoardController] /event/eventBoardDelete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	
	//게시물 수정 화면
	@RequestMapping(value="/event/updateForm")
	public String eventBoardUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
	{
		//쿠키값 읽어오는거 
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);		
		//게시물 번호 읽어오기 
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);		
		//조회항목 가져오기 (1:작성자, 2:제목, 3:내용)
		String searchStatus = HttpUtil.get(request, "searchStatus", "");		
		//조회항목 가져오기 (1:작성자, 2:제목, 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");		
		//조회 값 가져오기
		String searchValue = HttpUtil.get(request, "searchValue", "");		
		//현재 페이지 가져오기
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		EventBoard eventBoard = null;
		User user = null;
		
		if(bbsSeq > 0)
		{
			eventBoard = eventBoardService.eventBoardSelect(bbsSeq);
			
			if(eventBoard != null)
			{
				if(StringUtil.equals(eventBoard.getUserId(), cookieUserId))
				{
					user = userService.userSelect(cookieUserId);
				}
				else
				{
					eventBoard = null;
				}
			}
		}
		
		model.addAttribute("searchStatus", searchStatus);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("eventBoard", eventBoard);
		model.addAttribute("user", user);
				
		logger.debug("eventBoardUpdate Controller 타는중입니다. 안전벨트 메세요. ");
		return "/event/updateForm";
	}
	
	
	//게시물 수정 Proc
	@RequestMapping(value="/event/updateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> eventBoardUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)1);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		FileData fileData = HttpUtil.getFile(request, "bbsFile", UPLOADEVENT_SAVE_DIR);
		String evtOpnDate = HttpUtil.get(request, "evtOpnDate", "");
		String evtClsDate = HttpUtil.get(request, "evtClsDate", "");
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(bbsSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
		{
			EventBoard eventBoard = eventBoardService.eventBoardSelect(bbsSeq);
			
			if(eventBoard != null)
			{
				if(StringUtil.equals(eventBoard.getUserId(), cookieUserId))
				{
					eventBoard.setBbsSeq(bbsSeq);
					eventBoard.setBbsTitle(bbsTitle);
					eventBoard.setBbsContent(bbsContent);
					eventBoard.setEvtOpnDate(evtOpnDate);
					eventBoard.setEvtClsDate(evtClsDate);
					
					if(fileData != null && fileData.getFileSize() > 0)
					{
						EventBoardFile eventBoardFile = new EventBoardFile();
						
						eventBoardFile.setFileName(fileData.getFileName());
						eventBoardFile.setFileOrgName(fileData.getFileOrgName());
						eventBoardFile.setFileExt(fileData.getFileExt());
						eventBoardFile.setFileSize(fileData.getFileSize());
						
						eventBoard.setEventBoardFile(eventBoardFile);
					}
				}
				
				try
				{
					if(eventBoardService.eventBoardUpdate(eventBoard) > 0)
					{
						ajaxResponse.setResponse(0, "Success"); 
					}
					else
					{
						ajaxResponse.setResponse(500, "Internal Server Error");
					}
				}
				catch(Exception e)
				{
					logger.error("[EventBoardController] /event/updateProc Exception", e);
					ajaxResponse.setResponse(500, "Internal Server Error"); 
				}
			}		
			else
			{
				ajaxResponse.setResponse(404, "Not Found");  //본인 게시물이 아닙니다.
			}
		
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		logger.debug("[EventBoardController] /event/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	
	
	//PublicUpdate Proc
	@RequestMapping(value="/event/eventPublicUpdateProc")
	public String eventPublicUpdateProc()
	{
		int count = eventBoardService.eventPublicUpdate();
		
		return "redirect:/event/list";
	}
	
	
	
	
	
}		
		
		
	











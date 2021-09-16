package com.icia.itsmyplace.controller;

import java.io.File;
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
import org.springframework.web.servlet.ModelAndView;

import com.icia.common.model.FileData;
import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.Notice;
import com.icia.itsmyplace.model.NoticeFile;
import com.icia.itsmyplace.model.Paging;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.service.NoticeService;
import com.icia.itsmyplace.service.UserService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;

@Controller("noticeController")
public class NoticeController {
	private static Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['uploadNotice.save.dir']}")
	private String UPLOADNOTICE_SAVE_DIR;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private NoticeService noticeService;
	
	private static final int LIST_COUNT = 10; 	// 한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;	// 페이징 수
	
	@RequestMapping(value="/notice/list")
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
		List<Notice> list = null;

		//조회 객체
		Notice search = new Notice();
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
		
		totalCount = noticeService.noticeListCount(search);
		
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0) {
			paging = new Paging("/notice/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = noticeService.noticeList(search);  
		}

		model.addAttribute("user", user);
		model.addAttribute("list", list);   
		model.addAttribute("searchType", searchType);   
		model.addAttribute("searchValue", searchValue); 
		model.addAttribute("curPage", curPage); 
		model.addAttribute("paging", paging);  
		
		return "/notice/list";		
	}
	
	//게시물 등록 폼
	@RequestMapping(value="/notice/writeForm")
	public String noticeWriteForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
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
		return "/notice/writeForm";
	}
	
	//게시물 등록 처리하는 폼
	@RequestMapping(value="/notice/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> noticeWriteProc(MultipartHttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		FileData fileData = HttpUtil.getFile(request, "bbsFile", UPLOADNOTICE_SAVE_DIR);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent)) {
			Notice notice = new Notice();
			notice.setUserId(cookieUserId);
			notice.setBbsTitle(bbsTitle);
			notice.setBbsContent(bbsContent);
			//첨부파일확인
			if(fileData != null && fileData.getFileSize() > 0) {
				NoticeFile noticeFile = new NoticeFile();
				
				noticeFile.setFileName(fileData.getFileName());
				noticeFile.setFileOrgName(fileData.getFileOrgName());
				noticeFile.setFileExt(fileData.getFileExt());
				noticeFile.setFileSize(fileData.getFileSize());
				//Notice.java -> NoticeFile
				notice.setNoticeFile(noticeFile); // 파일이 들어가는(set되는) 코드줄
			}

			try {
				if(noticeService.noticeInsert(notice) > 0) {
					ajaxResponse.setResponse(0, "Success / 500 in try in if");
				}
				else {
					ajaxResponse.setResponse(500, "Internal Server Error / 500 in try in else");
				}
				
			} catch(Exception e) {
				
				logger.error("[NoticeController] /notice/writeProc Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error / 500 in catch");
			}
		}
		
		else {
			ajaxResponse.setResponse(400, "Bad Request / 400");
		}
		
		logger.debug("[NoticeController] /notice/writeProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	
	//게시물 조회
	@RequestMapping(value="/notice/view")
	public String noticeView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
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
		String noticeMe = "N";
		
		Notice notice = null;
		
		if(bbsSeq > 0)
		{
			notice = noticeService.noticeView(bbsSeq);
			if(notice != null && StringUtil.equals(notice.getUserId(), cookieUserId)) {
				noticeMe = "Y"; // 본인 글임
			}
		}
		
		model.addAttribute("bbsSeq", bbsSeq);
		model.addAttribute("notice", notice);
		model.addAttribute("noticeMe", noticeMe);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		
		return "/notice/view";
	}
	
	//게시물 삭제
   @RequestMapping(value = "/notice/delete", method = RequestMethod.POST)
   @ResponseBody
   public Response<Object> delete(HttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long bbsSeq = HttpUtil.get(request, "bbsSeq", (long) 0);

      Response<Object> ajaxResponse = new Response<Object>();

      if (bbsSeq > 0)
      {
         Notice notice = noticeService.noticeSelect(bbsSeq);

         if (notice != null)
         {
            if (StringUtil.equals(notice.getUserId(), cookieUserId))
            {
               try
               {
            	   if(noticeService.noticeFileDelete(bbsSeq) > 0) {
            		   if (noticeService.noticeDelete(notice.getBbsSeq()) > 0)
	   	                {
	   	                   ajaxResponse.setResponse(0, "Success");
	   	                }
	   	                else
	   	                {
	   	                   ajaxResponse.setResponse(500, "internal Server Error");
	   	                }
            	   }
            	   else {
		                if (noticeService.noticeDelete(notice.getBbsSeq()) > 0)
		                {
		                   ajaxResponse.setResponse(0, "Success");
		                }
		                else
		                {
		                   ajaxResponse.setResponse(500, "internal Server Error");
		                }
            	   }
               }
               catch (Exception e)
               {
                  logger.error("[NoticeController] /notice/delete Exception", e);
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

      logger.debug("[NoticeController] /notice/delete response\n" + JsonUtil.toJsonPretty(ajaxResponse));

      return ajaxResponse;
   }
      
   //게시물 수정 화면
   @RequestMapping(value="/notice/updateForm")
   public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
   {   
      //쿠키값
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      //게시물번호
      long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
      //조회항목(1:작성자, 2:제목, 3:내용)
      String searchType = HttpUtil.get(request, "searchType", "");
      //조회값
      String searchValue = HttpUtil.get(request, "searchValue", "");
      //현재페이지
      long curPage = HttpUtil.get(request, "curPage", (long)1);
      
      Notice notice = null;
      User user = null;
 
      if(bbsSeq > 0)
      {
         notice = noticeService.noticeView(bbsSeq);
         
         if(notice != null)
         {
            if(StringUtil.equals(notice.getUserId(), cookieUserId))
            {
               user = userService.userSelect(cookieUserId);
            }
            else
            {
               notice = null;
            }
         }
      }
      
      model.addAttribute("searchType", searchType);
      model.addAttribute("searchValue", searchValue);
      model.addAttribute("curPage", curPage);
      model.addAttribute("notice", notice);
      model.addAttribute("user", user);
      
      return "/notice/updateForm";
   }
   
   //게시물 수정
   @RequestMapping(value="/notice/updateProc", method=RequestMethod.POST)
   @ResponseBody
   public Response<Object> noticeUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
   {
      String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
      long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
      String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
      String bbsContent = HttpUtil.get(request, "bbsContent", "");
      FileData fileData = HttpUtil.getFile(request, "bbsFile", UPLOADNOTICE_SAVE_DIR);
      
      Response<Object> ajaxResponse = new Response<Object>();
      
      if(bbsSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
      {
         Notice notice = noticeService.noticeSelect(bbsSeq);
         
         if(notice != null)
         {
            if(StringUtil.equals(notice.getUserId(), cookieUserId));
            {
               notice.setBbsSeq(bbsSeq);
               notice.setBbsTitle(bbsTitle);
               notice.setBbsContent(bbsContent);
               
               if(fileData != null && fileData.getFileSize() > 0)
               {
                  NoticeFile noticeFile = new NoticeFile();
                  noticeFile.setFileName(fileData.getFileName());
                  noticeFile.setFileOrgName(fileData.getFileOrgName());
                  noticeFile.setFileExt(fileData.getFileExt());
                  noticeFile.setFileSize(fileData.getFileSize());
                  
                  notice.setNoticeFile(noticeFile);
               }
            }
            try
            {
               if(noticeService.noticeUpdate(notice) > 0)
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
               logger.error("[NoticeController] /notice/updateProc Exception", e);
               ajaxResponse.setResponse(500, "Internal Server Error");
            }
         }
         else
         {
            ajaxResponse.setResponse(404, "Not Found"); // 본인 게시물이 아님
         }
         
      }
      else
      {
         ajaxResponse.setResponse(400, "Bad Request");
      }
      
      logger.debug("[NoticeController] /notice/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
      
      return ajaxResponse;
   }
   
 //첨부파일 다운로드
   @RequestMapping(value="/notice/download")
   public ModelAndView download(HttpServletRequest request, HttpServletResponse response)
   {
      ModelAndView modelAndView = null;
      long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
      
      if(bbsSeq > 0)
      {
         NoticeFile noticeFile = noticeService.noticeFileSelect(bbsSeq);
         
         if(noticeFile != null)
         {
            File file = new File(UPLOADNOTICE_SAVE_DIR + FileUtil.getFileSeparator() + noticeFile.getFileName());

               logger.debug("UPLOADNOTICE_SAVE_DIR : " + UPLOADNOTICE_SAVE_DIR);
               logger.debug("FileUtil.getFileSeparator() : " + FileUtil.getFileSeparator());
               logger.debug("noticeFile.getFileName() : " + noticeFile.getFileName());
               
               if(FileUtil.isFile(file))
               {
 
                  modelAndView = new ModelAndView();
                  
                  //servlet-context.xml에 정의한 ID
                  modelAndView.setViewName("fileDownloadView");
                  modelAndView.addObject(file);
                  modelAndView.addObject("fileName", noticeFile.getFileName());
                  
                  return modelAndView;
               }
         }
      }
      
      return modelAndView;
   }
	   
}



package com.icia.itsmyplace.controller;

import java.io.File;
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
import org.springframework.web.servlet.ModelAndView;

import com.icia.common.model.FileData;
import com.icia.common.util.FileUtil;
import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.Comm;
import com.icia.itsmyplace.model.CommCmt;
import com.icia.itsmyplace.model.CommPht;
import com.icia.itsmyplace.model.Paging;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.service.CommService;
import com.icia.itsmyplace.service.UserService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;

@Controller("CommController")
public class CommController {

	private static Logger logger = LoggerFactory.getLogger(CommController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['uploadComm.save.dir']}")
	private String UPLOADCOMM_SAVE_DIR;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CommService commService;
	
	private static final int LIST_COUNT = 10;
	private static final int PAGE_COUNT = 5;
	
	//커뮤니티 게시판 리스트
	@RequestMapping(value="/community/list")
	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{	
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//조회항목(1:작성자조회, 2:제목조회, 3:내용조회)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);	
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<Comm> list = null;
		//조회 객체
		Comm search = new Comm();
		//페이징 객체
		Paging paging = null;
		
		User user = userService.userSelect(cookieUserId);
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		else {
			searchType = "";
			searchValue = "";
		}
		
		totalCount = commService.commListCount(search);
		
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0) {
			paging = new Paging("/community/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = commService.commList(search); 
			
			for(int i = 0; i<list.size(); i++)
			{
				CommCmt commCmtForList = new CommCmt();
				commCmtForList.setBbsSeq(list.get(i).getBbsSeq());
				
				List<CommCmt> commCmtList = commService.commCmtList(commCmtForList);
				
				int commCmtCnt = commCmtList.size();
				
				list.get(i).setCommCmtCnt(commCmtCnt);
			}
		}
		
		model.addAttribute("user", user);
		model.addAttribute("list", list);   
		model.addAttribute("searchType", searchType);   
		model.addAttribute("searchValue", searchValue); 
		model.addAttribute("curPage", curPage); 
		model.addAttribute("paging", paging);
		
		return "/community/list";		
	}
	
	//커뮤니티 게시판 게시물 등록 폼
	@RequestMapping(value="/community/writeForm")
	public String writeFrom(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		User user = userService.userSelect(cookieUserId);

		model.addAttribute("user", user);
		model.addAttribute("curPage", curPage);
		
		return "/community/writeForm";
	}
	
	//커뮤니티 게시판 게시물 등록처리
	@RequestMapping(value="/community/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeFormProc(MultipartHttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
				
		List<FileData> fileDataList = HttpUtil.getFiles(request, "commPht", UPLOADCOMM_SAVE_DIR);
		int fileDataCnt = fileDataList.size();
		
		Response<Object> ajaxResponse = new Response<Object>();
		
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
				
		if(!StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
		{
			Comm comm = new Comm();
			
			comm.setUserId(cookieUserId);
			comm.setBbsTitle(bbsTitle);
			comm.setBbsContent(bbsContent);			
						
			if(!StringUtil.isEmpty(fileDataList))
			{
				List<CommPht> commPhtList = new ArrayList<CommPht>();
				
				if(fileDataCnt > 5)
				{
					ajaxResponse.setResponse(800, "Too many File");
					return ajaxResponse;
				}
				else
				{
					for(int i=0; i<fileDataCnt; i++)
					{
						CommPht commPht = new CommPht();
						
						commPht.setPhtName(fileDataList.get(i).getFileName());
						commPht.setPhtOrgName(fileDataList.get(i).getFileOrgName());
						
						String fileExt = fileDataList.get(i).getFileExt();
						
						logger.debug("###############################");
						logger.debug("###########여기안타냐###########");
						logger.debug("###############################");
						
						if(!StringUtil.isEmpty(fileExt))
						{
							if(fileExt.equals("png") || fileExt.equals("jpg") || fileExt.equals("jpeg") || fileExt.equals("gif") )
							{
								commPht.setPhtExt(fileExt);
							}
							else
							{
								ajaxResponse.setResponse(900, "Invalidate Ext");
								return ajaxResponse;
							}
						}
						
						commPht.setPhtSize(fileDataList.get(i).getFileSize());
		
						commPhtList.add(commPht);				
					}
				}
				
				comm.setCommPhtList(commPhtList);
			}
			
			
//			if(!fileData.isEmpty() && fileDataCnt > 0)
//			{	
//				
//				List<CommPht> commPhtList = new ArrayList<CommPht>();
//				
//				for(int i = 0; i<fileDataCnt; i++)
//				{	
//					if(fileData.get(i).getFileSize() > 0)
//					{
//						CommPht commPht = new CommPht();
//						
//						commPht.setPhtName(fileData.get(i).getFileName());
//						commPht.setPhtOrgName(fileData.get(i).getFileOrgName());
//						
//						String fileExt = fileData.get(i).getFileExt();
//						
//						if(StringUtil.isEmpty(fileExt))
//						{							
//							if(fileExt.equals("png") || fileExt.equals("jpg") || fileExt.equals("jpeg") || fileExt.equals("gif") )
//							{
//								commPht.setPhtExt(fileExt);
//							}
//							else
//							{
//								ajaxResponse.setResponse(900, "Invalidate Ext");
//								return ajaxResponse;
//							}
//						}
//						
//						commPht.setPhtSize(fileData.get(i).getFileSize());
//					
//						commPhtList.add(commPht);
//					}					
//				}
//				
//				comm.setCommPhtList(commPhtList);	
//			}
			
			try
			{
				if(commService.commInsert(comm) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(500, "Internal Server error");
				}
			}
			catch(Exception e)
			{
				logger.error("[CommController]/community/writeProc Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error");
			}
		}	
		else
		{
			ajaxResponse.setResponse(400, "Bad request");
		}
			
		logger.debug("[CommController] /community/writeProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
			
		return ajaxResponse;
	}	
	
	//게시물보기
	@RequestMapping(value="/community/view")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		
		if(bbsSeq > 0)
		{
			commService.bbsReadCntPlus(bbsSeq);
			User user = userService.userSelect(cookieUserId);
			Comm comm = commService.commSelect(bbsSeq);
			String boardMe = "N";

			if(comm != null) {
			   List<CommPht> commPhtList = commService.commPhtList(bbsSeq);
			   comm.setCommPhtList(commPhtList);
		    }
			CommCmt commCmtForList = new CommCmt();
			commCmtForList.setBbsSeq(bbsSeq);
			
			List<CommCmt> list = commService.commCmtList(commCmtForList);
			
			if(comm != null && user != null)
			{
				if(comm.getUserId().equals(user.getUserId()))
				{
					boardMe = "Y";
				}
				
				for(int i=0; i<list.size(); i++)
				{
					if(list.get(i).getUserId().equals(user.getUserId()))
					{
						list.get(i).setCommentMe("Y");
					}
					else
					{
						list.get(i).setCommentMe("N");
					}
				}
			}
			
			model.addAttribute("user", user);
			model.addAttribute("boardMe", boardMe);
			model.addAttribute("comm", comm);			
			model.addAttribute("list", list);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("bbsSeq", bbsSeq);
			model.addAttribute("curPage", curPage);
		}
		
		return "/community/view";
	}
	
	//댓글등록
	@RequestMapping(value="/community/cmtWriteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> cmtWriteProc(HttpServletRequest request, HttpServletResponse response)
	{		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		long cmtGroup = HttpUtil.get(request, "cmtGroup", (long)0);
		String cmtContent = HttpUtil.get(request, "cmtContent", "");
		String cmtContentxxx = HttpUtil.get(request, "cmtContentxxx", "");
		
		Response<Object> ajaxResponse = new Response<Object>();

	    if(bbsSeq > 0 && !StringUtil.isEmpty(cookieUserId) && (!StringUtil.isEmpty(cmtContent) || !StringUtil.isEmpty(cmtContentxxx)))
	    {
	    	CommCmt commCmt = new CommCmt();
	    	
	    	commCmt.setBbsSeq(bbsSeq);
    		commCmt.setUserId(cookieUserId);
    		
    		if(!StringUtil.isEmpty(cmtContent))
    		{
    			commCmt.setCmtContent(cmtContent);
    			commCmt.setCmtIndent(0);
    			commCmt.setCmtOrder(1);
    		}
    		else
    		{
    			commCmt.setCmtContent(cmtContentxxx);
    			commCmt.setCmtIndent(1);
    			
    			CommCmt commCmtForList = new CommCmt(); 
    			commCmtForList.setBbsSeq(bbsSeq);
    			commCmtForList.setCmtGroup(cmtGroup);
    			
    			int listCnt = commService.commCmtList(commCmtForList).size();
    			
    			commCmt.setCmtOrder(listCnt + 1);
    		}

    		if(commService.commCmtInsert(commCmt) > 0)
    		{
    			if(commCmt.getCmtGroup() != cmtGroup)
    			{
    				int updateCnt = 0;
    				
    				commCmt.setCmtGroup(cmtGroup);
    				updateCnt = commService.commCmtUpdate(commCmt);
    				
    				if(updateCnt > 0)
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
    				ajaxResponse.setResponse(0, "Success");
    			}	
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
	    
	    logger.debug("[CommController] /community/cmtWriteProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
	    
	    return ajaxResponse;
	}
	
	//댓글수정
	@RequestMapping(value="/community/cmtUpdateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> cmtUpdateProc(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		long cmtSeq = HttpUtil.get(request, "cmtSeq", (long)0);
		String cmtContent = HttpUtil.get(request, "cmtContent", "");
		
		User user = userService.userSelect(cookieUserId);
		CommCmt commCmt = commService.commCmtSelect(bbsSeq, cmtSeq);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(user != null)
		{
			if(user.getUserId().equals(commCmt.getUserId()))
			{	
				if(!StringUtil.isEmpty(cmtContent))
				{
					commCmt.setCmtContent(cmtContent);
					
					if(commService.commCmtUpdate(commCmt) > 0)
					{						
						ajaxResponse.setResponse(0, "Success");
					}
					else
					{
						ajaxResponse.setResponse(500, "Fail");
					}
				}
				else
				{
					ajaxResponse.setResponse(900, "null content");
					return ajaxResponse;
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
		
			
		
	    logger.debug("[CommController] /community/cmtDelProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	
//	//댓글답글
//	@RequestMapping(value="/community/cmtReplyProc", method=RequestMethod.POST)
//	@ResponseBody
//	public Response<Object> cmtReplyProc(HttpServletRequest request, HttpServletResponse response)
//	{
//		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
//		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
//		String cmtContentxxx = HttpUtil.get(request, "cmtContentxxx", "");
//		
//		Response<Object> ajaxResponse = new Response<Object>();
//
//	    if(bbsSeq > 0 && !StringUtil.isEmpty(cmtContentxxx) && !StringUtil.isEmpty(cookieUserId))
//	    {
//	    	CommCmt commCmt = new CommCmt();
//	    	
//	    	int listCnt = commService.commCmtList(bbsSeq).size();
//	    	
//	    	commCmt.setBbsSeq(bbsSeq);
//    		commCmt.setUserId(cookieUserId);
//	    	commCmt.setCmtContent(cmtContentxxx);
//	    	commCmt.setCmtOrder(listCnt + 1);
//	    	commCmt.setCmtIndent(1);
//	    	
//    		if(commService.commCmtInsert(commCmt) > 0)
//    		{
//    			ajaxResponse.setResponse(0, "Success");
//    		}
//    		else
//    		{
//    			ajaxResponse.setResponse(500, "Internal Server Error");
//    		}
//	    }
//	    else
//	    {
//	    	ajaxResponse.setResponse(400, "Bad Request");
//	    }
//	    
//	    logger.debug("[CommController] /community/cmtReplyProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
//	    
//	    return ajaxResponse;
//	}
	
	
	//댓글삭제
	@RequestMapping(value="/community/cmtDelProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> cmtDelProc(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		long cmtSeq = HttpUtil.get(request, "cmtSeq", (long)1);
		
		User user = userService.userSelect(cookieUserId);		
		CommCmt commCmt = commService.commCmtSelect(bbsSeq, cmtSeq);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			if(user != null)
			{
				if(user.getUserId().equals(commCmt.getUserId()))
				{	
					int deleteAllCnt = 0;
					int deleteCnt = 0;
					
					if(commCmt.getCmtOrder() == 1)
					{	
						
						deleteAllCnt = commService.commCmtDeleteAll(commCmt);
					}
					else
					{
						
						deleteCnt = commService.commCmtDelete(commCmt);
					}
					
					if(deleteAllCnt > 0 || deleteCnt > 0)
					{	
						List<CommCmt> commCmtList = commService.commCmtList(commCmt);
						
						//반복문 시작번호 인덱스 (삭제할 댓글의 인덱스값)
						int repeatIndex = commCmt.getCmtOrder()-1;
						
						//업데이트문 커밋횟수
						int updateCount = 0;
						
						//반복문 반복횟수
						int repeatCount = commCmtList.size()-repeatIndex;
						
						for(int i = repeatIndex; i < commCmtList.size(); i++)
						{
							commCmtList.get(i).setCmtOrder(i+1);							//댓글 리스트중 인덱스 i인 댓글의 오더값 세팅
							updateCount += commService.commCmtUpdate(commCmtList.get(i));	//오더값 세팅된 댓글 DB 업데이트					
						}
	
						if(updateCount == repeatCount)
						{
							ajaxResponse.setResponse(0, "성공");
						}
						else
						{
							ajaxResponse.setResponse(500, "실패");
						}
					}
					else
					{
						ajaxResponse.setResponse(500, "실패");
					}
				}
				else
				{
					ajaxResponse.setResponse(404, "유저가 다름");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "유저정보 없음");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
			
		
	    logger.debug("[CommController] /community/cmtDelProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
	    
	    return ajaxResponse;
	}
	
	//글수정폼
	@RequestMapping(value="/community/updateForm")
	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		User user = userService.userSelect(cookieUserId);
		Comm comm = commService.commSelect(bbsSeq);
		List<CommPht> commPhtList = commService.commPhtList(bbsSeq);
		comm.setCommPhtList(commPhtList);
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			if(user.getUserId().equals(comm.getUserId()))
			{
				model.addAttribute("comm", comm);
				model.addAttribute("bbsSeq", bbsSeq);
				model.addAttribute("user", user);
				model.addAttribute("curPage", curPage);
				
				return "/community/updateForm";
			}
			else
			{
				return "/community/list";
			}
		}
		return "/community/list";		
	}
	
	//글수정
	@RequestMapping(value="/community/updateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		String[] phtNumListOrg = HttpUtil.gets(request, "phtNum");
		
		//첨부사진 삭제를 위한 사진번호 수신
		List<Short> phtNumList = new ArrayList<Short>();
		if(phtNumListOrg != null)
		{
			for(int k=0; k<phtNumListOrg.length; k++)
			{
				phtNumList.add(StringUtil.stringToShort(phtNumListOrg[k], (short)0));
			}		
		}
			
		List<FileData> fileDataList = HttpUtil.getFiles(request, "commPht", UPLOADCOMM_SAVE_DIR);
		int fileDataCnt = fileDataList.size();

		Response<Object> ajaxResponse = new Response<Object>();
		
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
		
		Comm comm = commService.commSelect(bbsSeq);
		List<CommPht> commPhtList = commService.commPhtList(bbsSeq);
		int phtListCnt = commPhtList.size();
		
		int totalPhtCnt = fileDataCnt + commPhtList.size();
		
		if(!StringUtil.isEmpty(cookieUserId) && !StringUtil.isEmpty(bbsSeq) && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
		{
			if(comm != null)
			{
				comm.setBbsSeq(bbsSeq);
				comm.setBbsTitle(bbsTitle);
				comm.setBbsContent(bbsContent);
				
				if(fileDataList != null)
				{
					logger.debug("자 보세요 totalPhtCnt는 " + totalPhtCnt);
					
					if((totalPhtCnt) > 5)
					{
						ajaxResponse.setResponse(800, "Too many File");
						return ajaxResponse;
					}
					else
					{
						for(int i=0; i<fileDataCnt; i++)
						{
							CommPht commPht = new CommPht();
							
							commPht.setBbsSeq(bbsSeq);
							commPht.setPhtNum((short)((i+1)+phtListCnt));
							commPht.setPhtName(fileDataList.get(i).getFileName());
							commPht.setPhtOrgName(fileDataList.get(i).getFileOrgName());
							
							String fileExt = fileDataList.get(i).getFileExt();
							
							if(!StringUtil.isEmpty(fileExt))
							{
								if(fileExt.equals("png") || fileExt.equals("jpg") || fileExt.equals("jpeg") || fileExt.equals("gif") )
								{
									commPht.setPhtExt(fileExt);
								}
								else
								{
									ajaxResponse.setResponse(900, "Invalidate Ext");
									return ajaxResponse;
								}
							}
							
							commPht.setPhtSize(fileDataList.get(i).getFileSize());
			
							commPhtList.add(commPht);				
						}
					}
				}
								
				if(phtNumList.size() > 0)
				{	
					CommPht commPht = new CommPht();
					
					for(int j=0; j<phtNumList.size(); j++)
					{
						commPht.setBbsSeq(bbsSeq);
						commPht.setPhtNum(phtNumList.get(j));
						
						commService.commPhtDelete(commPht);
					}				
					
					List<CommPht> commPhtListModel = commService.commPhtList(bbsSeq);
					
					if(commPhtListModel != null)
					{
						short a = 0;
						
						while(a < commPhtListModel.size())
						{
							commPhtListModel.get(a).setPhtNumForUpdate((short)(1+a));
							
							commService.commPhtUpdate(commPhtListModel.get(a));
							
							a++;										
						}					
						
					}
						
				}
				
				comm.setCommPhtList(commPhtList);
								
				if(commService.commUpdate(comm, fileDataList) > 0)
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
				ajaxResponse.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request");
		}
		
		return ajaxResponse;
	}
	
	//게시글삭제
	@RequestMapping(value="community/commDeleteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> deleteProc(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		
		User user = userService.userSelect(cookieUserId);
		Comm comm = commService.commSelect(bbsSeq);
		CommCmt commCmt = new CommCmt();
		commCmt.setBbsSeq(bbsSeq);
		
		List<CommCmt> commCmtList = commService.commCmtList(commCmt);
		List<CommPht> commPhtList = commService.commPhtList(bbsSeq);
		
		System.out.println("#########################");
        System.out.println("cmt, pht = " + (commCmtList == null) + "  " + (commPhtList == null));
        System.out.println("#########################");
        
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(user != null && comm != null && user.getUserId().equals(comm.getUserId()))
		{
			if(commCmtList != null)
			{
				if(commService.commCmtDeleteAll(commCmt) == 0)
				{
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
			}
			if(commPhtList != null)
			{
				if(commService.commPhtDeleteAll(bbsSeq) == 0)
				{
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
			}
			
			if(commService.commDelete(bbsSeq) > 0)
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
		
		logger.debug("[CommController] /community/commDelProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
	
	//첨부파일 다운로드
	@RequestMapping(value="/community/download", method=RequestMethod.GET)
	public ModelAndView download(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		short phtNum = HttpUtil.get(request, "phtNum", (short)0);
		
		if(bbsSeq > 0)
		{
			CommPht commPht = new CommPht();
			commPht.setBbsSeq(bbsSeq);
			commPht.setPhtNum(phtNum);
			
			CommPht commPhtResult = commService.commPhtSelect(commPht);
			
			if(commPhtResult != null) {
				
				File file = new File(UPLOADCOMM_SAVE_DIR + FileUtil.getFileSeparator() + commPhtResult.getPhtName());		
				
				if(FileUtil.isFile(file)) {
					
					modelAndView = new ModelAndView();
				
					modelAndView.setViewName("fileDownloadView");
					modelAndView.addObject(file);
					modelAndView.addObject("fileName", commPhtResult.getPhtOrgName());
					
				}
			}
		}
		return modelAndView;
	}
}

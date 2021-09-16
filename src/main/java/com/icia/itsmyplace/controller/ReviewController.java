package com.icia.itsmyplace.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.CommPht;
import com.icia.itsmyplace.model.Paging;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.Review;
import com.icia.itsmyplace.model.ReviewPht;
import com.icia.itsmyplace.service.ReviewService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;

@Controller("reviewController")
public class ReviewController
{
	private static Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['uploadReview.save.dir']}")
	private String UPLOADREVIEW_SAVE_DIR;
	
	@Autowired
	private ReviewService reviewService;
	
	private static final int LIST_COUNT = 8; 	// 한 페이지의 게시물 수
	private static final int PAGE_COUNT = 5;	// 페이징 수
	
	@RequestMapping(value="/review/list")
	public String review(Model model, HttpServletRequest request, HttpServletResponse response)
	{
		//예약번호
		long rsrvSeq = HttpUtil.get(request, "rsrvSeq", (long)0);
		//조회항목(1:카페 조회, 2:제목조회, 3:내용조회)
		String searchType = HttpUtil.get(request, "searchType");
		//조회값 
		String searchValue = HttpUtil.get(request, "searchValue");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//총 게시물 수
		long totalCount = 0;
		//게시물 리스트
		List<Review> list = null;
		//조회 객체
		Review search = new Review();
		//페이징 객체
		Paging paging = null;
		
		//쿠키값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//본인글 여부
		String reviewMe = cookieUserId;
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
		}
		else
		{
			searchType = "";
			searchValue = "";
		}
		
		totalCount = reviewService.reviewListCount(search);
		
		logger.debug("totalCount : " + totalCount);
		
		if(totalCount > 0)
		{
			paging = new Paging("/review/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = reviewService.reviewList(search);
		}
		
		model.addAttribute("reviewList", list);   
		model.addAttribute("searchType", searchType);   
		model.addAttribute("searchValue", searchValue); 
		model.addAttribute("curPage", curPage); 
		model.addAttribute("paging", paging);
		model.addAttribute("rsrvSeq", rsrvSeq);
		model.addAttribute("reviewMe", reviewMe);
		

		return "/review/list";
	}
	
	//모달 사진 조회
	@RequestMapping(value="/review/modalPhtList", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> modalPhtList(HttpServletRequest request, HttpServletResponse response)
	{
		long rsrvSeq = HttpUtil.get(request, "rsrvSeq", (long)0);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		try
		{
			List<ReviewPht> list = reviewService.modalPhtList(rsrvSeq);
			
			if(list.size() > 0)
			{
				ajaxResponse.setCode(0);
				ajaxResponse.setMsg("Success");
				ajaxResponse.setData(list);
			}
			else
			{
				ajaxResponse.setCode(500);
				ajaxResponse.setMsg("Fail");
			}
				
		}
		catch(Exception e)
		{
			logger.error("[ReviewController] /review/modalPhtList Exception", e);
		}
		
		return ajaxResponse;
	}

	//게시물 수정 화면
	@RequestMapping(value="/review/reviewUpdate")
	public String reviewUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//예약번호
		long rsrvSeq = HttpUtil.get(request, "rsrvSeq", (long)0);
		//조회항목(1:카페이름, 2:제목, 3:내용)
		String searchType = HttpUtil.get(request, "searchType", "");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		Review review = reviewService.reviewSelect(rsrvSeq);
		
		List<ReviewPht> reivewPhtList= reviewService.modalPhtList(rsrvSeq);
		
		review.setReviewPhtList(reivewPhtList);
		
		
		/*
		 * if(rsrvSeq > 0) { review = reviewService.reviewSelect(rsrvSeq); }
		 */
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("review", review);
		model.addAttribute("rsrvSeq", rsrvSeq);
		
		return "/review/reviewUpdate";
	}

	//게시물 수정 폼
	@RequestMapping(value="/review/reviewUpdateProc", method=RequestMethod.POST)
	@ResponseBody
   	public Response<Object> reviewUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
   	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long rsrvSeq = HttpUtil.get(request, "rsrvSeq", (long)0);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		double bbsStar = HttpUtil.get(request, "bbsStar", 5.0);
		String bbsPublic = HttpUtil.get(request, "bbsPublic", "Y");
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
		
		List<FileData> fileDataList = HttpUtil.getFiles(request, "reviewPht", UPLOADREVIEW_SAVE_DIR);
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
			//fileDataCnt = 0;
		}
		
		Review review = reviewService.reviewSelect(rsrvSeq);
		List<ReviewPht> reviewPhtList = new ArrayList<ReviewPht>();
		int phtListCnt = reviewPhtList.size();
		
		//int totalPhtCnt = fileDataCnt + reviewPhtList.size();
      
		if(rsrvSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent))
		{
			if(review != null)
			{
				if(StringUtil.equals(review.getUserId(), cookieUserId))
				{
					review.setRsrvSeq(rsrvSeq);
					review.setBbsTitle(bbsTitle);
					review.setBbsContent(bbsContent);
					review.setBbsStar(bbsStar);
					review.setBbsPublic(bbsPublic);
               
					if(fileDataList != null && fileDataList.size() > 0)
					{
						 for(int i=0; i<fileDataList.size(); i++)
						{
							ReviewPht reviewPht = new ReviewPht();
								
							reviewPht.setPhtName(fileDataList.get(i).getFileName());
							reviewPht.setPhtOrgName(fileDataList.get(i).getFileOrgName());
							reviewPht.setPhtSize(fileDataList.get(i).getFileSize());
							reviewPht.setRsrvSeq(rsrvSeq);
							reviewPht.setPhtNum((short)((i+1)+phtListCnt));
							
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
					 }
					
					if(phtNumList.size() > 0)
					{	
						ReviewPht reviewPht = new ReviewPht();
						
						for(int j=0; j<phtNumList.size(); j++)
						{
							reviewPht.setRsrvSeq(rsrvSeq);
							reviewPht.setPhtNum(phtNumList.get(j));
							
							reviewService.reviewPhtDelete(reviewPht);
						}				
						
						List<ReviewPht> reviewListModel = reviewService.modalPhtList(rsrvSeq);
						
						if(reviewListModel != null)
						{
							short a = 0;
							
							while(a < reviewListModel.size())
							{
								reviewListModel.get(a).setPhtNumForUpdate((short)(1+a));
								
								reviewService.reviewPhtUpdate(reviewListModel.get(a));
								
								a++;										
							}					
							
						}
							
					}
	
					review.setReviewPhtList(reviewPhtList);
            
					try
					{
						if(reviewService.reviewUpdate(review, fileDataList) > 0)
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
	               		logger.error("[ReviewController] /review/reviewUpdateProc Exception", e);
	               		
	               		ajaxResponse.setResponse(500, "500 Internal Server Error"); 
	        		}
	         	}      
	         	else
				{
	            	ajaxResponse.setResponse(404, "404 Not Found");  //본인 게시물이 아닙니다.
	         	}
	      
			}
	      	else 
	      	{
		         ajaxResponse.setResponse(400, "400 Bad Request");
			}
			
	      	logger.debug("[ReviewController] /review/reviewUpdateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
	      	
	    return ajaxResponse;
   	}
	
	//게시물 삭제
	@RequestMapping(value="/review/reviewDelete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> reviewDelete(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long rsrvSeq = HttpUtil.get(request, "rsrvSeq", (long)0);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(rsrvSeq > 0)
		{
			//여기를 한 번 물어볼까?
			Review review = reviewService.reviewSelect(rsrvSeq);

			if(review != null)
			{
				if(StringUtil.equals(review.getUserId(), cookieUserId))
				{
					try 
					{
						if(reviewService.reviewDelete(review.getRsrvSeq()) > 0)
						{
							ajaxResponse.setResponse(0, "success");
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal Server Error 500");
						}	
					} 
					catch(Exception e) 
					{
						logger.error("[ReviewController] /review/reviewDelete Exception", e);
					}
				}
				else 
				{
					ajaxResponse.setResponse(400, "Not Found 400");
				}
			}
			else 
			{
				ajaxResponse.setResponse(400, "Not Found 400");
			}
		}
		else 
		{
			ajaxResponse.setResponse(400, "Bad Request 400");
		}
		
		logger.debug("[ReviewController] /reivew/reviewDelete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		return ajaxResponse;
	}
}

package com.icia.itsmyplace.controller;

import java.time.LocalTime;
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

import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.Cafe;
import com.icia.itsmyplace.model.CafePht;
import com.icia.itsmyplace.model.EventBoard;
import com.icia.itsmyplace.model.EventBoardFile;
import com.icia.itsmyplace.model.Paging;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.Review;
import com.icia.itsmyplace.model.ReviewPht;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.service.CafeService;
import com.icia.itsmyplace.service.EventBoardService;
import com.icia.itsmyplace.service.ReviewService;
import com.icia.itsmyplace.service.UserService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;

/**
 * <pre>
 * 패키지명   : com.icia.web.controller
 * 파일명     : IndexController.java
 * 작성일     : 2021. 1. 21.
 * 작성자     : daekk
 * 설명       : 인덱스 컨트롤러
 * </pre>
 */
@Controller("indexController") // 컨트롤러임을 나타냄 어노테이션은 소문자로 시작
public class IndexController
{
	private static Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	private static final int LIST_COUNT = 3; 	// 한 페이지의 게시물 수
	private static final int PAGE_COUNT = 1;	// 페이징 수
	
	@Autowired
	private UserService userService;

	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private CafeService cafeService;
	
	@Autowired
	private EventBoardService eventBoardService;
	
	@RequestMapping(value="/index", method=RequestMethod.GET) //GET 방식으로 호출
	// 어떤 메소드가 처리할지를 매핑하기 위한 어노테이션 (요청이들어왔을때)
	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{	
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		User user = userService.userSelect(cookieUserId);
		
		if(!StringUtil.isEmpty(user))
		{
			model.addAttribute("user", user);
		}
		
		//전체 카페 조회
		List<Cafe> cafeList = cafeService.cafeList();
		
		//cafeNum 매개변수가 담길 그릇 생성
		CafePht cafePht = new CafePht();
		
		
		//조회된 카페수만큼 반복문 실행
		for(int i=0; i<cafeList.size(); i++)
		{
			//사진 개수 구하기 위해 cafeNum 매개변수 세팅
			cafePht.setCafeNum(cafeList.get(i).getCafeNum());
						
			List<CafePht> cafePhtList = cafeService.cafePhtList(cafePht);
			
			cafeList.get(i).setCafePhtList(cafePhtList);
		}
		
		//이벤트 리스트 조회위한 매개변수용 객체 생성
		EventBoard event = new EventBoard();
		
		//객체에 Y 세팅
		event.setSearchStatus("Y");
		event.setStartRow(1);
		event.setEndRow(3);
		
		//전체 진행중 이벤트목록 조회
		List<EventBoard> eventList = eventBoardService.eventBoardList(event);
		
		//첨부사진 조회를 위한 객체 생성
		for(int k=0; k<eventList.size(); k++)
		{
			//이벤트시간 일자만 가져오도록 변환
			String opnDate = eventList.get(k).getEvtOpnDate();
			String clsDate = eventList.get(k).getEvtClsDate();
			
			eventList.get(k).setEvtOpnDate(StringUtil.substring(opnDate, 2, 10));  
			eventList.get(k).setEvtClsDate(StringUtil.substring(clsDate, 2, 10));
			
			//첨부사진 조회
			EventBoardFile eventBoardFile = eventBoardService.eventBoardFileSelect(eventList.get(k).getBbsSeq());
			
			//이벤트 게시물이 사진을 포함하고 있으면 리스트객체에 세팅
			if(!StringUtil.isEmpty(eventBoardFile))
			{
				eventList.get(k).setEventBoardFile(eventBoardFile);
			}
		}
		
		//진행중인 이벤트 개수가 세개 미만이면 종료이벤트까지 추가
		if(eventList.size() < 3)
		{
			event.setSearchStatus("N");
			event.setStartRow(1);
			event.setEndRow(3-eventList.size());
			
			List<EventBoard> endEventList = eventBoardService.eventBoardList(event);
			
			for(int n=0; n < endEventList.size(); n++)
			{	
				//이벤트시간 일자만 가져오도록 변환
				String opnDate = endEventList.get(n).getEvtOpnDate();
				String clsDate = endEventList.get(n).getEvtClsDate();
				
				endEventList.get(n).setEvtOpnDate(StringUtil.substring(opnDate, 2, 10));
				endEventList.get(n).setEvtClsDate(StringUtil.substring(clsDate, 2, 10));
				
				EventBoardFile endEventBoardFile = eventBoardService.eventBoardFileSelect(endEventList.get(n).getBbsSeq());
				
				//이벤트 게시물이 사진을 포함하고 있으면 리스트객체에 세팅
				if(!StringUtil.isEmpty(endEventBoardFile))
				{
					endEventList.get(n).setEventBoardFile(endEventBoardFile);
				}
				
				eventList.add(endEventList.get(n));
			}	
			
		}
		System.out.println(eventList.size());
		
		model.addAttribute("cafeList", cafeList);
		model.addAttribute("eventList", eventList);
		
		//아래부터는 리뷰관련
		//예약번호
		long rsrvSeq = HttpUtil.get(request, "rsrvSeq", (long)0);
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
		
		//본인글 여부
		String reviewMe = cookieUserId;
		
		totalCount = reviewService.reviewListCount(search);
		
		logger.debug("totalCount: " + totalCount);
		
		if(totalCount > 0)
		{
			paging = new Paging("/index", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = reviewService.reviewList2(search);
		}
		
		model.addAttribute("reviewList", list);
		model.addAttribute("curPage", curPage); 
		model.addAttribute("paging", paging);
		model.addAttribute("rsrvSeq", rsrvSeq);
		model.addAttribute("reviewMe", reviewMe);

		return "/index";
	}
	
	//모달 사진 조회
	@RequestMapping(value="/index/modalPhtList", method=RequestMethod.POST)
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
			logger.error("[IndexController] /review/modalPhtList Exception", e);
		}
		
		return ajaxResponse;
	}
	 
	
	//인덱스에서 카페별 자리수 표기 목적
	@RequestMapping(value="/index/indexProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> indexProc(HttpServletRequest request, HttpServletResponse response)
	{
		LocalTime now = LocalTime.now();
		int startHourA = now.getHour() * 100;
		int endHourA = (now.getHour() + 2) * 100;
				
		Response<Object> ajaxResponse = new Response<Object>();
		
		List<Cafe> cafeList = cafeService.cafeList();
		
		for(int i=0; i<cafeList.size(); i++)
		{	
			List<RsRv> rsRvSeatList = cafeService.rsRvSelectList(cafeList.get(i).getCafeNum());
			
			String str = "";
			for(int j=0; j<rsRvSeatList.size(); j++) { // select 1501 <= 1700 <= 1899

				if(startHourA <= Integer.parseInt(rsRvSeatList.get(j).getRsrvTime()) && 
						endHourA >= Integer.parseInt(rsRvSeatList.get(j).getRsrvTime()) )
				{
					str = str + rsRvSeatList.get(j).getSeatList() + ",";
				}
			}
			
			String[] Astr = str.split(",");
			String switchCnt = "";
			
			for(int a=0; a<Astr.length; a++) {
				
				int AstrInt = Integer.parseInt(StringUtil.nvl(Astr[a], "0"));
				
				if(AstrInt > 16)
				{
					switchCnt += "A";
				}
				else if(AstrInt > 12)
				{
					switchCnt += "B";
				}
				else if(AstrInt > 8)
				{
					switchCnt += "C";
				}
				else if(AstrInt > 4)
				{
					switchCnt += "D";
				}
				else if(AstrInt == 0)
				{
					switchCnt += "F";
				}
				else
				{
					switchCnt += "E";
				}
			}
			
			System.out.println("##########");
			System.out.println(switchCnt);
			System.out.println("##########");
			
			char a = switchCnt.charAt(0);
			int cntA = 1;
			
			if(!switchCnt.equals("F"))
			{
				for(int k=0; k<switchCnt.length(); k++)
				{
					if(a != switchCnt.charAt(k))
					{
						a = switchCnt.charAt(k);
						cntA++;
					}
				}
			}
			else
			{
				cntA = 0;
			}
			
			System.out.println("##########");
			System.out.println(cntA);
			System.out.println("##########");
			
			int seatVacancyCnt = 0;
			
			seatVacancyCnt = 20 - (cntA * 4);
			
			cafeList.get(i).setSeatVacancyCnt(seatVacancyCnt);
			
		}
				
		if(!StringUtil.isEmpty(cafeList))
		{
			ajaxResponse.setResponse(0, "Success", cafeList);
		}
		else
		{
			ajaxResponse.setResponse(500, "Internal Server Error");
		}
		
		logger.debug("[IndexController] indexProc response");
				
		return ajaxResponse;
	}
	
	//사이트소개
    @RequestMapping(value="/itsmyplace", method=RequestMethod.GET)
    public String itsmyplace(HttpServletRequest request, HttpServletResponse response)
    {
        return "/itsmyplace";
    }
    
    //공지사항
    @RequestMapping(value="/notice", method=RequestMethod.GET)
    public String notice(HttpServletRequest request, HttpServletResponse response)
    {
        return "/notice";
    }
    
    //footer
    @RequestMapping(value="/contact", method=RequestMethod.GET)
    public String contact(HttpServletRequest request, HttpServletResponse response)
    {
        return "/contact";
    }
}

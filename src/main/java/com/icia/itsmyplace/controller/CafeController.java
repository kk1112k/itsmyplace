package com.icia.itsmyplace.controller;

import java.util.ArrayList;
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
import com.icia.itsmyplace.model.Cafe;
import com.icia.itsmyplace.model.CafePht;
import com.icia.itsmyplace.model.MenuPht;
import com.icia.itsmyplace.model.Order;
import com.icia.itsmyplace.model.Pay;
import com.icia.itsmyplace.model.Point;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.Review;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.Seat;
import com.icia.itsmyplace.model.SubArea;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.service.AreaService;
import com.icia.itsmyplace.service.CafeService;
import com.icia.itsmyplace.service.ReviewService;
import com.icia.itsmyplace.service.RsRvService;
import com.icia.itsmyplace.service.RsrvSeqService;
import com.icia.itsmyplace.service.UserService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;

import sun.nio.fs.DefaultFileSystemProvider;

@Controller("cafeController")
public class CafeController {
private static Logger logger = LoggerFactory.getLogger(CafeController.class);

	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CafeService cafeService;
	
	@Autowired
	private RsRvService rsRvService;
	
	@Autowired
	private RsrvSeqService rsrvSeqService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private AreaService areaService;
	
	private static final int LIST_COUNT = 4; 	// 한 페이지의 게시물 수
	private static final int PAGE_COUNT = 1;	// 페이징 수
	

	
	//카페소개글
	@RequestMapping(value="/cafe/intro", method=RequestMethod.GET)
	public String intro(Model model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);//쿠키정보가져옴
		
		if(!StringUtil.isEmpty(cookieUserId)) {
			User user = userService.userSelect(cookieUserId);
			model.addAttribute("user", user);
		}
		List<Cafe> cafeList = cafeService.cafeList();
		
		List<String> cafeNumList = new ArrayList<String>();
		 
		 for(int i=0; i<cafeList.size(); i++) { 
			 String cafeNum = cafeService.cafeList().get(i).getCafeNum();
			 
			 SubArea subArea =  areaService.areaNameSelect(cafeList.get(i).getSubAreaNum());
			 
			 CafePht cafePht = new CafePht();
			 cafePht.setCafeNum(cafeNum);
			 cafePht.setPhtNum((short)2);
			 			 
			 List<CafePht> cafePhtList = cafeService.cafePhtList(cafePht);
			 List<Review> reviewList = reviewService.cafeReviewList(cafeNum);
			 
			 cafeList.get(i).setCafePhtList(cafePhtList);
			 cafeList.get(i).setReviewList(reviewList);
			 cafeList.get(i).setAreaName(subArea.getAreaName());
			 cafeList.get(i).setSubAreaName(subArea.getSubAreaName());
			 cafeNumList.add(cafeNum);
		 }
		 	
		 
//		List<Review> reviewList = new ArrayList<Review>();
//		
//		for(int i=0; i<cafeNumList.size(); i++)
//		{
//			List<Review> reviewListForSet = reviewService.allCafeReviewList(cafeNumList.get(i));
//			
//			reviewList.add(reviewListForSet.get(0));
//		}
		
		model.addAttribute("cafeList",cafeList);
//		model.addAttribute("reviewList", reviewList);
		//model.addAttribute("reviewMe", reviewMe);

		
		return "/cafe/intro";
	}
	
	//카페별 상세페이지
	@RequestMapping(value="/cafe/detail", method=RequestMethod.GET)
    public String cafeDetail(Model model, HttpServletRequest request, HttpServletResponse response)
    {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);//쿠키정보가져옴
		String cafeNum = HttpUtil.get(request, "cafeNum", "");
		
		if(!StringUtil.isEmpty(cookieUserId)) {
			User user = userService.userSelect(cookieUserId);
			model.addAttribute("user", user);
		}
		//게시물 리스트
		List<Review> list = null;
		list = reviewService.cafeReviewList(cafeNum);
		model.addAttribute("list", list);
		model.addAttribute("cafeNum", cafeNum);
				
		//content 연동하면서 추가한 부분
		//위에 cafeNum도 바뀜
		
		List<String> bestSellerMenuNum = cafeService.BestSellerList(cafeNum);
		
		MenuPht menuPhtforSelect = new MenuPht();
		menuPhtforSelect.setCafeNum(cafeNum);
		
		List<MenuPht> menuPhtList = new ArrayList<MenuPht>();
		
		for(int i=0; i<bestSellerMenuNum.size(); i++)
		{
			menuPhtforSelect.setMenuNum(bestSellerMenuNum.get(i));
			MenuPht menuPht = cafeService.bestMenuPhtSelect(menuPhtforSelect);
			menuPhtList.add(menuPht);
		}

		model.addAttribute("menuPhtList", menuPhtList);
		
		Cafe cafe = cafeService.cafeSelect(cafeNum);
		CafePht cafePhtModelforPhtList = new CafePht();
		cafePhtModelforPhtList.setCafeNum(cafeNum);

		List<CafePht> cafephtList = cafeService.cafePhtList(cafePhtModelforPhtList);
		cafe.setCafePhtList(cafephtList);
		
		model.addAttribute("cafe", cafe);
		
		List<Cafe> cafeList = cafeService.cafeList();
		CafePht cafePhtAll = new CafePht();
		List<Cafe> cafeForAllList = new ArrayList<Cafe>();
		for(int j=0; j<cafeList.size(); j++)
		{	Cafe cafeForAll = new Cafe();
			cafePhtAll.setCafeNum(cafeList.get(j).getCafeNum());
			List<CafePht> cafePhtListAll = cafeService.cafePhtList(cafePhtAll);
			cafeForAll.setCafePhtList(cafePhtListAll);
			cafeForAll.setCafeNum(cafeList.get(j).getCafeNum());
			cafeForAll.setCafeName(cafeList.get(j).getCafeName());
			cafeForAll.setCafeOpnHrs(cafeList.get(j).getCafeOpnHrs());
			cafeForAll.setCafeClsHrs(cafeList.get(j).getCafeClsHrs());
			cafeForAll.setCafeAddr(cafeList.get(j).getCafeAddr());
			cafeForAllList.add(cafeForAll);
		}
		
		model.addAttribute("cafeForAllList", cafeForAllList);
		
        return "/cafe/detail";
    }

	//예약번호 rsrvSeq RSRV, PAY, TBL_ORDER에서 가져올수있음
	//예약카페이름(번호로 조인해서 가져오기) cafeservice.cafeSelect(cafe)
	//예약자리 RSRV에서 가져오기
	//예약된 시간(내가 등장할 날짜와 시간)  RSRV에서 DATE랑 TIME 가져오기
	//주문내역 ORDER에서 MENU_NUM에 대한거를 CAFE_NUM과 조인해서 정보 가져오기
	//결제된금액 PAY테이블에서 가져오기 TOTALPRICE
	//결제방법은 그냥 하드코딩

	
	//예약 폼. 코드 짰을때 데이터 들고 들어가야함
	@RequestMapping(value="/cafe/reservation", method=RequestMethod.GET)
	public String reservation(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);//쿠키정보가져옴
		String cafeNum = request.getParameter("cafeNum");
		
		//좌석리스트
		List<Seat> seat = null;
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			User user = userService.userSelect(cookieUserId);
			model.addAttribute("user", user);
		}
			
		//카페 조회
		Cafe cafe = cafeService.cafeSelect(cafeNum);
		model.addAttribute("cafe", cafe);
	
		//카페 조회
		seat = cafeService.seatSelect(cafeNum);
		model.addAttribute("seat", seat);
			
		return "/cafe/reservation";
	}
	
	//커피 메뉴선택 화면
	@RequestMapping(value="/cafe/reservationNext", method=RequestMethod.POST)
    public String reservationNext(ModelMap model, HttpServletRequest request, HttpServletResponse response)
    {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);//쿠키정보가져옴
		String cafeNum = request.getParameter("cafeNum"); // 카페번호 - 카페테이블 
		String arr = request.getParameter("arr"); //좌석번호(자리) - rsrv
		String timeSel = request.getParameter("timeSelA"); //예약할시간 - rsrv
		int pplCnt = Integer.parseInt(request.getParameter("pplCnt")); // 예약된인원수 - rsrv
		String clockServer = request.getParameter("clockServer"); //현재날짜(결제날짜) - rsrv
		
		User user = userService.userSelect(cookieUserId);
		
		long rsrvSeq = rsrvSeqService.selectRsrvSeq();
		System.out.println("CafeController rsrvSeq = " + rsrvSeq);
		RsRv rsRv = new RsRv();
		rsRv.setRsrvSeq(rsrvSeq);
		rsRv.setUserName(user.getUserName());
		rsRv.setRsrvTime(timeSel); //예약시간 카페에예약한사람이등장할시간
		rsRv.setRsrvDate(clockServer); //현재날짜(시간)
		rsRv.setRsrvPplCnt(pplCnt); //인원수
		rsRv.setSeatList(arr); // 10,11,13
		model.addAttribute("rsRv", rsRv); // Reservation
		
		Cafe cafe = cafeService.cafeSelect(cafeNum);
		model.addAttribute("cafe", cafe); // cafeName

		//메뉴리스트
		List<MenuPht> menuPht = null;		
		menuPht = cafeService.menuPhtSelect(cafeNum);
		model.addAttribute("menuPht", menuPht);
		
		model.addAttribute("user", user);
		
		return "/cafe/reservationNext";
    }
	
	@RequestMapping(value="/cafe/selectSeatTime", method=RequestMethod.POST)
	@ResponseBody
    public Response<Object> selectSeatTime(HttpServletRequest request, HttpServletResponse response)
    {
		int selectTime = Integer.parseInt(HttpUtil.get(request, "time"));
		
		String cafeNum = HttpUtil.get(request, "cafeNum");
		
		int timeA =  selectTime - 199;
		int timeB =  selectTime + 199;
		System.out.println("*************************");
		System.out.println("selectTime = " + selectTime);
		System.out.println("timeA = " + timeA);
		System.out.println("timeB = " + timeB);
		System.out.println("*************************");
		
		List<RsRv> rsRvSeatList = cafeService.rsRvSelectList(cafeNum);
		
		
		for(int i=0; i<rsRvSeatList.size(); i++) {
			System.out.println("######################");
			System.out.println("rsRvSeat " + rsRvSeatList.get(i).getRsrvDate());
			System.out.println("rsRvSeat " + rsRvSeatList.get(i).getRsrvTime());
			System.out.println("rsRvSeat " + rsRvSeatList.get(i).getSeatList());
			System.out.println("######################");
		}

		String str = "";
		int cnt = 0;
		for(int j=0; j<rsRvSeatList.size(); j++) { // select 1501 <= 1700 <= 1899

			if(timeA <= Integer.parseInt(rsRvSeatList.get(j).getRsrvTime()) && 
			   timeB >= Integer.parseInt(rsRvSeatList.get(j).getRsrvTime()) )
			{
				str = str + rsRvSeatList.get(j).getSeatList() + ",";
				cnt++;
			}
		}
		System.out.println("#####################");
		System.out.println("str = " + str);
		System.out.println("#####################");
		
		String[] Astr = str.split(",");
		
		for(int a=0; a<Astr.length; a++) {
			System.out.println("Astr = " + Astr[a]);
		}
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(Astr != null && cnt > 0) {
			ajaxResponse.setResponse(0, "Success", Astr);
		}
		else if(cnt == 0) {
			ajaxResponse.setResponse(0, "Success All Empty", Astr);
		}
		else {
			ajaxResponse.setResponse(404, "Error");
		}
		//실패조건
		return ajaxResponse;
		
    }
	
	
}

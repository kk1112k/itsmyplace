/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.controller
 * 파일명     : KakaoPayController.java
 * 작성일     : 2021. 2. 23.
 * 작성자     : mslim
 * </pre>
 */
package com.icia.itsmyplace.controller;

import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.google.gson.JsonObject;
import com.icia.common.util.StringUtil;
import com.icia.itsmyplace.model.Cafe;
import com.icia.itsmyplace.model.KakaoPayApprove;
import com.icia.itsmyplace.model.KakaoPayOrder;
import com.icia.itsmyplace.model.KakaoPayReady;
import com.icia.itsmyplace.model.Order;
import com.icia.itsmyplace.model.Pay;
import com.icia.itsmyplace.model.Point;
import com.icia.itsmyplace.model.Refund;
import com.icia.itsmyplace.model.Response;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.Seat;
import com.icia.itsmyplace.model.User;
import com.icia.itsmyplace.service.AdminService;
import com.icia.itsmyplace.service.CafeService;
import com.icia.itsmyplace.service.KakaoPayService;
import com.icia.itsmyplace.service.MyPageService;
import com.icia.itsmyplace.service.RsRvService;
import com.icia.itsmyplace.service.RsrvSeqService;
import com.icia.itsmyplace.service.UserService;
import com.icia.itsmyplace.util.CookieUtil;
import com.icia.itsmyplace.util.HttpUtil;
import com.icia.itsmyplace.util.JsonUtil;

/**
 * <pre>
 * 패키지명   : com.icia.web.controller
 * 파일명     : KakaoPayController.java
 * 작성일     : 2021. 2. 23.
 * 작성자     : mslim
 * 설명       :
 * </pre>
 */
@Controller("kakaoPayController")
public class KakaoPayController
{
	private static Logger logger = LoggerFactory.getLogger(KakaoPayController.class);
	
	@Autowired
	private KakaoPayService kakaoPayService;
	
	// 쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CafeService cafeService;
	
	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private RsrvSeqService rsrvSeqService;
	
	@Autowired
	private RsRvService rsRvService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	private static final String KAKAO_PAY_ORDER_NAME = "kakaPayOrderSession";
	
	@RequestMapping(value="/kakao/pay")
	public String pay(HttpServletRequest request, HttpServletResponse response)
	{
		return "/kakao/pay";
	}
	
	@RequestMapping(value="/kakao/payPopUp")  //, method=RequestMethod.POST)
	public String payPopUp(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String pcUrl = HttpUtil.get(request, "pcUrl", "");
		String orderId = HttpUtil.get(request, "orderId", "");
		String tId = HttpUtil.get(request, "tId", "");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		model.addAttribute("pcUrl", pcUrl);
		model.addAttribute("orderId", orderId);
		model.addAttribute("tId", tId);
		model.addAttribute("userId", userId);
		
		return "/kakao/payPopUp";
	}
	
	@RequestMapping(value="/kakao/payReady", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> payReady(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		/*
		HttpSession session = request.getSession();
		
		if(session.getAttribute(KAKAO_PAY_ORDER_NAME) != null)
		{
			session.removeAttribute(KAKAO_PAY_ORDER_NAME);
		}
		*/
		
		String orderId = StringUtil.uniqueValue();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	
		String rsrvCafe = HttpUtil.get(request, "rsrvCafe");	//예약카페
		String rsrvSeat = HttpUtil.get(request, "rsrvSeat");	//예약자리
		String rsrvDate = HttpUtil.get(request, "rsrvDate");	//예약일(카페에도착할날짜)
		String rsrvTime = HttpUtil.get(request, "rsrvTime");	//예약시간(카페에도착할시간)
		String menuNum = HttpUtil.get(request, "menuNum"); 		//메뉴번호
		String menuName = HttpUtil.get(request, "orderMenu");  //메뉴이름을 담은 리스트(카카오페이에담을거)
		String menuCount = HttpUtil.get(request, "menuCount");
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("menuName = " + menuName);
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		int originPrice = Integer.parseInt(HttpUtil.get(request, "originPrice"));
		int payPoint = Integer.parseInt(HttpUtil.get(request, "payPoint"));//사용한포인트
		int resultPrice = Integer.parseInt(HttpUtil.get(request, "resultPrice"));//최종결제금액 - 포인트할인 적용
		int totalAmount = resultPrice;
		int rsrvPplCnt = Integer.parseInt(HttpUtil.get(request, "rsrvPplCnt"));//예약인원
		int quantity = HttpUtil.get(request, "quantity", (int)0);
		int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount", (int)0);
		int vatAmount = HttpUtil.get(request, "vatAmount", (int)0);
		long rsrvSeq = Integer.parseInt(HttpUtil.get(request, "rsrvSeq"));
		
		
		String cafeNum = HttpUtil.get(request, "cafeNum"); //예약한 카페번호
		String itemCode = cafeNum;
		String itemName = rsrvCafe;
		
		String[] numberList = menuNum.split(" ");
		ArrayList<String> list = new ArrayList<String>();
		for(int j=0; j<numberList.length; j++) {
			if(!list.contains(numberList[j])) list.add(numberList[j]);
		}
		String newNumberList = String.join(" ", list);
		String[] menuNumList = newNumberList.split(" ");
		String[] menuCountList = menuCount.split(" ");
		
		User user = userService.userSelect(userId);
		user.setPayPoint(payPoint);
		
//		Seat seat = new Seat();
//		Seat result = null;
//		String[] seatSets = rsrvSeat.split(",");
		
		RsRv rsRv = new RsRv();
		rsRv.setRsrvSeq(rsrvSeq);
		rsRv.setUserId(user.getUserId());
		rsRv.setRsrvDate(rsrvDate);
		rsRv.setRsrvTime(rsrvTime);
		rsRv.setRsrvPplCnt(rsrvPplCnt);
		rsRv.setCafeNum(cafeNum);
		rsRv.setSeatList(rsrvSeat);
		
		Pay pay = new Pay();
		pay.setRsrvSeq(rsrvSeq);
		pay.setPayStep("100"); 
		pay.setPayPoint(payPoint);
		pay.setOriginPrice(originPrice);
		pay.setTotalPrice(resultPrice);
//		pay.setPayDate("결제된 날짜"); xml에서 처리할것

		List<Order> orderList = new ArrayList<Order>();
		
		for(int i=0; i<menuNumList.length; i++) {
			Order order = new Order();
			order.setRsrvSeq(rsrvSeq);
			order.setCafeNum(cafeNum);
			order.setMenuNum(menuNumList[i]);
			order.setMenuCount(Integer.parseInt(menuCountList[i]));
			orderList.add(order);
		}
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.setItemCode(String.valueOf(rsrvSeq));
		kakaoPayOrder.setItemName(itemName);
		kakaoPayOrder.setQuantity(quantity);
		kakaoPayOrder.setTotalAmount(totalAmount);
		kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
		kakaoPayOrder.setVatAmount(vatAmount);
		
		KakaoPayReady kakaoPayReady = kakaoPayService.kakaoPayReady(kakaoPayOrder);
		
		try {
			if(StringUtil.isEmpty(cafeService.paySelect(rsrvSeq))) {
//				for(int i = 0; i < seatSets.length; i++) {
//					seat.setCafeNum(cafeNum);
//					seat.setSeatNum(seatSets[i]);
//					result = cafeService.seatRevSelect(seat);
//					
//					if(result != null && result.getVacancy().equals("Y"))
//					{
//						seat.setVacancy("N");
//						if(cafeService.seatUpdate(seat) <= 0) //
//						{
//							ajaxResponse.setResponse(520, "Insert Error");
//							return ajaxResponse;
//						}
//					}
//					System.out.println("#####################");
//					System.out.println("result getvacancy = " + seat.getVacancy());
//					System.out.println("#####################");
//					
//				}
//				logger.debug("@@@@@@@@@@자리세팅완료@@@@@@@@@@");
				if(resultPrice == 0) {
					ajaxResponse.setResponse(540, "Price none");
					return ajaxResponse;
				}
				if(cafeService.userPointUpdate(user) <= 0) {
					ajaxResponse.setResponse(530, "Point Update Error");
					return ajaxResponse;
				}
				logger.debug("@@@@@@@@@@포인트차감완료@@@@@@@@@@");
				
				if(cafeService.rsRvInsert(rsRv) <= 0) { // 예약정보 삽입
					ajaxResponse.setResponse(402, "Not Found 402");
					return ajaxResponse;
				}
				logger.debug("@@@@@@@@@@예약정보완료@@@@@@@@@@");
				
				if(cafeService.payInsert(pay) <= 0) { // 결제정보 삽입
					ajaxResponse.setResponse(403, "Not Found 403");
					return ajaxResponse;
				}
				logger.debug("@@@@@@@@@@결제정보완료@@@@@@@@@@");
				
				if(cafeService.orderInsert(orderList) <= 0) { // 주문정보 삽입
					ajaxResponse.setResponse(404, "Not Found 404");
					return ajaxResponse;
				}
				logger.debug("@@@@@@@@@@주문정보완료@@@@@@@@@@");
			}
		} catch(Exception e) {
			logger.error("[CafeController] /kakao/kakaoPayReady Exception", e);
			ajaxResponse.setResponse(500, "Internal Server Error");
		}
		
		if(kakaoPayReady != null)
		{
			logger.debug("[KakaoPayController] payReady : " + kakaoPayReady);
						
			kakaoPayOrder.settId(kakaoPayReady.getTid());
			
			// session.setAttribute(KAKAO_PAY_ORDER_NAME, kakaoPayOrder);
			
			JsonObject json = new JsonObject();
			
			json.addProperty("orderId", orderId);
			json.addProperty("tId", kakaoPayReady.getTid());
			json.addProperty("appUrl", kakaoPayReady.getNext_redirect_app_url());
			json.addProperty("mobileUrl", kakaoPayReady.getNext_redirect_mobile_url());
			json.addProperty("pcUrl", kakaoPayReady.getNext_redirect_pc_url());
			//json.addProperty("rsrvSeq", rsrvSeq);
			
			logger.debug("======================================");
			logger.debug("kakaoPayReady.getNext_redirect_pc_url() : " + 
				          kakaoPayReady.getNext_redirect_pc_url());
			logger.debug("======================================");
			
		
			
			ajaxResponse.setResponse(0, "success", json);

		}
		else
		{
			ajaxResponse.setResponse(-1, "fail", null);
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/kakao/insertTest", method=RequestMethod.POST)
	public String insertTest(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		long ArsrvSeq = Integer.parseInt(HttpUtil.get(request, "ArsrvSeq"));
		model.addAttribute("rsrvSeq", ArsrvSeq);
		return "/kakao/insertTest";
	}
	
	
	@RequestMapping(value="/kakao/pointPayAll", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> pointPayAll(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	
		String rsrvCafe = HttpUtil.get(request, "rsrvCafe");	//예약카페
		String rsrvSeat = HttpUtil.get(request, "rsrvSeat");	//예약자리
		String rsrvDate = HttpUtil.get(request, "rsrvDate");	//예약일(카페에도착할날짜)
		String rsrvTime = HttpUtil.get(request, "rsrvTime");	//예약시간(카페에도착할시간)
		String menuNum = HttpUtil.get(request, "menuNum"); 		//메뉴번호
		String menuCount = HttpUtil.get(request, "menuCount");
		String cafeNum = HttpUtil.get(request, "cafeNum"); //예약한 카페번호
		
		int originPrice = Integer.parseInt(HttpUtil.get(request, "originPrice"));
		int payPoint = Integer.parseInt(HttpUtil.get(request, "payPoint"));//사용한포인트
		int resultPrice = Integer.parseInt(HttpUtil.get(request, "resultPrice"));//최종결제금액 - 포인트할인 적용
		int rsrvPplCnt = Integer.parseInt(HttpUtil.get(request, "rsrvPplCnt"));//예약인원

		long rsrvSeq = Integer.parseInt(HttpUtil.get(request, "rsrvSeq"));
		
		
		String[] numberList = menuNum.split(" ");
		ArrayList<String> list = new ArrayList<String>();
		for(int j=0; j<numberList.length; j++) {
			if(!list.contains(numberList[j])) list.add(numberList[j]);
		}
		String newNumberList = String.join(" ", list);
		String[] menuNumList = newNumberList.split(" ");
		String[] menuCountList = menuCount.split(" ");
		
		User user = userService.userSelect(userId);
		user.setPayPoint(payPoint);
		
		
//		Seat seat = new Seat();
//		Seat result = null;
//		String[] seatSets = rsrvSeat.split(",");
		
		RsRv rsRv = new RsRv();
		rsRv.setRsrvSeq(rsrvSeq);
		rsRv.setUserId(user.getUserId());
		rsRv.setRsrvDate(rsrvDate);
		rsRv.setRsrvTime(rsrvTime);
		rsRv.setRsrvPplCnt(rsrvPplCnt);
		rsRv.setCafeNum(cafeNum);
		rsRv.setSeatList(rsrvSeat);
		
		Pay pay = new Pay();
		pay.setRsrvSeq(rsrvSeq);
		pay.setPayStep("200"); 
		pay.setPayPoint(payPoint);
		pay.setOriginPrice(originPrice);
		pay.setTotalPrice(resultPrice);
//		pay.setPayDate("결제된 날짜"); xml에서 처리할것

		List<Order> orderList = new ArrayList<Order>();
		
		for(int i=0; i<menuNumList.length; i++) {
			Order order = new Order();
			order.setRsrvSeq(rsrvSeq);
			order.setCafeNum(cafeNum);
			order.setMenuNum(menuNumList[i]);
			order.setMenuCount(Integer.parseInt(menuCountList[i]));
			orderList.add(order);
		}
		
		Cafe cafe = cafeService.cafeSelect(rsRv.getCafeNum());
		User cafeUser = userService.userSelect(cafe.getUserId());
		String cafeUserMail = cafeUser.getUserEmail();
		String userMail = user.getUserEmail();
		
		String userRsrvTime = "";
		userRsrvTime = rsRv.getRsrvTime().substring(0, 2) + ":" + rsRv.getRsrvTime().substring(2, rsRv.getRsrvTime().length());
		
		
		try {
			if(StringUtil.isEmpty(cafeService.paySelect(rsrvSeq))) {
//				for(int i = 0; i < seatSets.length; i++) {
//					seat.setCafeNum(cafeNum);
//					seat.setSeatNum(seatSets[i]);
//					result = cafeService.seatRevSelect(seat);
//					if(result != null && result.getVacancy().equals("Y"))
//					{
//						seat.setVacancy("N");
//						if(cafeService.seatUpdate(seat) <= 0) //
//						{
//							ajaxResponse.setResponse(520, "Insert Error");
//							return ajaxResponse;
//						}
//					}	
//				}
				if(cafeService.userPointUpdate(user) <= 0) {
					ajaxResponse.setResponse(530, "Point Update Error");
					return ajaxResponse;
				}
				if(cafeService.rsRvInsert(rsRv) <= 0) { // 예약정보 삽입
					ajaxResponse.setResponse(402, "Not Found 402");
					return ajaxResponse;
				}
				if(cafeService.payInsert(pay) <= 0) { // 결제정보 삽입
					ajaxResponse.setResponse(403, "Not Found 403");
					return ajaxResponse;
				}	
				if(cafeService.orderInsert(orderList) <= 0) { // 주문정보 삽입
					ajaxResponse.setResponse(404, "Not Found 404");
					return ajaxResponse;
				}
			}
			else {
				if(cafeService.payUpdateAll(pay) <= 0) { // 결제정보 삽입
					ajaxResponse.setResponse(403, "Not Found 403");
					return ajaxResponse;
				}	
			}
			List<Order> order = myPageService.myOrderList(rsrvSeq);
			String menuInfo = "";
			for(int i=0; i<order.size(); i++) {
				menuInfo = menuInfo + order.get(i).getMenuName() + " " + order.get(i).getMenuCount() + "잔  ";
			}
			
			//카페운영자에게 메일전송(예약들어왔다고)
			if(!StringUtil.isEmpty(cafeUserMail)) { // 카페운영자에게 예약정보 메일로 전송하기
				String subject = "[내자리얌] "+ cafe.getCafeName() + " 사장님, 예약 정보를 확인하세요.";
				String content = "예약번호 : " + rsrvSeq + "\n"
								+ "예약자 아이디 : " + rsRv.getUserId() + "\n"
								+ "예약일 : " + rsRv.getRsrvDate() + "\n"
								+ "예약시간 : " + userRsrvTime + "\n"
								+ "예약인원수 : " + rsRv.getRsrvPplCnt() + "\n"
								+ "예약좌석 : " + rsRv.getSeatList() + "\n"
								+ "주문목록 : " + menuInfo + "\n"
								+ "주문금액 : "  + rsRv.getOriginPrice() +"원\n\n"
								+ "시간에 맞추어 준비해 주세요. 감사합니다.\n\n From.내자리얌";
				String from = "itsmyplace1@naver.com";
				
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
				
				mailHelper.setSubject(subject);
				mailHelper.setText(content);
				mailHelper.setFrom(from);
				mailHelper.setTo(cafeUserMail);
				
				mailSender.send(mail);
				ajaxResponse.setResponse(0, "success");
			}
			else {
				ajaxResponse.setResponse(500, "Email is Null (cafe)");
			}
			//사용자에게 메일전송(예약완료되었다고) - 전액포인트결제하면 알림메세지 올게 없어서 메일로 선택
			if(!StringUtil.isEmpty(userMail)) { // 카페운영자에게 예약정보 메일로 전송하기
				String subject = "[내자리얌] " + user.getUserName() +"님, 예약 정보를 확인하세요.";
				String content = "예약번호 : " + rsrvSeq + "\n"
								+ "예약자 아이디 : " + rsRv.getUserId() + "\n"
								+ "예약일 : " + rsRv.getRsrvDate() + "\n"
								+ "예약시간 : " + userRsrvTime + "\n"
								+ "예약인원수 : " + rsRv.getRsrvPplCnt() + "\n"
								+ "예약좌석 : " + rsRv.getSeatList() + "\n"
								+ "주문목록 : " + menuInfo + "\n"
								+ "주문금액 : "  + rsRv.getOriginPrice() +"원\n\n"
								+ "시간에 맞추어 입장해주세요. 감사합니다.\n\n From.내자리얌";
				String from = "itsmyplace1@naver.com";
				
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
				
				mailHelper.setSubject(subject);
				mailHelper.setText(content);
				mailHelper.setFrom(from);
				mailHelper.setTo(userMail);
				
				mailSender.send(mail);
				ajaxResponse.setResponse(0, "success");
			}
			else {
				ajaxResponse.setResponse(500, "Email is Null (user)");
			}
			
		} catch(Exception e) {
			logger.error("[CafeController] /kakao/kakaoPayReady Exception", e);
			ajaxResponse.setResponse(500, "Internal Server Error");
		}
		
		if(resultPrice == 0 && originPrice == payPoint) {
			ajaxResponse.setResponse(0, "PointPayAll Success");
		}
		else {
			ajaxResponse.setResponse(300, "payPoint Error");
		}
		System.out.println("#########################");
		System.out.println("payStep = " + pay.getPayStep());
		System.out.println("#########################");
		return ajaxResponse;
	}
	
	@RequestMapping(value="/kakao/refundProc", method=RequestMethod.POST)
	@ResponseBody
    public Response<Object> refundProc(HttpServletRequest request, HttpServletResponse response)
    {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);//쿠키정보가져옴
		long rsrvSeq = Integer.parseInt(HttpUtil.get(request, "rsrvSeq"));	
		String rfdReason = HttpUtil.get(request, "rfdReason");
		RsRv rsRv = rsRvService.rsRvSelect(rsrvSeq);
		Seat seat = new Seat();
		Seat result = null;
		Refund refund = new Refund();
		System.out.println("###########################");
		System.out.println("rsRv.getSeatList = " + rsRv.getSeatList());
		System.out.println("###########################");
		String[] seatSets = rsRv.getSeatList().split(",");
		
		Pay pay = cafeService.paySelect(rsrvSeq);
		Response<Object> ajaxResponse = new Response<Object>();
		
		User user = userService.userSelect(cookieUserId);
		Point point = new Point();
		point.setRsrvSeq(rsrvSeq);
		point.setUserId(user.getUserId());
		point.setSavePath("환불에 따른 적립");
		point.setSavePoint(pay.getPayPoint()+pay.getTotalPrice());
		
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		System.out.println("setSavePoint = " + point.getSavePoint());
		System.out.println(seatSets[0]);
		System.out.println(seatSets[1]);
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		
		refund.setRsrvSeq(rsrvSeq);
		refund.setRfdReason(rfdReason);
		refund.setRfdMethod("전액포인트환불");
		
		pay.setPayStep("500");
		
		try {
			user.setTotalPoint(point.getSavePoint());

			for(int i = 0; i < seatSets.length; i++) {
				seat.setCafeNum(rsRv.getCafeNum());
				System.out.println("######################");
				System.out.println("seat.setCafeNum = " + seat.getCafeNum());
				seat.setSeatNum(seatSets[i]);
				System.out.println("seat.setSeatNum = " + seat.getSeatNum());
				System.out.println("aaaaa = " + seat.getVacancy() + "bbbb");
				System.out.println("######################");
				result = cafeService.seatRevSelect(seat);
				System.out.println("######################");
				System.out.println("result getvacancy = " + result.getVacancy());
				System.out.println("######################");
				if(result != null && result.getVacancy().equals("N")) 
				{
					seat.setVacancy("Y");
					System.out.println("#######################");
					System.out.println("seat = " + seat.getSeatNum());
					System.out.println("#######################");
					if(cafeService.seatUpdate(seat) <= 0) //
					{
						ajaxResponse.setResponse(520, "Insert Error");
						return ajaxResponse;
					}
				}	
			}
			
			if(userService.userUpdate(user) <= 0) {
				ajaxResponse.setResponse(300, "xxxxxxxxxx");
				return ajaxResponse;
			}
			
			if(cafeService.pointInsert(point) <= 0) {
				ajaxResponse.setResponse(100, "xxxaaa");
				return ajaxResponse;
			}
			if(cafeService.refundInsert(refund) <= 0) {
				ajaxResponse.setResponse(400, "refund error");
			}
			
			if(cafeService.payStatusUpdate(pay) > 0) {
				ajaxResponse.setResponse(0, "success");
			}
			else {
				ajaxResponse.setResponse(200, "xxx");
			}
			
		}
		catch(Exception e) {
			logger.error("[KakaoController] /kakao/refundProc Exception", e);
			ajaxResponse.setResponse(500, "Internal Server Error");
		}
		
	
		logger.debug("[KakaoPayController] /kakao/refundProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		System.out.println("###################");
		System.out.println("환불 및 좌석처리완료");
		System.out.println("###################");
		
		
		
        return ajaxResponse;
    }
	
	@RequestMapping(value="/kakao/paySuccess")
	public String paySuccess(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		//KakaoPayApprove kakaoPayApprove = null;
		
		String pgToken = HttpUtil.get(request, "pg_token", "");
		
		/*
		HttpSession session = request.getSession(true);
		KakaoPayOrder kakaoPayOrder = (KakaoPayOrder)session.getAttribute(KAKAO_PAY_ORDER_NAME); 
		
		if(kakaoPayOrder != null)
		{
			// session.removeAttribute(KAKAO_PAY_ORDER_NAME);
			
			kakaoPayOrder.setPgToken(pgToken);
			
			kakaoPayApprove = kakaoPayService.kakaoPayApprove(kakaoPayOrder);
			
			if(kakaoPayApprove != null)
			{
				logger.debug("[KakaoPayController] paySuccess : " + kakaoPayApprove);
			}
		}
		
		model.addAttribute("kakaoPayApprove", kakaoPayApprove);
		*/
		
		model.addAttribute("pgToken", pgToken);
		
		return "/kakao/paySuccess";
	}
	
	@RequestMapping(value="/kakao/payResult")
	public String payResult(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		logger.debug("userPurchaseConfirmation");
		
		KakaoPayApprove kakaoPayApprove = null;
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String orderId = HttpUtil.get(request, "orderId", "");
		String tId = HttpUtil.get(request, "tId", "");
		String pgToken = HttpUtil.get(request, "pgToken", "");
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.settId(tId);
		kakaoPayOrder.setPgToken(pgToken);
		
		kakaoPayApprove = kakaoPayService.kakaoPayApprove(kakaoPayOrder);
				
		model.addAttribute("kakaoPayApprove", kakaoPayApprove);
		
		return "/kakao/payResult";
	}
		
	@RequestMapping(value="/kakao/payFail")
	public String payFail(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession(true);
		KakaoPayOrder kakaoPayOrder = (KakaoPayOrder)session.getAttribute(KAKAO_PAY_ORDER_NAME);
		
		if(kakaoPayOrder != null)
		{
			session.removeAttribute(KAKAO_PAY_ORDER_NAME);
		}
		
		return "/kakao/payFail";
	}
	
	@RequestMapping(value="/kakao/payCancel")
	public String payCancel(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession(true);
		KakaoPayOrder kakaoPayOrder = (KakaoPayOrder)session.getAttribute(KAKAO_PAY_ORDER_NAME);
		
		if(kakaoPayOrder != null)
		{
			session.removeAttribute(KAKAO_PAY_ORDER_NAME);
		}
		
		return "/kakao/payCancel";
	}
	
	
	@RequestMapping(value="/kakao/payProc")
	@ResponseBody
	public Response<Object> payProc(HttpServletRequest request, HttpServletResponse response) throws Exception
	{  
		long rsrvSeq = Integer.parseInt(HttpUtil.get(request, "rsrvSeq"));
		Pay pay = cafeService.paySelect(rsrvSeq);
		RsRv rsRv = rsRvService.rsRvSelect(rsrvSeq);
		Cafe cafe = cafeService.cafeSelect(rsRv.getCafeNum());
		User cafeUser = userService.userSelect(cafe.getUserId());
		String cafeUserMail = cafeUser.getUserEmail();
		long rewardPoint = (long)(pay.getTotalPrice()*0.03);
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userSelect(userId);
		user.setTotalPoint(rewardPoint);
		
		
		Point point = new Point();
		
		point.setUserId(userId);
		point.setSavePoint((int)rewardPoint);
		point.setSavePath("예약확정포인트적립");
		point.setRsrvSeq(rsrvSeq);
		
		String rsrvTime = "";
		rsrvTime = rsRv.getRsrvTime().substring(0, 2) + ":" + rsRv.getRsrvTime().substring(2, rsRv.getRsrvTime().length());
		
		Pay payStep = new Pay();
		
		payStep.setRsrvSeq(rsrvSeq);
		payStep.setPayStep("200");

		Response<Object> ajaxResponse = new Response<Object>();
		
		try {

			if(cafeService.payStatusUpdate(payStep) <= 0) { 
				ajaxResponse.setResponse(403, "Not Found 403");
				return ajaxResponse;
			}
			if(adminService.userPointRewardUpdate(user) <= 0) {
				ajaxResponse.setResponse(404, "3% point Reward Error");
			}
			if(cafeService.pointInsert(point) <= 0) {
				ajaxResponse.setResponse(405, "point Insert Error");
			}
			
			List<Order> order = myPageService.myOrderList(rsrvSeq);
			String menuInfo = "";
			for(int i=0; i<order.size(); i++) {
				menuInfo = menuInfo + order.get(i).getMenuName() + " " + order.get(i).getMenuCount() + "잔  ";
			}
			
			if(!StringUtil.isEmpty(cafeUserMail)) { // 카페운영자에게 예약정보 메일로 전송하기
				String subject = "[내자리얌] "+ cafe.getCafeName() + " 사장님, 예약 정보를 확인하세요.";
				String content = "예약번호 : " + rsrvSeq + "\n"
								+ "예약자 아이디 : " + rsRv.getUserId() + "\n"
								+ "예약일 : " + rsRv.getRsrvDate() + "\n"
								+ "예약시간 : " + rsrvTime + "\n"
								+ "예약인원수 : " + rsRv.getRsrvPplCnt() + "\n"
								+ "예약좌석 : " + rsRv.getSeatList() + "\n"
								+ "주문목록 : " + menuInfo + "\n"
								+ "주문금액 : "  + rsRv.getOriginPrice() +"원\n\n"
								+ "시간에 맞추어 준비해 주세요. 감사합니다.\n\n From.내자리얌";
				String from = "itsmyplace1@naver.com";
				
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
				
				mailHelper.setSubject(subject);
				mailHelper.setText(content);
				mailHelper.setFrom(from);
				mailHelper.setTo(cafeUserMail);
				
				mailSender.send(mail);
				ajaxResponse.setResponse(0, "success");
			}
			else {
				ajaxResponse.setResponse(500, "Email is Null");
			}
			
		}
		catch(Exception e) {
			logger.error("[KaKaoPayController] /kakao/payProc Exception", e);
			ajaxResponse.setResponse(501, "Internal Server Error");
		}
		
		
		
		
		return ajaxResponse;
	}
	
	
}

package com.icia.itsmyplace.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.icia.itsmyplace.dao.CafeDao;
import com.icia.itsmyplace.dao.MenuDao;
import com.icia.itsmyplace.dao.OrderDao;
import com.icia.itsmyplace.dao.PayDao;
import com.icia.itsmyplace.dao.PointDao;
import com.icia.itsmyplace.dao.RsRvDao;
import com.icia.itsmyplace.dao.SeatDao;
import com.icia.itsmyplace.dao.UserDao;
import com.icia.itsmyplace.model.Cafe;
import com.icia.itsmyplace.model.CafePht;
import com.icia.itsmyplace.model.MenuPht;
import com.icia.itsmyplace.model.Order;
import com.icia.itsmyplace.model.Pay;
import com.icia.itsmyplace.model.Point;
import com.icia.itsmyplace.model.Refund;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.Seat;
import com.icia.itsmyplace.model.User;



@Service("cafeService")
public class CafeService {

	private static Logger logger = LoggerFactory.getLogger(CafeService.class);

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private CafeDao cafeDao;
	
	@Autowired
	private RsRvDao rsRvDao;
	
	@Autowired
	private PayDao payDao;
	
	@Autowired
	private OrderDao orderDao; 
	
	@Autowired
	private SeatDao seatDao;
	
	@Autowired
	private PointDao pointDao;
	
	@Autowired
	private MenuDao menuDao;
	
	//카페 조회
	public Cafe cafeSelect(String cafeNum)
	{
		Cafe cafe = null;
		 
		try
		{
			 cafe = cafeDao.cafeSelect(cafeNum);
		}
		catch(Exception e)
		{
			logger.error("[CafeService] cafeSelect Exception", e);
		}
		return cafe;
	}
	
	// 카페 자리예약/공석 조회
	public List<Seat> seatSelect(String cafeNum)
	{
		List<Seat> seat = null;
		
		try
		{
			seat = cafeDao.seatSelect(cafeNum);
		}
		catch(Exception e)
		{
			logger.error("[CafeService] seatSelect Exception", e);
		}
		return seat;
	}
	
	// 메뉴사진 조회
	public List<MenuPht> menuPhtSelect(String cafeNum)
	{
		List<MenuPht> menupht = null;
		
		try
		{
			menupht = cafeDao.menuPhtSelect(cafeNum);
		}
		catch(Exception e)
		{
			logger.error("[CafeService] menuSelect Exception", e);
		}
		return menupht;
	}
	
	// 카페 자리 Y인지, 공석인지체크
	public Seat seatRevSelect(Seat seat)
	{
		Seat seatResult = new Seat();
		
		try
		{
			seatResult = seatDao.seatRevSelect(seat);
		}
		catch(Exception e)
		{
			logger.error("[CafeService] seatRevSelect Exception", e);
		}
		return seatResult;
	}
		
	// 카페 자리선택 N->Y 자리변경
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int seatUpdate(Seat seat) throws Exception
	{
		int count = 0;
		
		count = seatDao.seatUpdate(seat);
		
		return count;
	}

	
	// RsRv
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int rsRvInsert(RsRv rsRv) throws Exception
	{
		int count = 0;
		count = rsRvDao.rsRvInsert(rsRv);
		return count;
	}

	// Pay
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int payInsert(Pay pay) throws Exception
	{
		int count = 0;
		count = payDao.payInsert(pay);
		return count;
	}
	
	// Order
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int orderInsert(List<Order> orderList) throws Exception
	{
		int count = 0;
		for(int i=0; i<orderList.size(); i++) {
			Order order = orderList.get(i);
			count = orderDao.orderInsert(order);
		}
		return count;
	}
	
	//userPoint Update
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int userPointUpdate(User user) throws Exception
	{
		int count = 0;
		count = userDao.userPointUpdate(user);
		return count;
	}
	
	//Refund Insert
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int refundInsert(Refund refund) throws Exception{
		int count = 0;
		count = payDao.refundInsert(refund);
		return count;
	}
	
	
	//paySelect 결제금액 가져와서 환불하려는 용도
	public Pay paySelect(long rsrvSeq) {
		 Pay pay = null;
		try
		{
			pay = payDao.paySelect(rsrvSeq);
		}
		catch(Exception e)
		{
			logger.error("[CafeService] paySelect Exception", e);
		}
		
		return pay;
		
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int payStatusUpdate(Pay pay) throws Exception {
		int count = 0;
		try {
			count = payDao.payStatusUpdate(pay);
		} catch(Exception e) {
			logger.error("[CafeService] payStatusUpdate Exception", e);
		}
		return count;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int payUpdateAll(Pay pay) throws Exception {
		int count = 0;
		try {
			count = payDao.payUpdateAll(pay);
		} catch(Exception e) {
			logger.error("[CafeService] payUpdateAll Exception", e);
		}
		return count;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int pointInsert(Point point) throws Exception{
		int count = 0;
		try {
			count = pointDao.pointInsert(point);
		} catch(Exception e) {
			logger.error("[CafeService] savePointInsert Exception", e);
		}
		return count;
	}
	
	public Point pointSelect(long rsrvSeq){
		 Point point = null;
			try
			{
				point = pointDao.pointSelect(rsrvSeq);
			}
			catch(Exception e)
			{
				logger.error("[CafeService] pointSelect Exception", e);
			}
			
		return point;
	}
	
	//전체 카페 조회
	public List<Cafe> cafeList() {
		
		List<Cafe> cafeList = null;
		
		try {
			cafeList = cafeDao.cafeList();
		}
		catch(Exception e){
			logger.error("[CafeService] cafeList Exception", e);
		}
		
		return cafeList;
	}
	
	//카페사진조회
	public List<CafePht> cafePhtList(CafePht cafePht){
		
		List<CafePht> cafePhtList = null;
		
		try {
			cafePhtList = cafeDao.cafePhtList(cafePht);
		}
		catch(Exception e) {
			logger.error("[CafeService] cafePhtList Exception", e);
		}
		
		return cafePhtList;
	}
	
	//카페별 공석 수 조회
	public int seatVacancyCnt(RsRv rsrv) {
		int count = 0;
		
		try {
			count = cafeDao.seatVacancyCnt(rsrv);
		}
		catch(Exception e){
			logger.error("[CafeService] seatVacancyCnt Exception", e);
		}
		
		return count;
	}
		
	//카페 시간별 좌석 공석여부 파악하기
	public List<RsRv> rsRvSelectList(String cafeNum){
		List<RsRv> cafeSeatList = null;
		
		try {
			cafeSeatList = cafeDao.rsRvSelectList(cafeNum);
		}
		catch(Exception e){
			logger.error("[CafeService] rsRvSelectList Exception", e);
		}
		
		return cafeSeatList;
	}
	
	//카페소개 페이지 베스트 메뉴번호 조회용
	public List<String> BestSellerList(String cafeNum)
	{
		List<String> menuNumList = null;
		
		try
		{
			menuNumList = orderDao.BestSellerList(cafeNum);
		}
		catch(Exception e)
		{
			logger.error("[CafeService] BestSelerSelect Exception", e);
		}
		
		return menuNumList;
	}
	
	//카페소개 페이지 베스트 메뉴사진 조회용
	public MenuPht bestMenuPhtSelect(MenuPht menuPht)
	{
		MenuPht menuPhtResult = null;
				
		try
		{
			menuPhtResult = menuDao.bestMenuPhtSelect(menuPht);
		}
		catch(Exception e)
		{
			logger.error("[CafeService] menuPhtSelect Exception", e);
		}
		
		return menuPhtResult;
	}
}

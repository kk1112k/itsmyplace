package com.icia.itsmyplace.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Cafe;
import com.icia.itsmyplace.model.CafePht;
import com.icia.itsmyplace.model.MenuPht;
import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.Seat;

/* 1. 카페
 * 2. 좌석
 * 3. 메뉴
 * 통합해서 cafeDao로 
 * 설정했습니다.
 * */


@Repository("cafeDao")
public interface CafeDao {

	//카페 조회
	public Cafe cafeSelect(String cafeNum);
	
	//자리예약/공석 조회 
	public List<Seat> seatSelect(String cafeNum);
	
	//메뉴사진 조회
	public List<MenuPht> menuPhtSelect(String cafeNum);
	
	//카페사진 조회
	public List<CafePht> cafePhtList(CafePht cafePht);
		
	//전체 카페조회
	public List<Cafe> cafeList();
	
	//카페별 공석 수 조회
	public int seatVacancyCnt(RsRv rsrv);
	
	public List<RsRv> rsRvSelectList(String cafeNum);
}

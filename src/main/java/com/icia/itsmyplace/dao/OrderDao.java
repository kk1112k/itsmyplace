package com.icia.itsmyplace.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Order;

@Repository("orderDao")
public interface OrderDao {
	public int orderInsert(Order order);
	public List<Order> myOrderList(long rsrvSeq);
	
	//카페소개 페이지 베스트메뉴 조회용
	public List<String> BestSellerList(String cafeNum);
}

package com.icia.itsmyplace.dao;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Seat;

@Repository("seatDao")
public interface SeatDao {
	public Seat seatRevSelect(Seat seat);
	public int seatUpdate(Seat seat);
}

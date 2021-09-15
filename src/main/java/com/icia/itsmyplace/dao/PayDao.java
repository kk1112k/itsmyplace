package com.icia.itsmyplace.dao;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Pay;
import com.icia.itsmyplace.model.Refund;

@Repository("payDao")
public interface PayDao {
	public int payInsert(Pay pay);
	public Pay paySelect(long rsrvSeq);
	public int payStatusUpdate(Pay pay);
	public int payUpdateAll(Pay pay);
	public int refundInsert(Refund refund);

}

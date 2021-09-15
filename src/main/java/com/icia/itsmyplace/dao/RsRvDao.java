package com.icia.itsmyplace.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.RsRv;
import com.icia.itsmyplace.model.User;

@Repository("rsRvDao")
public interface RsRvDao {
	public int rsRvInsert(RsRv rsRv);
	
	public List<RsRv> myOrderInfo(RsRv rsRv);
	
	public long myOrderCount(User user);
	
	public RsRv rsRvSelect(long rsrvSeq);
}

package com.icia.itsmyplace.dao;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.Point;

@Repository("pointDao")
public interface PointDao {
	public int pointInsert(Point point);
	public Point pointSelect(long rsrvSeq);
}

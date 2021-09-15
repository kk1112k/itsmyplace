package com.icia.itsmyplace.dao;

import org.springframework.stereotype.Repository;

import com.icia.itsmyplace.model.User;

@Repository("userDao")
public interface UserDao
{
	public int userInsert(User user);
	
	public int userUpdate(User user);
	
//	public int userStatusUpdate(User user);
	
	public User userSelect(String userId);
	
	public User userAreaSelect(String userId);
	
	public int userWithdrawal(User user);
	
	public int userPointUpdate(User user);
}
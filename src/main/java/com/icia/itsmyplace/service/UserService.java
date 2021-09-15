package com.icia.itsmyplace.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.itsmyplace.dao.UserDao;
import com.icia.itsmyplace.model.User;

@Service("userService")
public class UserService
{
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDao userDao;
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int userInsert(User user) throws Exception
	{
		int count = 0;
		count = userDao.userInsert(user);
		return count;
	}
	
	public int userUpdate(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userUpdate(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userUpdate Exception", e);
		}
		
		return count;
	}
	
	public User userSelect(String userId)
	{
		User user = null;
	
		try
		{
			user = userDao.userSelect(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userSelect Exception", e);
		}
		
		return user;
	}
	
	public User userAreaSelect(String userId) {
		User user = null;
		
		try {
			user = userDao.userAreaSelect(userId);
		}
		catch(Exception e) {
			logger.error("[UserService] userAreaSelect Exception", e);
		}
		
		return user;
	}
	
	//회원탈퇴
	public int userWithdrawal(User user) {
		int count = 0;
		
		try
		{
			count = userDao.userWithdrawal(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userStatusUpdate Exception", e);
		}
		
		return count;
	}
	
}
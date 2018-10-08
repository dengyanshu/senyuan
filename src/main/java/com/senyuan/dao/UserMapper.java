package com.senyuan.dao;

import java.util.Map;

import com.senyuan.entity.User;


public interface UserMapper extends  BaseMapper<User> {
	
	
	public  User login(User user);
	
	
	public int  updatePwd(Map<String,Object>  map);
   
}
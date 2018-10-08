package com.senyuan.service;

import java.io.Serializable;

import com.senyuan.entity.User;


public interface IUserService extends  IBaseService<User>{
	
	
	public  User login(User user);
	
	
	public  int   updatePwd(Serializable  id,String pwd);

}

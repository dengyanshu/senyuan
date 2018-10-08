package com.senyuan.dao;

import com.senyuan.entity.StoreProcess;

public interface StoreProcessMapper extends  BaseMapper<StoreProcess>{
   
	
	
	public StoreProcess selectExist(StoreProcess sp);
}
package com.senyuan.service;

import java.io.Serializable;
import java.util.List;

import com.senyuan.entity.Page;


public interface IBaseService<T> {
     public int  insert(T  t);
	 
	 public int delete(T t);
	 public int deleteList(Serializable[] ids);
	 
	 public  int update(T t);
	 
	 public  T selectOne(Serializable id);
	 public  List<T>  selectAll();
	 
	  public Page<T> selectPage(Page<T>  page);
}

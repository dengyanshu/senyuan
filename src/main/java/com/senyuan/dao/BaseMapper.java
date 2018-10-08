package com.senyuan.dao;

import java.io.Serializable;
import java.util.List;

import com.senyuan.entity.Page;


public interface BaseMapper<T> {
     
	 public int  insert(T  t);
	 
	 public int delete(T t);
	 public int deleteList(Serializable[] ids);
	 
	 public  int update(T t);
	 
	 public  T selectOne(Serializable id);
	 public  List<T>  selectAll();
	 
	 public   long  selectPageCount(Page<T> page);
	 public   List<T> selectPage(Page<T> page);
}

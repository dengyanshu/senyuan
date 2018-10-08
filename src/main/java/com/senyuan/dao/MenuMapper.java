package com.senyuan.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.senyuan.entity.Menu;


@Mapper
public interface MenuMapper extends  BaseMapper<Menu>{
	public List<Menu> selectAllChildren(Serializable  p_id);
	public List<Menu> selectNeedChildren(Map<String,Object>  map);
	
	
	public  int  updateStateToClosed(int  id);
	public  int  updateStateToOpen(int  id);
	
	public  Menu  selectOneCommon(int id);
    
}
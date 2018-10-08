package com.senyuan.service.imp;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;

import com.senyuan.dao.BaseMapper;
import com.senyuan.dao.MenuMapper;
import com.senyuan.dao.NoticeMapper;
import com.senyuan.dao.RoleMapper;
import com.senyuan.dao.StoreProcessMapper;
import com.senyuan.dao.SupplierMapper;
import com.senyuan.dao.UserMapper;
import com.senyuan.entity.Page;
import com.senyuan.service.IBaseService;



public class BaseService<T>  implements IBaseService<T> {
	private  BaseMapper<T>  baseMapper;
	
	
	@Autowired
	protected  MenuMapper  menuMapper;
	
	@Autowired
	protected  NoticeMapper  noticeMapper;
	
	@Autowired
	protected  RoleMapper  roleMapper;
	
	@Autowired
	 protected UserMapper  userMapper;
	
	@Autowired
   protected  StoreProcessMapper  storeProcessMapper;
	
	@Autowired
	protected  SupplierMapper  supplierMapper;
	
	
	
	@PostConstruct
	public void  init()throws  Exception{
	   ParameterizedType pt=  (ParameterizedType) this.getClass().getGenericSuperclass();
	   Class clazz=(Class) pt.getActualTypeArguments()[0];
	   
	   String localField = clazz.getSimpleName().substring(0,1).toLowerCase()+clazz.getSimpleName().substring(1)+"Mapper";
       Field  localfield=this.getClass().getSuperclass().getDeclaredField(localField);
       Field  basefield=this.getClass().getSuperclass().getDeclaredField("baseMapper");
       basefield.set(this, localfield.get(this));
	}
	
	

	@Override
	public int insert(T t) {
		// TODO Auto-generated method stub
		return baseMapper.insert(t);
	}

	@Override
	public int delete(T t) {
		// TODO Auto-generated method stub
		return baseMapper.delete(t);
	}

	@Override
	public int deleteList(Serializable[] ids) {
		// TODO Auto-generated method stub
		return baseMapper.deleteList(ids);
	}

	@Override
	public int update(T t) {
		// TODO Auto-generated method stub
		return baseMapper.update(t);
	}

	@Override
	public T selectOne(Serializable id) {
		// TODO Auto-generated method stub
		return (T) baseMapper.selectOne(id);
	}

	@Override
	public List<T> selectAll() {
		// TODO Auto-generated method stub
		return baseMapper.selectAll();
	}

	@Override
	public Page<T> selectPage(Page<T> page) {
		// TODO Auto-generated method stub
		  long count= baseMapper.selectPageCount(page);
		  page.setCount(count);
		  List<T> rows= baseMapper.selectPage(page);
		  page.setData(rows);
		  return page;
	}

}

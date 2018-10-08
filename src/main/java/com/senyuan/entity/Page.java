package com.senyuan.entity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Page<T> {
	
	private  int page;
    private  int rows;
    
    private  long  count;
    private  List<T> data;
    
    
    private  Map<String,Object> resMap=new  HashMap<String, Object>();
    
    
    private  int start;//给mysql数据库分页用

    private  T keyWord;//用于条件查询
    
    
	public int getStart() {
		return start;
	}


	public void setStart(int start) {
		this.start = start;
	}


	public T getKeyWord() {
		return keyWord;
	}


	public void setKeyWord(T keyWord) {
		this.keyWord = keyWord;
	}


	public int getPage() {
		return page;
	}


	public void setPage(int page) {
		this.page = page;
	}


	public int getRows() {
		return rows;
	}


	public void setRows(int rows) {
		this.rows = rows;
		this.start=(page-1)*rows;
	}


	public long getCount() {
		return count;
	}


	public void setCount(long count) {
		this.count = count;
		resMap.put("total", count);
	}


	public List<T> getData() {
		return data;
	}


	public void setData(List<T> data) {
		this.data = data;
		resMap.put("rows", data);
	}


	public Map<String, Object> getResMap() {
		return resMap;
	}


	public void setResMap(Map<String, Object> resMap) {
		this.resMap = resMap;
	}


	
    
    
	

}

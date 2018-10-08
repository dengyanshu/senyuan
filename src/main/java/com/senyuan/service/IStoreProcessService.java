package com.senyuan.service;

import java.util.List;

import com.senyuan.entity.StoreProcess;


public interface IStoreProcessService extends  IBaseService<StoreProcess> {
	
	//上传excel  处理
	
	public  int  insertExcel(List<StoreProcess> sps);

}

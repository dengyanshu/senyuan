package com.senyuan.service.imp;

import java.util.List;

import org.springframework.stereotype.Service;

import com.senyuan.entity.StoreProcess;
import com.senyuan.service.IStoreProcessService;


@Service
public class StoreProcessService extends  BaseService<StoreProcess>  implements IStoreProcessService {

	@Override
	public int insertExcel(List<StoreProcess> sps) {
		// TODO Auto-generated method stub
		//单条插入 存储过程名字视为 相同  不插入
		for(StoreProcess sp:sps){
			if(storeProcessMapper.selectExist(sp)==null){
				storeProcessMapper.insert(sp);
			}
		}
		return 1;
	}

}

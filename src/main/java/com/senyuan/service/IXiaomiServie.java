package com.senyuan.service;

import java.util.List;
import java.util.Map;

public interface IXiaomiServie {
     
	public List<Map<String,Object>> getLineinfo(Map<String,Object>  map);

	public List<Map<String, Object>> getMachineinfo(Map<String, Object> paramap);
	
}

package com.senyuan.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class StringUtil {
   
	
	private StringUtil(){};
	
	/**
	 * 文件名转UUID
	 * */
	public static String filenameToUUID(String filename){
		String filename_suffix=filename.substring(filename.lastIndexOf("."));
		return UUID.randomUUID().toString().replace("-", "")+filename_suffix;
	}
	
	
	/**
	 * 简单处理结果list 转化成结果map  符合datagrid json数据格式的数据
	 * 
	 * */
	
	public  static  Map<String,Object>  listToDataJSON(List<Map<String,Object>> list,
			Map<String,Object>  paraMap){
		Map<String,Object> resmap=new HashMap<String, Object>();
		if(paraMap.get("total")!=null&&Integer.parseInt(paraMap.get("total").toString())>0){
			//前台有设置total参数值 并且后台有赋值
			resmap.put("toatl", Integer.parseInt(paraMap.get("total").toString()));
			
		}else{
			if(list!=null){
				resmap.put("total", list.size());
			}
			else{
				resmap.put("total", 0);
			}
		}
	   resmap.put("rows", list);
		return resmap;
	}
}

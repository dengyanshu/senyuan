package com.senyuan.action;

import java.io.File;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.senyuan.entity.Page;
import com.senyuan.entity.StoreProcess;
import com.senyuan.service.IStoreProcessService;
import com.senyuan.util.SpExcelUtil;




@Controller
@RequestMapping("/sp")
public class StoreProcessAction extends  BaseAction {
   
	@Resource
	private  IStoreProcessService  storeProcessService;
	
	 @RequestMapping("/list")
	public @ResponseBody Object  list(Page<StoreProcess> page,StoreProcess  sp){
		 if(sp!=null&&sp.getSpName()!=null){
			 page.setKeyWord(sp);
		 }
		 return  storeProcessService.selectPage(page).getResMap();
	}
	 
	 
	 @RequestMapping("/add")
		public @ResponseBody Object  add(StoreProcess  sp){
			 return  storeProcessService.insert(sp);
		}
	 
	    @RequestMapping("/update")
		public @ResponseBody Object  update(StoreProcess  sp){
			 return  storeProcessService.update(sp);
		}
	 
	 
	    @RequestMapping("/deleteList")
		public @ResponseBody Object  deleteList(Integer[] ids){
			 return  storeProcessService.deleteList(ids);
		}
	    @RequestMapping("/exportall")
		public @ResponseBody  Object  exportall(HttpServletResponse  response) throws Exception{
	    	//查询出所有记录
	    	OutputStream  os=response.getOutputStream();
	    	response.setContentType("application/x-execl");
	    	response.setHeader("Content-Disposition", "attachment;filename="+new  String("存储过程表.xlsx".getBytes(),"iso8859-1"));
	    	
	    	List<StoreProcess> sps =storeProcessService.selectAll();
	    	if(sps!=null&&sps.size()>0){
	    		SpExcelUtil.export(os, sps);
	    	}
	    	if(os!=null){
	    		os.close();
	    	}
	    	return 1;
			 
		}
	    
	    
	    
	    @RequestMapping("/downExample")
		public @ResponseBody  Object  downExample(HttpServletResponse  response) throws Exception{
	    	//查询出所有记录
	    	OutputStream  os=response.getOutputStream();
	    	response.setContentType("application/x-execl");
	    	response.setHeader("Content-Disposition", "attachment;filename="+new  String("存储过程模板.xlsx".getBytes(),"iso8859-1"));
	    	
	    
	        SpExcelUtil.export(os,null );
	    	
	    	if(os!=null){
	    		os.close();
	    	}
	    	return 1;
			 
		}
	    
	    
	    @RequestMapping("/upload")
	    public  @ResponseBody Object  upload(@RequestParam("spExcel") MultipartFile spExcel,
	    		HttpServletRequest request )  throws  Exception {
	    	System.out.println(spExcel.getOriginalFilename());
	    	String srcfilename_hz=spExcel.getOriginalFilename().substring(spExcel.getOriginalFilename().lastIndexOf("."));
	    	
	    	String uploadpath=application.getRealPath("upload");
	    	File  toFile=new File(uploadpath+"//"+UUID.randomUUID().toString().replace("-", "")+srcfilename_hz);
	    	
	    	spExcel.transferTo(toFile);
	    	
	    	//完成上传
	    	//处理excel  读取然后写入数据库
	    	List<StoreProcess> sps= SpExcelUtil.readExcel(toFile);
	    	//写数据库业务处理
	    	return storeProcessService.insertExcel(sps);
	    	
	    }
	    
	    
	 
}

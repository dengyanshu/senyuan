package com.senyuan.action;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.senyuan.entity.Page;
import com.senyuan.entity.Supplier;
import com.senyuan.service.ISupplierService;




@Controller
@RequestMapping("/supplier")
public class SupplierAction {
	@Resource
	private  ISupplierService  supplierService;
	
	
	@RequestMapping("/list")
	public @ResponseBody Object  selectPage(Page<Supplier>  page){
		page=supplierService.selectPage(page);
		return page.getResMap();
	}

}

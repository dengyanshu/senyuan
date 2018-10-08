package com.senyuan.action;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/base")
public class BaseAction {
	@Resource
	protected  ServletContext  application;
   
	@RequestMapping("/url/{folder}/{page}")
	public String goUrl(@PathVariable String folder,@PathVariable String page ){
		return "/WEB-INF/"+folder+"/"+page+".jsp";
	}
}

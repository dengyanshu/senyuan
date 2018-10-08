package com.senyuan.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.senyuan.entity.Menu;
import com.senyuan.service.IMenuService;



@Controller
@RequestMapping("/menu")
public class MenuAction {
	
	@Resource
	private  IMenuService  menuService;
	
	@RequestMapping("/all")
	public @ResponseBody Object  getAllMenu(){
		List<Menu>  treeJson=new ArrayList<Menu>();
		treeJson.add(menuService.selectAllMenu());
		return treeJson;
	}
    
	@RequestMapping("/need")
	public @ResponseBody Object  getNeedMenu(int roleId){
		List<Menu>  treeJson=new ArrayList<Menu>();
		treeJson.add(menuService.selectNeedMenu(roleId));
		return treeJson;
	}
	
	@RequestMapping("/update")
	public  @ResponseBody int updateMenu(Menu menu){
		return  menuService.update(menu);
	}
	
	@RequestMapping("/addMenu")
	public  @ResponseBody int addMenu(Menu menu){
		return  menuService.insert(menu);
	}
	
	
	@RequestMapping("/addMenuAndUpdateState")
	public  @ResponseBody int addMenuAndUpdateState(Menu menu){
		return  menuService.insertMenuAndUpdateState(menu);	
	}
	
	@RequestMapping("/deleteAndUpdateState")
	public  @ResponseBody Object deleteAndUpdateState(int  id,int parentId){
		return menuService.deleteAndUpdateState(id, parentId);
	}
	
}

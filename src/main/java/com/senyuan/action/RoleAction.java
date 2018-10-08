package com.senyuan.action;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.senyuan.entity.Page;
import com.senyuan.entity.Role;
import com.senyuan.service.IRoleService;




@Controller
@RequestMapping("/role")
public class RoleAction {
	 
	@Resource
	private  IRoleService  roleService;
	
	 @RequestMapping("/list")
     public @ResponseBody Object   list(Page<Role>  page){
		 return  roleService.selectPage(page).getResMap();
	 }
     
	
     
	 @RequestMapping("/menuidbyroleid")
	 public @ResponseBody Object   selectMenuIdByRoleId(int roleId){
		 return roleService.selectMenuidsByRoleId(roleId);
	 }
	 
	 
	 
	 @RequestMapping("/sq")
	 public @ResponseBody Object   sq(int roleId,int [] menuids){
		 return roleService.deleteAndInsert_rm_table(roleId, menuids);
	 }
	 
	 @RequestMapping("/selectAll")
	 public @ResponseBody Object  selectAll(){
		return roleService.selectAll();
	 }
	 
	 
	 
}

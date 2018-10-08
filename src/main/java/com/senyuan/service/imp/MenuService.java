package com.senyuan.service.imp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.senyuan.dao.RoleMapper;
import com.senyuan.entity.Menu;
import com.senyuan.service.IMenuService;




@Service
public class MenuService extends BaseService<Menu> implements IMenuService {
    @Autowired
	private  RoleMapper  roleMapper;
	
	@Override
	public Menu selectAllMenu() {
		// TODO Auto-generated method stub
		Menu menu=menuMapper.selectOne(-1);
		return all(menu);
	}

	
   private  Menu  all(Menu menu){
	     List<Menu>  children= menuMapper.selectAllChildren(menu.getId());
	     menu.setChildren(children);
	     if(children==null||children.size()==0)
	    	 menu.setState("open");
	     for(Menu m:children){
	    	 if(m.getState().equals("closed")){
	    		 all(m);
	    	 }
	     }
	     return menu;
   }


	@Override
	public Menu selectNeedMenu(int roleId) {
		// TODO Auto-generated method stub
		Menu menu=menuMapper.selectOne(-1);
		//通过roleid 获取所有有权限的menuId
		Integer[] menuids=roleMapper.selectMenusByRoleid(roleId);
		menu=need(menu,menuids);
		return menu;
	}
	
	private  Menu  need(Menu menu,Integer[] menuids){
		  Map<String,Object>  map=new HashMap<String, Object>();
		  map.put("pid", menu.getId());
		  map.put("menuids", menuids);
		  List<Menu> children= menuMapper.selectNeedChildren(map);
		  menu.setChildren(children);
		  if(children==null||children.size()==0){
			  menu.setState("open");
		  }
		  for(Menu m:children){
			  if(m.getState().equals("closed")){
				  need(m,menuids);
			  }
		  }
		  return menu;
	}


	@Override
	public int insertMenuAndUpdateState(Menu menu) {
		// TODO Auto-generated method stub
		menuMapper.insert(menu);
		return menuMapper.updateStateToClosed(menu.getParentId());
	}


	@Override
	public int deleteAndUpdateState(int id, int parentId) {
		// TODO Auto-generated method stub
		menuMapper.delete(menuMapper.selectOneCommon(id));
		if(parentId!=0){
			menuMapper.updateStateToOpen(parentId);
		}
		return 1;
	}
}

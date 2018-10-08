package com.senyuan.service.imp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.senyuan.entity.Role;
import com.senyuan.service.IRoleService;


@Service
public class RoleService extends BaseService<Role> implements IRoleService {

	@Override
	public Integer[] selectMenuidsByRoleId(int roleId) {
		// TODO Auto-generated method stub
		return roleMapper.selectMenusByRoleid(roleId);
	}

	@Override
	public int deleteAndInsert_rm_table(int roleId, int[] menuids) {
		// TODO Auto-generated method stub
		roleMapper.delete_rm_table(roleId);
		List<Map<String,Object>>  list=new ArrayList<Map<String,Object>>();
		Map<String,Object>   map=null;
		for(int menuid:menuids){
			map=new HashMap<String, Object>();
			map.put("roleId", roleId);
			map.put("menuId", menuid);
			list.add(map);
		}
		return roleMapper.insert_rm_table(list);
	}

	

}

package com.senyuan.action;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.senyuan.entity.Page;
import com.senyuan.entity.Role;
import com.senyuan.entity.User;
import com.senyuan.service.IUserService;
import com.senyuan.util.InfoJasonUtil;
import com.senyuan.util.StringUtil;




@Controller
@RequestMapping("/user")
public class UserAction extends  BaseAction{
    @Resource
    private  IUserService  userService;
	
	@RequestMapping("/login")
	public  String login(User user,String code,HttpSession  session){
		String session_code=(String) session.getAttribute("sRand");
		if(!code.equals(session_code)){
			session.setAttribute("errorinfo", "验证码不对！");
			return  "/login.jsp";
		}
		//开始后台验证
		user=userService.login(user);
		if(user==null){
			session.setAttribute("errorinfo", "用户名或者密码不对！");
			return "/login.jsp";
		}
		session.setAttribute("userinfo",user );
		return  "/WEB-INF/main/main.jsp";
	}
	
	@RequestMapping("/logout")
	public   String  logout(HttpSession  session){
		session.invalidate();
		return "redirect:/login.jsp";
	}
	
	@RequestMapping("/changepwd")
	public  @ResponseBody Object  changePassword(String new_pwd1,HttpSession  session ){
		int count=userService.updatePwd(((User) session.getAttribute("userinfo")).getUserId(), new_pwd1);
		if(count>0){
			return new  InfoJasonUtil("success", "修改密码成功");
		}
		return  null;
	}
	
	@RequestMapping("/list.action")
	public  @ResponseBody Object  list(Page<User> page,Role role){
		if(role!=null&&role.getRoleName()!=null){
			User user=new User();
			user.setRole(role);
			page.setKeyWord(user);
		}
		return userService.selectPage(page).getResMap();
		
	}
	
	@RequestMapping("/deleteList")
	public @ResponseBody Object  deleteList(Integer[] ids){
	   return  userService.deleteList(ids);
	}
	
	@RequestMapping("/add")
	public @ResponseBody Object  add(User user,@RequestParam("headfile")MultipartFile headfile)throws Exception{
		File tofile=null;
		if(headfile!=null&&headfile.getOriginalFilename()!=null&&headfile.getOriginalFilename().length()>2
				){
			 String uuid_filename=StringUtil.filenameToUUID(headfile.getOriginalFilename());
			 tofile=new  File(application.getRealPath("upload")+"/userhead/"+uuid_filename);
			 headfile.transferTo(tofile);
			 user.setUserType("/userhead/"+uuid_filename);
		}
		return userService.insert(user);
	}
	
	@RequestMapping("/update")
	public @ResponseBody Object  update(User user,@RequestParam("userhead") MultipartFile  userhead)throws Exception{
		File toFile=null;
		if(userhead!=null&&userhead.getOriginalFilename()!=null&&userhead.getOriginalFilename().length()>2){
			//有文件上传需要处理下
			String  uuid_filename=StringUtil.filenameToUUID(userhead.getOriginalFilename());
			toFile=new File(application.getRealPath("upload")+"/userhead/"+uuid_filename);
			userhead.transferTo(toFile);
			//上传完成
			user.setUserType("/userhead/"+uuid_filename);
			//user所有属性注入完成
		}
		
		return userService.update(user);
	}
}

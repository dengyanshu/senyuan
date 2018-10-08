package com.senyuan.action;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.senyuan.entity.Notice;
import com.senyuan.entity.Page;
import com.senyuan.service.INoticeService;




@Controller
@RequestMapping("/notice")
public class NoticeAction {
    
	@Resource
	private  INoticeService  noticeService;
	
	@RequestMapping("/list")
	public @ResponseBody Object list(Page<Notice> page,Notice notice){
		if(notice!=null&&notice.getNoticeTitle()!=null){
			page.setKeyWord(notice);
		}
		return noticeService.selectPage(page).getResMap();
	}
	
	@InitBinder
	protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) throws Exception {
		// TODO Auto-generated method stub
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new  SimpleDateFormat("yyyy-MM-dd HH:mm"), true));
	}
	
	
	
	@RequestMapping("/add")
	public @ResponseBody Object add(Notice notice){
		return noticeService.insert(notice);
	}
	
	
	@RequestMapping("/deleteList")
	public @ResponseBody Object deleteList(Integer[] ids){
		return noticeService.deleteList(ids);
	}
	
	@RequestMapping("/selectOne")
	public @ResponseBody Object selectOne(Integer noticeId){
		return noticeService.selectOne(noticeId);
	}
}

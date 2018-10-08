package com.senyuan.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.senyuan.entity.User;



public class LoginFilter implements  javax.servlet.Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
    
	/**
	 * 过滤处理  
	 * login.jsp
	 * head.jsp
	 * css 
	 * js
	 * jpg
	 * png
	 * JPG
	 * ico
	 * code.jsp
	 * */
	@Override
	public void doFilter(ServletRequest re, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest  request=(HttpServletRequest) re;
		HttpServletResponse  response=(HttpServletResponse) resp;
		String url=request.getRequestURI();
		if(url.endsWith("login.jsp")||url.endsWith("controller.jsp")||url.endsWith("login.action")||url.endsWith("head.jsp")||url.endsWith("code.jsp")
		   ||url.endsWith(".css")||url.endsWith(".js")||url.endsWith(".jpg")||url.endsWith(".JPG")
			||url.endsWith(".png")||url.endsWith(".ico")){
			chain.doFilter(request, response);
		}
		else{
			HttpSession  session=request.getSession();
			User user=(User) session.getAttribute("userinfo");
			if(user!=null){
				chain.doFilter(request, response);
			}
			else{
				response.sendRedirect("/zowee/login.jsp");
			}
		}
		
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}

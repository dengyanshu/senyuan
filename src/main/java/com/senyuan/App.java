package com.senyuan;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * jar包启动  后续使用docker启动程序
 * 
 *  springboot 主程序
 * */

@SpringBootApplication
@Controller
@EnableSwagger2
public class App {
    
	@RequestMapping("/hello")
	public @ResponseBody String hello(){
		return "hello";
	}
	//dadaaaadada
	public static void main(String[] args) {
		SpringApplication.run(App.class, args);
	}
}

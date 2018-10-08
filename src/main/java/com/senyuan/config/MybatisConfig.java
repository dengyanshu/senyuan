package com.senyuan.config;

import java.beans.PropertyVetoException;
import java.io.IOException;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.web.servlet.support.SessionFlashMapManager;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@Configuration
@MapperScan(basePackages="com.senyuan.dao",sqlSessionFactoryRef="masterSqlSessionFactory")
public class MybatisConfig {
   
	
	/**
	 * 1、注入数据源
	 * 2、sessionFactory
	 * 3、事务配置
	 * 
	 * */
	
	
	@Value("${spring.datasource.driverclass}")
	private  String driverclass;
	 
	 @Value("${spring.datasource.url}")
		private  String url;
	 
	 
	 @Value("${spring.datasource.username}")
		private  String user;
	 
	 
	 @Value("${spring.datasource.password}")
		private  String password;
	
	 @Bean(name="masterDataSource") 
	public  ComboPooledDataSource   masterDataSource(){
		ComboPooledDataSource   ds=new ComboPooledDataSource();
		try {
			ds.setDriverClass(driverclass);
		} catch (PropertyVetoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ds.setJdbcUrl(url);
		ds.setUser(user);
		ds.setPassword(password);
		return ds;
	}
	
	 @Bean("masterSqlSessionFactory")
	public  SqlSessionFactoryBean   sqlSessionFactory(@Qualifier("masterDataSource") ComboPooledDataSource  dataSource){
		  SqlSessionFactoryBean  sqlSessionFactoryBean=new SqlSessionFactoryBean();
		  sqlSessionFactoryBean.setDataSource(dataSource);
		  //设置mybatis.xml的位置   直接写在springboot的application.yml中
		  //sqlSessionFactoryBean.setConfigLocation(configLocation);
		  //设置mapping路径的位置
		  PathMatchingResourcePatternResolver   pathMatchResourcePatternResolver=new PathMatchingResourcePatternResolver();
		  try {
			sqlSessionFactoryBean.setMapperLocations( pathMatchResourcePatternResolver.getResources("classpath:com.senyuan.dao.*"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		    sqlSessionFactoryBean.setTypeAliasesPackage("com.senyuan.entity");
		  return  sqlSessionFactoryBean;
	}
	 
	 
	 
	
	
}

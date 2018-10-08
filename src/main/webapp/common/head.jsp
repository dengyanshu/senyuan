<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
pageContext.setAttribute("path", path);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 <head>
   

    <title>森源MES</title>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<link rel="stylesheet" type="text/css" href="${path}/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${path}/themes/bootstrap/easyui.css">
	
	 <link rel="Shortcut Icon" href="${path}/image/faviconMESplus.ico" type="image/x-icon">
      
      <script type="text/javascript" src="${path}/js/jquery.min.js"></script>
      <script type="text/javascript" src="${path}/js/jquery.easyui.min.js"></script>
      <script type="text/javascript" src="${path}/js/easyui-lang-zh_CN.js"></script>
      
 </head>
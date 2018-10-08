<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
 String path=request.getContextPath();
 pageContext.setAttribute("path", path);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'extpage.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	
	<script type="text/javascript" src="${path}/extjs/bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="${path}/extjs/resources/css/ext-all.css">
	

  </head>
  
  <body>
     <script type="text/javascript" src="app.js"></script>
  </body>
</html>

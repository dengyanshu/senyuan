<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include  file="/common/head.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
  </head>
  
  <body>
       <table id="dg"></table>  
       <script type="text/javascript">
	         $('#dg').datagrid({    
	    	    url:'${path}/supplier/list.action',  
	    	    pagination:true,
	    	    pageSize :  5,
	    	    pageList:[5,10,20,30,40,50],
	    	    columns:[[ 
	    	              {checkbox:true},
	    	        {field:'supId',title:'supId',width:100},    
	    	        {field:'supName',title:'supName',width:100},    
	    	        {field:'supLinkman',title:'supLinkman',width:100},    
	    	        {field:'supPhone',title:'supPhone',width:100},    
	    	        {field:'supAddress',title:'supAddress',width:100,align:'right'}    
	    	    ]]    
	    	}); 
       </script>
  </body>
</html>

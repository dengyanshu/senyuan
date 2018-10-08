<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include  file="/common/head.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="${path}/css/mesblue.css">
  </head>
  
  <body style="background: #daf0fd;">
      <table id="dg"></table>  
      <script type="text/javascript">
         $('#dg').datagrid({    
    	    url:'${path}/common/mo.json',  
    	    fitColumns:true,
    	    columns:[[    
                 {field:'moid',title:'工单ID',width:100,hidden:true}, 
    	        {field:'moname',title:'工单',width:100},    
    	        {field:'productname',title:'料号',width:100},    
    	        {field:'productdesc',title:'描述',width:100}    
    	    ]] ,
    	    onDblClickRow:function(rowIndex, rowData){
            	var  iframe_win=parent.$("iframe[name='作业示例']").get(0).contentWindow;
            	iframe_win.$(":input[name='moname']").val(rowData.moname);
            	iframe_win.$(":input[name='moid']").val(rowData.moid);
            	parent.$("#win").dialog("close");
            	iframe_win.$(":input[name='lotsn']").focus();
            }
    	});  
      </script>
    

      
      
      
  </body>
</html>

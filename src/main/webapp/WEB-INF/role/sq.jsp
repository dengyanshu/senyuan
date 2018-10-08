<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include  file="/common/head.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
      <ul id="tt"></ul>  

      <script type="text/javascript">
	        $('#tt').tree({    
	    	    url:'${path}/menu/all.action',
	    	    checkbox:true,cascadeCheck:false,
	    	    onLoadSuccess:function(){
	    	    	$('#tt').tree("expandAll");
	    	    	//根据选择的角色  查询出所有菜单id  然后迭代选中所有的
	    	    	var  iframe_win=parent.$("iframe[name='角色管理']").get(0).contentWindow;
	    	    	var roleId=iframe_win.$('#dg').datagrid("getSelected").roleId;
	    	    	$.ajax({
	    	    		   type: "POST",
	    	    		   url: "${path}/role/menuidbyroleid.action",
	    	    		   data: {
	    	    			   roleId:roleId
	    	    		   },
	    	    		   success: function(msg){
	    	    		       for(var  i=0;i<msg.length;i++){
	    	    		    	   //简写存在问题  当role_menu 的menuid在menu表 被删除后
	    	    		    	   if($('#tt').tree('find', msg[i])!=null){
	    	    		    		   $('#tt').tree("check",($('#tt').tree('find', msg[i])).target);
	    	    		    	   }
	    	    		    	   
	    	    		       }
	    	    		   }
	    	    	});
	    	    },
	    	    onCheck:function(node){
	        	  var node_parent= $('#tt').tree("getParent",node.target);
	        	  if(node_parent!=null){
	        		  $('#tt').tree("check",node_parent.target);
	        	  }
	            }
	    	});  
      </script>
  </body>
</html>

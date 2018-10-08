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
      <table id="tt" height="95%"></table>
	  <div id="mm" class="easyui-menu" style="width:120px;">
		<div onclick="javasrcipt:menuadd()"     data-options="iconCls:'icon-add'">追加</div>
		<div onclick="menudelete()"  data-options="iconCls:'icon-remove'">移除</div>
		<div onclick="menuupdate()"  data-options="iconCls:'icon-remove'">修改</div>
	  </div>  
      <script type="text/javascript">
	      $('#tt').treegrid({    
	    	    url:'${path}/menu/all.action',    
	    	    idField:'id',    
	    	    treeField:'text', 
	    	    fitColumn:true,
	    	    columns:[[  
	    	        {title:'菜单名称',field:'id',hidden:true,width:280},
	    	        {title:'菜单名称',field:'text',width:280},    
	    	        {title:'菜单图标',field:'iconCls',width:200,
	    	        	formatter: function(value,row,index){
	    					return "<div class="+value+">&nbsp;</div>";
	    				}	
	    	        },    
	    	        {field:'url',title:'菜单路径',width:260,
	    	        	formatter: function(value,row,index){
	    					return  row.attributes.url;
	    				}
	    	        },    
	    	        {field:'menuDescription',title:'菜单描述',width:380,
	    	        	formatter: function(value,row,index){
	    	        		return  row.attributes.menuDescription;
	    				}
	    	        }  
	    	    ]] ,
	    	    onLoadSuccess:function(){
	    	    	 $('#tt').treegrid("expandAll");
	    	    },
	    	    
	    	    toolbar: [{
	    			iconCls: 'icon-add',
	    			text:"增加",
	    			handler: function(){
	    				$.messager.alert('我的消息','请在所需菜单处，使用鼠标右键菜单操作','info');
	    			}
	    		},'-',{
	    			iconCls: 'icon-remove',
	    			text:"删除",
	    			handler: function(){$.messager.alert('我的消息','请在所需菜单处，使用鼠标右键菜单操作','info');}
	    		},'-',{
	    			iconCls: 'icon-edit',
	    			text:"修改",
	    			handler: function(){$.messager.alert('我的消息','请在所需菜单处，使用鼠标右键菜单操作','info');}
	    		}],
	    		
	    		
	    		// 右键点击节点并显示快捷菜单
	    		onContextMenu: function(e, node){
	    				e.preventDefault();
	    				// 查找节点
	    				$('#tt').treegrid('select', node.id);
	    				// 显示快捷菜单
	    				$('#mm').menu('show', {
	    					left: e.pageX,
	    					top: e.pageY-75
	    				});
	    		}
	    	});
	      
	      //菜单添加操作
	       function menuadd(){
	    	  //需要针对性变更父节点 不然会tree加载不了
	    	    var  text="菜单添加";
  	    	    var  url="${path}/base/url/menu/add.action";
	    	   parent.$("#win").dialog({
	    	    	 width:600,    
	    	         height:400, 
	    	         title:text,
	    	         modal:true,
	    	         iconCls:"icon-add",
	    	         content:"<iframe src="+url+" name="+text+" width=100% height=100% style='border:0px;'></iframe>",
	    	      	 buttons:[{
	  	 					text:'保存',
	  	 					iconCls:"icon-add",
		  	 				handler:function(){
		  	 					var  menuadd_iframe=parent.$("iframe[name='菜单添加']").get(0).contentWindow;
		  	 					var  url="";
		  	 					//判断父节点的状态 如果是closed 不需要变更 否则需要updatetoclose;
		  	 					var node=$('#tt').treegrid("getSelected");
		  	 					//不能直接用node的state去判断  tree只要是展开状态就是open
		  	 					if(node.children!=null&&node.children.length>0){
		  	 						url="${path}/menu/addMenu.action";
		  	 					}
		  	 					else{
		  	 						url="${path}/menu/addMenuAndUpdateState.action";
		  	 					}
		  	 					menuadd_iframe.$("#ff").form("submit",{
		  	 					    url:url,    
				  	 			    onSubmit: function(param){    
				  	 			         param.parentId=node.id;
				  	 			    },    
				  	 			    success:function(data){    
				  	 			    	parent.$("#win").dialog("close"); 
				  	 			    	$('#tt').treegrid("reload");
				  	 			    }    
		  	 						
		  	 					});
		  	 			    }
	  	 				},{
		  	 				text:'关闭',
		  	 				iconCls:"icon-cancel",
		  	 				handler:function(){
		  	 					parent.$("#win").dialog("close");
		  	 				}
	  	 				}]
	  	    	});
	       }
  	       function menudelete(){
  	    	  //删除   无法删除  直接删除 删除 变更state
  	    	 var node=$('#tt').treegrid("getSelected");
  	    	 if(node.children!=null&&node.children.length>0){
  	    		   $.messager.alert('我的消息','该菜单存在子菜单，不能删除，亲！','info');
  	    		   return;
  	    	 }
  	    	  //获取父亲节点 如果父亲有2个及以上的 可以直接删除
  	    	 var  parent_node= $('#tt').treegrid("getParent",node.id);
  	    	 var  parent_id=0;
  	    	 if(parent_node.children.length==1){
  	    		parent_id=parent_node.id;
  	    	 }
  	    	 $.ajax({
	    		   type: "POST",
	    		   url: "${path}/menu/deleteAndUpdateState.action",
	    		   data: {
	    			   id:node.id,
  	    	           parentId:parent_id
	    		   },
	    		   success: function(msg){
	    			  $('#tt').treegrid("reload");
	    		   }
	         });
  	    	  
  	    	  
  	       }
  	       function menuupdate(){
  	    	 //修改菜单 传到后台 进行封装
  	    	    var  text="菜单编辑";
  	    	    var  url="${path}/base/url/menu/update.action";
  	    	    parent.$("#win").dialog({
  	    	    	 width:600,    
  	    	         height:400, 
  	    	         title:text,
  	    	         modal:true,
  	    	         iconCls:"icon-edit",
  	    	         content:"<iframe src="+url+" name="+text+" width=100% height=100% style='border:0px;'></iframe>",
  	    	      	 buttons:[{
	  	 					text:'保存',
	  	 					iconCls:"icon-add",
		  	 				handler:function(){
		  	 				    var  menuadd_iframe= parent.$("iframe[name='菜单编辑']").get(0).contentWindow;
		  	 				    menuadd_iframe.$('#ff').form('submit', {
		  	 				    	url:"${path}/menu/update.action",
			  	 				    success: function(data){
			  	 				    	var msg="false";
			  	 				       if(data!=0){
			  	 				    	 msg="success";
			  	 				       }
				  	 				    $.messager.show({
			  	 				    		title:'更新消息',
			  	 				    		msg:msg,
			  	 				    		timeout:4000,
			  	 				    		showType:'slide'
			  	 				    	});
				  	 				    parent.$("#win").dialog("close");
				  	 				    $('#tt').treegrid("reload");
			  	 				    }    
			  	 				});  


		  	 			    }
	  	 				},{
		  	 				text:'关闭',
		  	 				iconCls:"icon-cancel",
		  	 				handler:function(){
		  	 					parent.$("#win").dialog("close");
		  	 				}
	  	 				}]
	  	    	});
	  	     }
      </script>
      
      
  </body>
</html>

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
      <table id="dg"></table>
      
      <script type="text/javascript">
	       $('#dg').datagrid({    
	    	    url:'${path}/role/list.action', 
	    	    pagination:true,
	    	    //idField:roleId,
	    	    columns:[[    
	    	        {checkbox:true},   
	    	        {field:'roleId',title:'角色名称',width:100,hidden:true},    
	    	        {field:'roleName',title:'角色名称',width:100},    
	    	        {field:'roleDesc',title:'角色描述',width:100,align:'right'}    
	    	    ]],
	    	    
	    	    toolbar: [{
	    			iconCls: 'icon-add',
	    			text:"添加",
	    			handler: function(){
	    				alert("暂未开发");
	    			}
	    		},'-',{
	    			iconCls: 'icon-edit',
	    			text:"编辑",
	    			handler: function(){
	    				alert("暂未开发");
	    			}
	    		},'-',{
	    			iconCls: 'icon-remove',
	    			text:"删除",
	    			handler: function(){
	    				alert("暂未开发");
	    			}
	    		},"-",{
	    			iconCls: 'icon-roleManage',
	    			text:"角色授权",
	    			handler: function(){
	    				if($('#dg').datagrid("getSelections").length!=1){
	    					$.messager.alert('我的消息','请选择一条进行编辑','info');
	    				} 
	    				else{
	    					parent.$("#win").dialog({
	    						    title:"角色授权",
	    						    width: 600,    
	    						    height: 600,    
	    						    closed: false,    
	    						    cache: false,    
	    						    modal: true,   
	    						    content: "<iframe src='${path}/base/url/role/sq.action' name='角色授权' width=100% height=100% style='border:0px;' ></iframe>",    
	    						    buttons:[{
	    								text:'保存',
	    								iconCls:"icon-ok",
	    								handler:function(){
	    									//var nodes = $('#tt').tree('getChecked'); 获取选择的
	    									var roleId= $('#dg').datagrid("getSelected").roleId;
	    									var iframe_win=parent.$("iframe[name='角色授权']").get(0).contentWindow;
	    									var nodes=iframe_win.$('#tt').tree("getChecked");
	    								    var  menuids=new Array();
	    								    for(var i=0;i<nodes.length;i++){
	    								    	menuids[i]=nodes[i].id;
	    								    }
	    									$.ajax({
	    					    	    		   type: "POST",
	    					    	    		   url: "${path}/role/sq.action",
	    					    	    		   data: {
	    					    	    			   roleId:roleId,
	    					    	    			   menuids:menuids
	    					    	    		   },
	    					    	    		   traditional:true,
	    					    	    		   success: function(msg){
	    					    	    			   parent.$("#win").dialog("close");
	    					    	    			   $.messager.show({
	    					    	    					title:'授权提示',
	    					    	    					msg:'授权成功',
	    					    	    					timeout:5000,
	    					    	    					showType:'slide'
	    					    	    				});

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
	    				
	    			}
	    		}
	    		
	    		]

	    	    
	    	}); 
	       
	       
      </script>
  </body>
</html>

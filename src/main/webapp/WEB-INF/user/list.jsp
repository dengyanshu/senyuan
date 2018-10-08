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
      <div class="yanshu-panel yanshu-fl yanshu-bg-blue">
          <div class="yanshu-content">
               <div id="dg" ></div>
          </div>
      </div>
      
      <script type="text/javascript">
	        $('#dg').datagrid({    
	    	    url:'${path}/user/list.action', 
	    	    pagination:true,
	    	    columns:[[
	    	              {checkbox:true},
	    	        {field:'userId',title:'用户ID',width:200,hidden:true},    
	    	        {field:'userName',title:'用户名',width:200},    
	    	        {field:'userPassword',title:'密码',width:200},    
	    	        {field:'userType',title:'用户头像',width:100,hidden:true},    
	    	        {field:'userDescription',title:'用户描述',width:200},    
	    	        {field:'roleName',title:'权限组',width:200,formatter: function(value,row,index){
	    				 return row.role.roleName;
	    			   }
                    }, 
	    	        {field:'roleDesc',title:'权限组功能描述',width:300,align:'right',formatter: function(value,row,index){
	    				 return row.role.roleDesc;
	    			   }}    
	    	    ]],
	    	    toolbar: [{
	    			iconCls: 'icon-add',
	    			text:'添加用户',
	    			handler: function(){
	    				//处理用户图像上传 先spring表单上传到后台 然后返回路径给前台
	    				var  text="添加用户";
	    				var  url="${path}/base/url/user/add.action";
	    				parent.$("#win").dialog({
	    					    title: text,
	    					    iconCls:"icon-userManage",
	    					    width: 600,    
	    					    height: 400,    
	    					    closed: false,    
	    					    cache: false,    
	    					    modal: true ,
	    					    content:"<iframe src="+url+" name="+text+" height=100% width=100% style='border:0px;'></iframe>",
	    					    buttons:[{
	    							text:'保存',
	    							iconCls:"icon-ok",
	    							handler:function(){
	    								var  iframe_form=parent.$("iframe[name='添加用户']").get(0).contentWindow;
	    								iframe_form.$("#ff").form("enableValidation");
	    								if(iframe_form.$("#ff").form("validate")){
	    									iframe_form.$("#ff").form("submit",{
	    										url:"${path}/user/add.action",
	    										success:function(data){    
	    											parent.$("#win").dialog("close");
	    											 $('#dg').datagrid("reload");
	    									    }    

	    									})
	    								}
	    							}
	    						},{
	    							text:'关闭',
	    							iconCls:"icon-cancel",
	    							handler:function(){
	    								parent.$("#win").dialog("close");
	    							}
	    						}]

	    				})
                    }
	    		},'-',{
	    			iconCls: 'icon-remove',
	    			text:'删除用户',
	    			handler: function(){
	    				//删除最简单
	    				 var rows=$('#dg').datagrid("getChecked");
	    				 if(rows.length==0){
	    					 $.messager.alert('我的消息','请至少选择一行进行删除！！','info');
	    					 return;
	    				 }
	    				 $.messager.confirm('确认对话框', '您确认删除吗?', function(r){
	    						if (r){
	    						    var  ids=new Array();
	    						    for(var i=0;i<rows.length;i++){
	    						    	ids[i]=rows[i].userId;
	    						    }
	    						    //开启ajax处理删除业务
	    						    $.ajax({
	    						    	   type: "POST",
	    						    	   url: "${path}/user/deleteList.action",
	    						    	   data: {
	    						    		   ids:ids
	    						    	   },
	    						    	   traditional:true,
	    						    	   success: function(msg){
	    						    		   $.messager.show({
	    						    				title:'我的消息',
	    						    				msg:'成功删除数据'+msg+'条',
	    						    				timeout:2000,
	    						    				showType:'slide'
	    						    			});

	    						    	      $('#dg').datagrid("reload");
	    						    	      $('#dg').datagrid("clearChecked");
	    						    	   }
	    						    });
	    						}
	    				});
	    			}
	    		},'-',{
	    			iconCls: 'icon-edit',
	    			text:'修改用户',
	    			handler: function(){
	    				//修改用户
	    				var  rows=$("#dg").datagrid("getChecked");
	    				if(rows.length!=1){
	    					$.messager.alert('我的消息','请选择一行进行编辑！！','info');
	    					return;
	    				}
	    				
	    				var  text="修改用户";
	    				var  url="${path}/base/url/user/update.action";
	    				parent.$("#win").dialog({
	    					    title: text,
	    					    iconCls:"icon-userManage",
	    					    width: 600,    
	    					    height: 400,    
	    					    closed: false,    
	    					    cache: false,    
	    					    modal: true ,
	    					    content:"<iframe src="+url+" name="+text+" height=100% width=100% style='border:0px;'></iframe>",
	    					    buttons:[{
	    							text:'保存',
	    							iconCls:"icon-ok",
	    							handler:function(){
	    								var  iframe_form=parent.$("iframe[name='修改用户']").get(0).contentWindow;
	    								iframe_form.$("#ff").form("enableValidation");
	    								if(iframe_form.$("#ff").form("validate")){
	    									iframe_form.$("#ff").form("submit",{
	    										url:"${path}/user/update.action",
	    										success:function(data){    
	    											parent.$("#win").dialog("close");
	    											 $('#dg').datagrid("reload");
	    									    }    

	    									})
	    								}
	    							}
	    						},{
	    							text:'关闭',
	    							iconCls:"icon-cancel",
	    							handler:function(){
	    								parent.$("#win").dialog("close");
	    							}
	    						}]

	    				})
                    }
	    		},'-',{
	    			text:"<input id='ss' class='easyui-searchbox' style='width:300px' data-options='searcher:select,prompt:\"输入权限组关键字检索\"'></input>",
	    		}]

	    	}); 
	        

            function  select(){
            	var  roleName="%"+$("#ss").searchbox("getValue")+"%";
            	 $('#dg').datagrid("reload",{
            		roleName:roleName
            	 });
            } 
      </script>
  </body>
</html>

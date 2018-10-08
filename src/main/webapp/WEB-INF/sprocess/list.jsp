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
  
  <body>
        
           <div class="yanshu-panel  yanshu-bg-blue">
			       <div class="yanshu-notice  yanshu-fontcolor" >
			             <div style="float: left;width: 20%;height: 4%;">
			                <form  id="ff" style="float: left;" enctype="multipart/form-data"  method="post">
			                    <input type="file" name="spExcel"  id="spExcel">
			                </form>
			             </div>
			             <a id="upload"  style="width: 12%;float: left;" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">上传EXCEL</a> 
			             <a id="downExcel" href="#"  style="width: 12%;float: left;" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">下载模板</a> 
			             <div style="width: 1%;float: right;">&nbsp;</div>
			             <a id="export" href="#" style="width: 12%;float: right;"  class="easyui-linkbutton" data-options="iconCls:'icon-remove'">导出所有</a> 
			            
			        </div>
			       
			        <div class="yanshu-content2">
			           <div  id="dg"></div>
			        </div>
			        
		  </div>
        
    
         
         
      
      
      <script type="text/javascript">
      $("#export").click(function(){
    	  location.href="${path}/sp/exportall.action";
      });
      
      $("#downExcel").click(function(){
    	  location.href="${path}/sp/downExample.action";
      });
      
      $("#upload").click(function(){
    	    //上传 ajax  上传到后台  表单提交
    	  
    	    //xlsx  xls
    	    /**
    	    var  str="您好.text";
    	    var  regex=/.+\.xlsx?/;
    	   alert( str.match(regex));
    	    return;
    	    */
    	    $.messager.confirm('确认对话框', '确定批量上传excel吗?', function(r){
    	    	if (r){
    	    		 var  filename=$("#spExcel").val();
    	     	    var regex=/.+\.xlsx?/;
    	     	    if(filename==null||filename==""||filename.match(regex)==null){
    	     	    	   $.messager.alert('我的消息','文件为空或者是非法的excel文件','info');
    	     	    	   return;
    	     	    }
    	     	     $('#ff').form('submit', {
    	     	    	 url:"${path}/sp/upload.action",
    	     		     success: function(data){ 
    	     		    	 $('#dg').datagrid("reload");
    	     		    	 $.messager.alert('我的消息','excel批量导入成功！','info');
    	     		     }   
    	     		}); 
    	    	   
    	    	}
    	    });
      });
      
      
      
      $('#dg').datagrid({    
    	    url:'${path}/sp/list.action',
    	    pagination:true,
    	    fitColumns:true,
    	    columns:[[
    	              {checkbox:true},
    	        {field:'spName',title:'存储过程名字',width:250},    
    	        {field:'spFunction',title:'存储过程作用',width:350},    
    	        {field:'spDatabase',title:'隶属于数据库',width:100},    
    	        {field:'spAuthor',title:'作者',width:100},    
    	        {field:'spComment',title:'其他备注',width:450},    
    	    ]],
    	    toolbar: [{
    			iconCls: 'icon-add',
    			text:'添加',
    			handler: function(){
                       //弹出对话框
                       var  text="添加存储过程";
                       var  url="${path}/base/url/sprocess/add.action";
                        parent.$("#win").dialog({
                        	title: text,
                        	iconCls:"icon-item",
                            width: 600,    
                            height: 400,    
                            closed: false,    
                            cache: false,    
                            modal: true ,  
                            content: "<iframe src="+url+"  name="+text+"   width=100%  height=100%  style='border:0px;'></iframe>" , 
                            buttons:[{
                				text:'保存',
                				iconCls:"icon-ok",
                				handler:function(){
                					//获取窗体里面的表单提交后台处理
                					var  iframe_add=parent.$("iframe[name='添加存储过程']").get(0).contentWindow;
                					iframe_add.$("#ff").form("enableValidation");
                					if(iframe_add.$("#ff").form("validate")){
                						iframe_add.$("#ff").form("submit",{
                							url:"${path}/sp/add.action",
                							success: function(data){    
                								 parent.$("#win").dialog("close");
                							      $('#dg').datagrid("reload");   
                						    }    
                						});
                					}
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
    		},'-',{
    			iconCls: 'icon-remove',
    			text:'删除',
    			handler: function(){
    				
    				var  rows=$('#dg').datagrid("getSelections");
    				if(rows.length==0){
  					  $.messager.alert('我的消息','请选择至少一行进行删除！','info');
                       return;
  				    }
    				
    				$.messager.confirm('确认对话框', '您想要删除吗？', function(r){
    					if (r){
    					    var   ids=new Array();
    					    for(var  i=0;i<rows.length;i++){
    					    	 ids[i]=rows[i].spId;
    					    }
    					    //ajax删除
    					    $.ajax({
    					    	   type: "POST",
    					    	   url: "${path}/sp/deleteList.action",
    					    	   data:{
    					    		   ids:ids
    					    	   },
    					    	   traditional:true,
    					    	   success: function(msg){
    					    		   $('#dg').datagrid("reload"); 
    					    		   $('#dg').datagrid("clearChecked"); 
    					    	   }
    					   });
    					}
    				});
                }
    		},'-',{
    			iconCls: 'icon-edit',
    			text:'编辑',
    			handler: function(){
    				  if($('#dg').datagrid("getSelections").length!=1){
    					  $.messager.alert('我的消息','请选择一行进行编辑！','info');
                             return;
    				  }
    				
    				  var  text="编辑存储过程";
                      var  url="${path}/base/url/sprocess/update.action";
                       parent.$("#win").dialog({
                       	title: text,
                       	iconCls:"icon-item",
                           width: 600,    
                           height: 400,    
                           closed: false,    
                           cache: false,    
                           modal: true ,  
                           content: "<iframe src="+url+"  name="+text+"   width=100%  height=100%  style='border:0px;'></iframe>" , 
                           buttons:[{
               				text:'保存',
               				iconCls:"icon-ok",
               				handler:function(){
               					//获取窗体里面的表单提交后台处理
               					var  iframe_add=parent.$("iframe[name='编辑存储过程']").get(0).contentWindow;
               					iframe_add.$("#ff").form("enableValidation");
               					if(iframe_add.$("#ff").form("validate")){
               						iframe_add.$("#ff").form("submit",{
               							url:"${path}/sp/update.action",
               							success: function(data){    
               								 parent.$("#win").dialog("close");
               							     $('#dg').datagrid("reload");   
               						    }    
               						});
               					}
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
    		},'-',{
    			text:"<input id='ss' class='easyui-searchbox' style='width:300px' "+
    			" data-options='searcher:select,prompt:\"输入存储过程名字关键字检索\" '></input>",
    			
    		}
    		
    		]

    	});  
        
      //条件查询 处理
      function  select(){
    	  var  spName=$("#ss").searchbox("getValue");
    	  $('#dg').datagrid("reload",{
    		  spName:"%"+spName+"%"
    	  });
      }

      </script>
      
      
  </body>
</html>

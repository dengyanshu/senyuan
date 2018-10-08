<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@include file="/common/head.jsp"%>
<html>
  <head>
	  
	  <link rel="stylesheet" type="text/css" href="${path}/css/mesblue.css">
	  <style type="text/css">
                .pagination-info {
					float: right;
					margin: 0 30px 0 0;
					padding: 0;
					height: 30px;
					line-height: 30px;
					font-size: 12px;
				}
				
	 </style>
	 
  </head>
  
  <body class="easyui-layout" >
	    <div data-options="region:'north'" style="height:70px;background:#2670b4;border: 0px"  >
	        <img src="${path}/image/logo.png" style="height:70px"></img>
	        <div style="float:right;margin-right: 15px;">
	             <img  id="headimg" height="70" width="70">
	        </div>
	        <div style="float: right;margin: 20px;color: #FFF ">
	                                        欢迎你，${userinfo.userName}<font  color="red">[${userinfo.role.roleName}]</font>
	        </div>
	    </div>   
	    <div data-options="region:'south'" style="height:40px;background:#2670b4;border: 0px"></div>  
	     
	    <div data-options="region:'west'" style="width:200px;background:#6bb1dc;border: 0px;padding-left: 0px; ">
	        <ul id="tt" style="margin-top: 15px;"></ul>  
		</div>
		
		<div data-options="region:'center'"  style="background:#eee;width:100%;height:100%;">
			<div id="tab" class="easyui-tabs" data-options="fit:true" style="padding:0px;background:#eee;">
			  <div class="sidebar fl p1" title="首页"  data-options="iconCls:'icon-home'">
			    <div class="subcolu fl"  >
				  <!-- left -->
				 <div class="subcolu1 bg2 fl">
					<div class="sideba_a fl bg3" id="pLoginHisInfo">
					    <ul class="mess fl">
							<li>
								<b class="icon19 fl"></b>
								<font class="fl">邮箱：</font>
								<span class="fl">
								  <a href='mailto:344630476@qq.com'  class="fontcolor7">
											344630476@qq.com
								   </a>
								
								</span>
							</li>
							<li>
								<b class="icon20 fl"></b>
								<font class="fl">运维:</font>
								<span class="fl">0755-12345678 (内线8134)
									
								</span>
							</li>
							<li>
								<b class="icon20 fl"></b>
								<font class="fl">开发:</font>
								<span class="fl">0755-12345678 (内线8134)
									
								</span>
							</li>
							<li>
								<b class="icon20 fl"></b>
								<font class="fl">需求:</font>
								<span class="fl">0755-12345678 (内线8134)
									
								</span>
							</li>
							<li>
								<b class="helpicon2 fl"></b>
								<font class="fl">&nbsp;&nbsp;版本:</font>
								&nbsp;&nbsp;V201780930_01
							</li>
						</ul>
					</div>
					<div class="title1 fontcolor2">
						<b class="b8"></b>
						<span>终端MES系统技术支持信息</span>
					</div>
				</div>
				 <!-- left -->
				 <!-- right -->
				 <div class="subcolu1 bg2 fl ml2">
					<div class="sideba_a fl bg3">
						<ul class="mess fl">
						    <li>
							    <span class="meshelp">
										<a href='http://oa.senyuan.com:9000/main/login.jsp' target="_blank" class="fontcolor7">
											<b class="helpicon1 fl"></b>
											森源OA
										</a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										森源OA系统链接
									</span>
							</li>
							<li>
							    <span class="meshelp">
										<a href='http://oa.senyuan.com:9000/main/login.jsp' target="_blank" class="fontcolor5">
											<b class="helpicon2 fl"></b>
											森源OA
										</a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										森源OA系统链接
									</span>
							</li>
							<li>
							    <span class="meshelp">
										<a href='http://oa.senyuan.com:9000/main/login.jsp' target="_blank" class="fontcolor2">
											<b class="helpicon1 fl"></b>
											森源OA
										</a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										森源OA系统链接
									</span>
							</li>
								<li>
							    <span class="meshelp">
										<a href='http://oa.senyuan.com:9000/main/login.jsp' target="_blank" class="fontcolor3">
											<b class="helpicon2 fl"></b>
											森源OA
										</a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;森源OA系统链接
									</span>
							</li>
								<li>
							    <span class="meshelp">
										<a href='http://oa.senyuan.com:9000/main/login.jsp' target="_blank" class="fontcolor4">
											<b class="helpicon1 fl"></b>
											森源OA
										</a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;森源OA系统链接
									</span>
							</li>
							<!--  
							<li>
							     <span class="fl">
								     <span class="meshelp">
								        <a href='javascript:doHelpForMes("1");' class="fontcolor5"><b class="helpicon1 fl"></b>在线帮助</a>
								     </span>
								     <span class="meshelp">
								       <a href='javascript:doHelpForMes("2");' class="fontcolor6"><b class="helpicon2 fl"></b>远程诊断</a>
								      </span>
								      <span class="meshelp">
								         <a href="http://172.19.53.37" class="fontcolor7" target="_blank"><b class="helpicon3 fl"></b>用户支持中心 </a>
								     </span>
							     </span>
							</li>
							-->
						</ul>
					</div>
					<div class="title1 fontcolor2">
						<b class="b8"></b>
						<span>常用网站链接</span>
					</div>
				</div>
				<!-- right -->
		      </div>
		       
		      <div class="subcolu2 fl bg2">
			         <div class="notice_t fontcolor2 fl ">
						<b class="b9"></b><span>系统公告</span>
					 </div>
					 <div id="dvSysAnnouncement" class="notice_body fl" >
					           <div id="notice"></div>
					 </div>
		        </div>
		      </div>
		      
		      
		  
	         </div>
	    </div>
        <div  id="win" ></div>
        <div  id="win2" ></div>
        
        
        
        
         <script type="text/javascript">
            $(function(){
            	$('#tt').tree({    
            	    //url:"${path}/menu/all.action" ,
            	    url:"${path}/menu/need.action?roleId=${userinfo.role.roleId}" ,
            	    //tree  for  we  need!
            	    onLoadSuccess:function(){
            	    	$('#tt').tree("expandAll");
            	    },
	            	onClick: function(node){
	            		var  text=node.text;
	            		var children=node.children;
	            		if(children!=null){
	            			return;
	            		}
	            		if(text=="安全退出"){
	            			$.messager.confirm('确认对话框', '您想要退出该系统吗？', function(r){
	            				if (r){
	            					//直接转到action  清理session 然后转到登陆页面
	    	            			location.href="${path}/user/logout.action";
	            				}
	            			});
	            		}
	            		else if(text=="修改密码"){
	            			var url="${path}/base/url/user/pwd.action";
	            			
	            			$('#win').dialog({    
	            			    title: text,    
	            			    width: 300,    
	            			    height: 300,    
	            			    closed: false,    
	            			    cache: false,    
	            			    modal: true,
	            			    iconCls:"icon-modifyPassword",
	            			    content:"<iframe src="+url+"  name="+text+" width=100% height=100% style='0px;'></iframe>",
	            			    buttons:[{
	            					text:'保存',
	            					iconCls:"icon-ok",
	            					handler:function(){
	            						//提交到后台处理,先前台预处理
	            						var  iframe_win=$("iframe[name='修改密码']").get(0).contentWindow;
	            						var  origin_pwd=iframe_win.$(":password[name='userPassword']").val();
	            						var  new_pwd1=iframe_win.$(":password[name='pwd1']").val();
	            						var  new_pwd2=iframe_win.$(":password[name='pwd2']").val();
	            						
	            						if(origin_pwd!="${userinfo.userPassword}"){
	            							$.messager.alert('我的消息','原密码输入错误','info');
	            							return ;
	            						}
	            						if(new_pwd1==null||new_pwd1==""||new_pwd2==null||new_pwd2==""){
	            							$.messager.alert('我的消息','新密码和确认密码不能为空','info');
	            							return ;
	            						}
	            						if(new_pwd1!=new_pwd2){
	            							$.messager.alert('我的消息','2次输入的新密码不一致','info');
	            							return ;
	            						}
	            						//提交隐藏的id 和pwd1到后台进行密码更新
	            						$.ajax({
	            							   type: "POST",
	            							   url: "${path}/user/changepwd.action",
	            							   data: {
	            								   new_pwd1:new_pwd1
	            							   },
	            							   success: function(msg){
	            							      //修改成功的处理
	            								   $('#win').dialog("close");
	            								   $.messager.show({
	            										title:'密码修改提示',
	            										msg:'修改成功。下次登录生效',
	            										timeout:5000,
	            										showType:'slide'
	            									});

	            							   }
	            						});
	            					}
	            				},{
	            					text:'取消',
	            					iconCls:"icon-cancel",
	            					handler:function(){
	            						$('#win').dialog("close");
	            					}
	            				}]

	            			
	            			
	            			});    
	            		}
	            		else{
	            			var  url="${path}/base/url/"+node.attributes.url;
	            			var  text=node.text;
	            			
	            			if($("#tab").tabs("exists",text)){
	            				$("#tab").tabs("select",text);
	            			}
	            			else{
	            				$("#tab").tabs("add",{
	            					 title:text,
	            					 closable:true,
	            					 iconCls:node.iconCls,
	            					 content:"<iframe src="+url+" name="+text+" width=100% height=100% style='border:0px;'></iframe>" 
	            				});
	            			}
	            				
	            		}
	            	}
            	});  
            });
            
             
            //head
            var  head_src="";
            if("${userinfo.userType}"!=null&&"${userinfo.userType}"!=""){
            	head_src="${path}/upload/"+"${userinfo.userType}";
            }
            else{
            	head_src="${path}/image/userhead_blank.png";
            }
            $("#headimg").attr("src",head_src);
            
            
            var  ss_info="输入公告主题包含关键字";
            //公告信息处理 
            $('#notice').datagrid({    
			    url:'${path}/notice/list.action', 
			    fitColumns:true,
			    pagination:true,
			    pageList:[5,10,15,20],
			    pageSize:5,
			    idField:"noticeId",
			    columns:[[
			              {checkbox:true},
			              {field:'noticeId',title:'noticeId',align:'center',width:450,hidden:true}, 
			        {field:'noticeTitle',title:'公告主题',align:'center',width:450},    
			        {field:'noticeAuthor',title:'公告发布人',align:'center',width:250},    
			        {field:'createTime',title:'发布时间',align:'center',width:250,
			        	formatter: function(value,row,index){
			        		return new Date(value).toLocaleString();
						}
			        	
			        } ,  
			        {field:'button',title:'操作',align:'center',width:250,
			        	formatter: function(value,row,index){
			        		return "<DIV><input TYPE='button' NAME='notice_content_button' style='background-color:red;color: white;width:200px;height:32px;' VALUE='查看公告内容'></DIV>";
						}
			        } ,  
			    ]],
			    toolbar: [{
					iconCls: 'icon-add',
					text:"发布公告",
					handler: function(){
						if("${userinfo.role.roleId}"!=1){
							$.messager.alert('我的消息','非管理员无操作权限！','info');
							return  ;
						}
						var  text="发布公告";
						var  url="${path}/base/url/notice/add.action?time="+new Date().getTime();
						$("#win").dialog({
							 width:1000,    
		  	    	         height:600, 
		  	    	         title:text,
		  	    	         closable:true,
		  	    	         cache:false,
		  	    	         modal:true,
		  	    	         iconCls:"icon-add",
		  	    	         content:"<iframe src="+url+" name="+text+" width=100% height=100% style='border:0px;'></iframe>",
		  	    	      	 buttons:[{
			  	 					text:'保存',
			  	 					iconCls:"icon-add",
				  	 				handler:function(){
				  	 					var  add_iframe=$("iframe[name='发布公告']").get(0).contentWindow;
				  	 					add_iframe.$('#ff').form('submit', {    
				  	 					    url:"${path}/notice/add.action",    
					  	 					 success:function(data){    
					  	 						$("#win").dialog("close");
					  	 					    $('#notice').datagrid("reload");
					  	 					    //$('#notice').datagrid("clearChecked");
					  	 				     }    
				  	 					}); 
				  	 					
				  	 			    }
			  	 				},{
				  	 				text:'关闭',
				  	 				iconCls:"icon-cancel",
				  	 				handler:function(){
				  	 					$("#win").dialog("close");
				  	 				}
			  	 				}]
						});
						
                    }
				},'-',{
					
					iconCls: 'icon-remove',
					text:"撤销公告",
					handler: function(){
						if("${userinfo.role.roleId}"!=1){
							$.messager.alert('我的消息','非管理员无操作权限！','info');
							return  ;
						}
						//ajax 删除
						var rows= $('#notice').datagrid("getSelections");
						
						if(rows!=null&&rows.length>=1){
							
							$.messager.confirm('确认对话框', '您想要删除选定行？', function(r){
								if (r){
									var  ids=new Array();
									for(var i=0;i<rows.length;i++){
										ids[i]=rows[i].noticeId;
										
									}
									$.ajax({
										   url: "${path}/notice/deleteList.action",
										   type: "post",
										   data: {
											   ids:ids
										   },
										   traditional:true,
										   success: function(msg){
											   $('#notice').datagrid("load");
											   $('#notice').datagrid("clearChecked");
										   }
									});
								}
							});


							
						}
						else{
							$.messager.alert('我的消息','请至少选择一条进行删除！','info');
						}
						
					}
				},'-',{
					iconCls: 'icon-edit',
					text:"修改公告",
					handler: function(){
						if("${userinfo.role.roleId}"!=1){
							$.messager.alert('我的消息','非管理员无操作权限！','info');
							return  ;
						}
						
					}
				},'-',{
					text:"<input id='ss'  class='easyui-searchbox' style='width:200px' data-options=' searcher:select, prompt:\"输入公告主题关键字检索 \" '></input>"
				     }
				],
			    
				
				onClickCell:function(rowIndex, field, value){
					if(field=="button"){
						 //$('#notice').datagrid("un",rowIndex);
						 $('#notice').datagrid("clearChecked");
						 var url="${path}/base/url/notice/content.action";
						 $("#win").dialog({
							title:'公告内容',
							width:900,    
						    height:600,    
						    modal:true,
						    cache:false,
						    closable:true,
						    content:"<iframe src="+url+" name='公告内容' width=100%  height=100%  style='border:0px;'></iframe>"
						});
						
					};
				}

			}); 
            
            
            function select(){
            	var  noticeTitle=$("#ss").searchbox("getValue");
            	 $('#notice').datagrid("reload",{
            		 noticeTitle:"%"+noticeTitle+"%"
            	 }) ;
            }
         </script>

</body>
</html>

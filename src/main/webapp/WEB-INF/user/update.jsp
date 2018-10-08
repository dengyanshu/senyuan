<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@include file="/common/head.jsp"%>
<html>
  <head>
  </head>
   <body >
        <form  method="post" id="ff" enctype="multipart/form-data">
          <table>
          <tr><td> <input type="hidden"  name="userId"/> </td></tr>
             <tr><td>用户名</td><td><input type="text" name="userName"  readonly="readonly"/></td></tr>
             <tr><td>头像</td><td><img id="img" width="80" height="80" ><input type="file" name="userhead"/></td></tr>
             <tr><td>密码</td><td><input type="password" name="userPassword" class="easyui-validatebox" data-options="required:true"  /> </td></tr>
             <tr><td>用户描述</td><td><input type="text" name="userDescription"/></td></tr>
             <tr><td>权限组</td><td><select id="cc" class="easyui-combobox" name="role.roleId" style="width:150px;" > </td></tr>
         </table>
      </form>
      
      
      <script type="text/javascript">
         $(function(){
        	 $("#ff").form("disableValidation");
        	 var  iframe_dg=parent.$("iframe[name='用户管理']").get(0).contentWindow;
        	 var  row=iframe_dg.$("#dg").datagrid("getSelected");
        	 
        	 $('#ff').form('load',{
        		     userId:row.userId,
        		    userName:row.userName,
        		    userPassword:row.userPassword,
        		    userDescription:row.userDescription,
        	});
        	 
        	 
        	  $("#cc").combobox({
             	 url:"${path}/role/selectAll.action",
             	 valueField:'roleId',    
             	 textField:'roleName',
             	 panelHeight:80,
             	 editable:false,
             	 required:true, 
             	 onLoadSuccess:function(){
             		 $("#cc").combobox("select",row.role.roleId);
             	 }
              });
        	  var  img_src="";
         	  if(row.userType==null||row.userType==""){
         		 img_src="${path}/image/userhead_blank.png";
         	  }
         	  else{
         		 img_src="${path}/upload/"+row.userType;
         	  }
        	  $("#img").attr("src",img_src);

         });
      </script>
  </body>
</html>

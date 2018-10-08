<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@include file="/common/head.jsp"%>
<html>
  <head>
  </head>
   <body >
        <form  method="post" id="ff" enctype="multipart/form-data">
          <table>
             <tr><td>用户名</td><td><input type="text" name="userName"   class="easyui-validatebox" data-options="required:true"/></td></tr>
             <tr><td>头像</td><td><input type="file" name="headfile"/></td></tr>
             <tr><td>密码</td><td><input type="password" name="userPassword" class="easyui-validatebox" data-options="required:true"  /> </td></tr>
             <tr><td>用户描述</td><td><input type="text" name="userDescription"/></td></tr>
             <tr><td>权限组</td><td><select id="cc" class="easyui-combobox" name="role.roleId" style="width:150px;" > </td></tr>
         </table>
      </form>
      
      
      <script type="text/javascript">
         $(function(){
        	 $("#ff").form("disableValidation");
             $("#cc").combobox({
            	 url:"${path}/role/selectAll.action",
            	 valueField:'roleId',    
            	 textField:'roleName',
            	 panelHeight:80,
            	 required:true, 
            	 editable:false,
            	 onLoadSuccess:function(){
            		 $("#cc").combobox("select",10);
            	 }
             });
        	 
        	 
        	 
         });
        
      </script>
  </body>
</html>

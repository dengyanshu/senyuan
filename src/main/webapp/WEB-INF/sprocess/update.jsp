<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@include file="/common/head.jsp"%>
<html>
  <head>
  </head>
   <body >
        <form  method="post" id="ff">
          <table>
              <tr><td><input type="hidden" name="spId"  /></td></tr>
             <tr><td>存储过程名字</td><td><input type="text" name="spName"  class="easyui-validatebox" data-options="required:true"/></td></tr>
             <tr><td>存储过程作用</td><td><input type="text" name="spFunction"  /> </td></tr>
             <tr><td>所在数据库</td><td><input type="text" name="spDatabase"  class="easyui-validatebox" data-options="required:true"/></td></tr>
             <tr><td>作者</td><td><input type="text" name="spAuthor"/></td></tr>
             <tr><td>其他备注信息</td><td><input type="text" name="spComment"/></td></tr>
         </table>
      </form>
      
      
      <script type="text/javascript">
         $(function(){
        	 var  iframe_dg=parent.$("iframe[name='存储过程查询']").get(0).contentWindow;
        	 var  row=iframe_dg.$("#dg").datagrid("getSelected");
        	 
        	 $('#ff').form('load',{
        		     spId:row.spId,
        		    spName:row.spName,
        		    spFunction:row.spFunction,
        		    spDatabase:row.spDatabase,
        		    spAuthor:row. spAuthor,
        		    spComment:row. spComment
        	});

        	 $("#ff").form("disableValidation");
         });
      </script>
  </body>
</html>

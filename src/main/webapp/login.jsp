<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
   <head>
        <%@ include file="/common/head.jsp"%>
    
     
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- CSS -->
        <link rel="stylesheet" href="${path}/css/login1.css">
        <link rel="stylesheet" href="${path}/css/login2.css">
        <link rel="stylesheet" href="${path}/css/login3.css">
        
        <script type="text/javascript">
            if(window!=top){
            	top.location.href=location.href;
            }
        </script>
    </head>

    <body>
           
           <form  method="post" action="${path}/user/login.action" id="ff" style="top: 30%; left: 20%;position: absolute; ">
             <h1>森源</h1>
             <table>
                <tr><td style="text-align: right;padding-right: 15px">用户名</td><td><input type="text" class="easyui-validatebox"  data-options="required:true"  name="userName"/>  </td></tr>
                <tr><td style="text-align: right;padding-right: 15px">密码</td><td><input type="password"  class="easyui-validatebox"  data-options="required:true"  name="userPassword"/>  </td></tr>
                <tr><td style="text-align: right;padding-right: 15px">验证码</td><td><input type="text" class="easyui-validatebox"  data-options="required:true"  name="code"/>  </td><td><img  id="img" src="${path}/image/code.jsp" style="margin-left: 5px;" ></td></tr>
                <tr><td><input type="button" value="登陆" id="ok" style=" background: #ef4300;margin: 3px;"/></td><td><input type="reset" value="重置"  style=" background: #ef4300;"/></td></tr>
             </table>
              <div style="font-size: x-large;color: #ef4300">${errorinfo}</div>
           </form>
           
              
       
         
        <!-- Javascript -->
        <script src="${path}/js/supersized.3.2.7.min.js"></script>
        <script src="${path}/js/supersized-init.js"></script>
		<script>
			window.onload = function()
			{
				$(".connect p").eq(0).animate({"left":"0%"}, 600);
				$(".connect p").eq(1).animate({"left":"0%"}, 400);
			};
			function is_hide(){ $(".alert").animate({"top":"-40%"}, 300); }
			function is_show(){ $(".alert").show().animate({"top":"45%"}, 300) ;}
		</script>
		<script type="text/javascript">
		     $(function(){
			    	 $("#ff").form("disableValidation");
			    	 $("#img").click(function(){
			    		  $("#img").attr("src","${path}/image/code.jsp?time="+new  Date().getTime());
			    	 });
			    	 
			    	 
			    	 $("#ok").click(function(){
					       $("#ff").form("enableValidation");
					       if( $("#ff").form("validate")){
					    	   $("#ff")[0].submit();
					       }
				    });
			    	 
			   });
			  
		</script>
		   
		 
		
		
    </body>

</html>


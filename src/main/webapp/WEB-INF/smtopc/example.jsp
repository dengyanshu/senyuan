<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include  file="/common/head.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="${path}/css/mesblue.css">
	
	<style type="text/css">
	    .false{
	      color:red;
	    }
	    .success{
	      color:green;
	    }
	    input{
	      height: 30px;
	      width: 250px;
	    }
	
	</style>
	
  </head>
  <!--  style="background: #daf0fd;"-->
  <body  style="background: #daf0fd;">
       <div  style="height: 68%;width:97%;padding-left:2%;padding-top:2%;margin-left: 1%;">
         <form action="" id="ff">
            <input type="hidden" name="moid">
           <table>
             <tr>
              <td>工单</td>
              <td>
                 <input type="text" style="height: 30px;" name="moname" class="easyui-validatebox" data-options="required:true" readonly="readonly">
              </td>
               <td>
                  <a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="getmo()">=选择=</a>  
               </td>
             </tr>
             <tr>
              <td>批次号</td>
              <td>
                 <input type="text" class="easyui-validatebox" data-options="required:true" name="lotsn" id="lotsn">
              </td>
             </tr>
          </table>
       </form>
       
       
       
       </div>
       
       <div style="height: 24%;width:98%;background: black;padding-left: 2%;padding-top:2%;padding-bottom:2%; overflow:auto;" id="msg">
       </div>
     
     
       <script type="text/javascript">
       $(function(){
    	   $("#ff").form("disableValidation");
    	  /*
    	   $('#msg').panel({    
    		    fit:true
    		 
    		 });   

           */
    	   
    	   
    	   $("#lotsn").keydown(function(e){
    		   if(e.keyCode==13){
    			  //回车提交表单
    			  $("#ff").form("enableValidation");
    			  if( $("#ff").form("validate")){
    				    $('#ff').form('submit', {  
    				    	url:"${path}/report/smtopc_example.action",
    					    success: function(data){ 
    					    	var  data=JSON.parse(data);
    					        $("#lotsn").select();
    					        var  fontclass="";
    					        if(data.res!=0){
    					        	fontclass="false";
    					        }
    					        else{
    					        	fontclass="success";
    					        }
    					        var  allmsg=$("#msg").text();
    					        if(allmsg.split("ServerMessage").length>8){
    					        	 $("#msg").empty();
    					        }
    					        $("#msg").append("<b class="+fontclass+">["+new Date().toLocaleTimeString()+"]:" + data.msg+"</b><br/>");
    					        
    					    }    
    					});  


    			  }
    		   }
    	   });
    	   
       });
        function  getmo(){
        	var  url="${path}/base/url/smtopc/molist.action";
        	 parent.$("#win").dialog({
        		    title: '工单选择',    
        		    width: 700,    
        		    height: 400,    
        		    closed: false,    
        		    cache: false,    
        		    modal: true ,  
                    content:"<iframe src="+url+" name ='工单选择' height=100% width=100% style='border:0px;'></iframe>"
        	 });
        }
       </script>
      
      
  </body>
</html>

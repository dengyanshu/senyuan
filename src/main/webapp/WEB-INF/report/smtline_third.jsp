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
  
  <body >
      <input type="hidden" id="intervalid" /> 
      <div class="yanshu-panel yanshu-fl yanshu-bg-blue">
         <div class="yanshu-notice">
                     <div  class="yanshu-notice-voice">&nbsp;</div>
                     <a id="begin" href="#" class="easyui-linkbutton" onclick="javascript:begin()" data-options="iconCls:'icon-add'">开启刷新</a> 
                     <a id="end" href="#" class="easyui-linkbutton" onclick="javascript:end()" data-options="iconCls:'icon-remove'">关闭刷新</a> 
                     <!--  <a id="destory" href="#" class="easyui-linkbutton" onclick="javascript:destory()" data-options="iconCls:'icon-remove'">关闭页面</a>--> 
         </div>
          <div  class="yanshu-content2" >
             <div id="dg"></div>
          </div>
		</div>
      </div>

      <script type="text/javascript">
	     $("#dg").datagrid({
	    	    url:"${path}/report/smtline_third.action",
	    	    queryParams:{
		    		     moname:"${moname}",
		    			 workcenterid:"${workcenterid}"
		    	 },
		    	 nowrapL:true,
				    striped:true,
				    fitColumns:true,
		    	 pagination:true,
		    	 rowStyler: function(index,row){
						
						if (row.isAlert=="1"){
							return 'background-color: #8E2323;color:fff;'; //#cc9933 brown   // #2cfd5d 浅绿色；   //#157fcc #87c6eb浅蓝色  //#FFA500  浅黄色  ；
						}
						else if(row.isAlert=="2"){
							return 'background-color:#FFA500;color:black;';   
						}
						else{
							return 'background-color:#2cfd5d;color:black;'; 
						}
					},
	    		  columns : [[
	    					{
	    						field : 'RowNum',
	    						title : '序号',
	    						width : 40
	    					},
	    					{
	    						field : 'SLotNO',
	    						title : '站位',
	    						width : 140
	    					},
	    					{
	    						field : 'ProductName',
	    						title : '料号',
	    						width : 130
	    					}, {
	    						field : 'RequiredMount',
	    						title : '需求数',
	    						width : 80
	    					}, 
	    					 {
	    						field : 'WaitMount',
	    						title : '未上料数量',
	    						width : 80
	    					}, 
	    					{
	    						field : 'OnLoadMount',
	    						title : '上料数量',
	    						width : 80
	    					}, 
	    					{
	    						field : 'SurplusMount',
	    						title : '剩余数量',
	    						width : 80
	    					},
	    					{
	    						field : 'UnitQty',
	    						title : '单位数量',
	    						width : 80
	    					},
	    					{
	    						field : 'Side',
	    						title : 'A/B面',
	    						width : 80
	    					},
	    					{
	    						field : 'inputqty',
	    						title : '投板数量',
	    						width : 80
	    					},
	    					{
	    						field : 'CanUsePCBQty',
	    						title : '可生产板数',
	    						width : 80
	    					}
	    					
	    					 ] ]
	     });
	     //一打开是自动刷新的
	     $(function(){
	    	 $("#begin").linkbutton("disable");
	    	
	     });
	    var id= window.setInterval(
	    		 function(){
	    			 $("#dg").datagrid("reload",{
	    				 moname:"${moname}",
		    			 workcenterid:"${workcenterid}"
	    			 });
	             },60000
	      );
	     $("#intervalid").val(id);
	    
	     function end(){
	    	clearInterval(id);
	    	$("#begin").linkbutton("enable");
	    	$("#end").linkbutton("disable");
	     }
	     function begin(){
	    	 $("#dg").datagrid("reload",{
				 moname:"${moname}",
    			 workcenterid:"${workcenterid}"
			 });
	    	  id= window.setInterval(
		    		 function(){
		    			 $("#dg").datagrid("reload",{
		    				 moname:"${moname}",
			    			 workcenterid:"${workcenterid}"
		    			 });
		       },60000);
	    	  $("#intervalid").val(id);
	    	  $("#begin").linkbutton("disable");
		      $("#end").linkbutton("enable");
	    	  
	     }
      </script>
  </body>
</html>

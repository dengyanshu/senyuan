<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include  file="/common/head.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="${path}/js/progressbar.js"></script>
	<link rel="stylesheet"  type="text/css" href="${path}/css/progress_bar.css">
	<link  rel="stylesheet"   type="text/css"  href="${path}/css/mesblue.css">
  </head>
  
  <body >
      <div class="yanshu-panel yanshu-fl yanshu-bg-blue">
         <div class="yanshu-notice">
                     <div  class="yanshu-notice-voice">&nbsp;</div>
                        <font  color="red" style="bolder">${moname}&nbsp;&nbsp;&nbsp;</font>
						<span>
						       投产（产出条）：<img src="/zowee/image/green2.gif"/>&nbsp;已投入&nbsp;&nbsp;&nbsp;&nbsp;<img src="/zowee/image/red.gif"/>&nbsp;已产出
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工单（背景）：<img src="/zowee/image/green.gif"/>&nbsp;正在生产&nbsp;&nbsp;&nbsp;&nbsp;<img src="/zowee/image/orange.gif"/>&nbsp;已生产未结单     
						</span>
         </div>
          <div  class="yanshu-content">
             <div id="dg"></div>
          </div>
      </div>

      <script type="text/javascript">
	     $("#dg").datagrid({
	    	 url:'${path}/report/smtline_mo.action', 
	    	 queryParams:{
	    		 moname:"${moname}",
	    			 workcenterid:"${workcenterid}"
	    	 },
	    	 pagination:true,
	    	 rowStyler: function(index,row){
					if (row.isOver=="0"){
						return 'background-color:#2cfd5d;';    // #2cfd5d 浅绿色；   #157fcc浅蓝色  #87c6eb 浅蓝色//#FFA500  浅黄色  ；
					}
					else{
						return 'background-color:#FFA500;font-size:26px;font-family:helvetica,tahoma,verdana,sans-serif;';   
					}
				},
	    	 
	    		columns : [[
	    					{
	    						field : 'Num',
	    						title : '序号',
	    						width : 40
	    					},
	    					{
	    						field : 'MOName',
	    						title : '工单',
	    						width : 140
	    					},
	    					{
	    						field : 'ProductName',
	    						title : '产品料号',
	    						width : 100
	    					}, {
	    						field : 'MOQtyRequired',
	    						title : '需求数量',
	    						width : 80
	    					}, 
	    					{
	    						field : 'PlannedDateFrom',
	    						title : '计划开始时间',
	    						width : 180,
	    						formatter: function(value,row,index){
	    		 					var  date=new Date(value);
	    		 					return  date.toLocaleString();
	    		 				}
	    					}, {
	    						field : 'PlannedDateTo',
	    						title : '计划结束时间',
	    						width : 180,
	    						formatter: function(value,row,index){
	    		 					var  date=new Date(value);
	    		 					return  date.toLocaleString();
	    		 				}
	    					},
	    					{
	    						field : 'ExecuteDateFrom',
	    						title : '实际开始时间',
	    						width : 180,
	    						formatter: function(value,row,index){
	    		 					var  date=new Date(value);
	    		 					return  date.toLocaleString();
	    		 				}
	    					}, {
	    						field : 'ExecuteDateTo',
	    						title : '实际结束时间',
	    						width : 180,
	    						formatter: function(value,row,index){
	    							if(value!=undefined){
	    		 					var  date=new Date(value);
	    		 					return  date.toLocaleString();
	    							}
	    		 				}
	    					}, 
	    					{
	    						field : 'WorkcenterName',
	    						title : '线体',
	    						hidden:true
	    					}, 
	    					{
	    						field : 'InputDone',
	    						title : '投入产出比',
	    						width : 250,
	    						formatter : function(value,row,index) {
	    							return  ProgressStatus2(value);
	    						}
	    					} ] ] ,
	    					onDblClickRow:function(rowIndex, rowData){
	    						//双击弹出对话框 全屏幕
	    						var  src="${path}/report/smtline_third_para.action?time="+new Date().getTime()+"&moname="+rowData.MOName+"&workcenterid=${workcenterid}";
	    						parent.$("#win2").dialog({
	    							    title:'SMT上料站位信息===>[工作中心：'+rowData.WorkcenterName+'][工单：'+rowData.MOName+'][批量：'+rowData.MOQtyRequired+']',
	    							    modal:true ,
	    							    maximized:true,
	    							    cache:false,
	    							    width:600,
	    							    height:600,
	    							    content:"<iframe src="+src+" name='线体看板第三层' width=100% height=100% style='border:0px;'></iframe>",
	    							   
	    							    onBeforeClose:function(){
	    							    	//取
	    							    	   var smtline_third=parent.$("iframe[name='线体看板第三层']").get(0).contentWindow;
	    							    	   smtline_third.clearInterval(smtline_third.$("#intervalid").val());
	    							    	
	    							    }
	    							    
	    							  
	    						});
	    					}
	     });
      </script>
  </body>
</html>

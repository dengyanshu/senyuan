<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include  file="/common/head.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
      <link  rel="stylesheet"   type="text/css"  href="${path}/css/mesblue.css">
             <link   rel="stylesheet" type="text/css" href="${path}/bootstrap/bootstrap.min.css">
	  <link   rel="stylesheet" type="text/css" href="${path}/bootstrap/bootstrap-theme.min.css">
	  <script type="text/javascript" src="${path}/bootstrap/bootstrap.min.js"></script>
	  
	  
	  <script type="text/javascript" src="${path}/js/highcharts.js"></script>
  </head>
  
  <body>
       <div class="yanshu-panel yanshu-fl yanshu-bg-blue">
         <div class="yanshu-notice">
                     <div  class="yanshu-notice-voice">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                     <span class="label label-danger"  id="time">今日机台运行情况
                     </span>
         </div>
          <div  class="yanshu-content2" >
              <div id="dg" style="height:500px;"></div>
              <div id="container"></div>
          </div>
		</div>
      </div>

      <script type="text/javascript">
	     $("#dg").datagrid({
	    	    url:"${path}/report/getXiaomiMachine.action",
		    	 nowrapL:true,
				 striped:true,
				 fitColumns:true,
		    	 pagination:true,
		    	 pageNumber:1,
		    	 pageSize:12,
		    	 pageList:[12,24,48],
		    	 rowStyler: function(index,row){
						
		    		 /*
						if (row.status=="抛料"){
							return 'background-color: #8E2323;color:fff;'; //#cc9933 brown   // #2cfd5d 浅绿色；   //#157fcc #87c6eb浅蓝色  //#FFA500  浅黄色  ；
						}
						else{
							return 'background-color:#7ABE5A;color:black;'; 
						}
		    		 
		    		 */
		    		 
		    		 	if ((index % 2)==0){
	                        return 'background-color:#0000C6;color:#fff;font-weight:bold;';
	                    }
		                else{
		                      return 'background-color:#009100;color:#fff;font-weight:bold;';
		                }
					},
					
				
					
	    		  columns : [[
	    					
	    					{
	    						field : 'line',
	    						title : '线体',
	    						width : 50
	    					},
	    					{
	    						field : 'time',
	    						title : '时间',
	    						width : 320
	    					},{
	    						field : 'Machine',
	    						title : '机器',
	    						width : 80
	    					}, 
	    					{
	    						field : 'Stage',
	    						title : '基台',
	    						width : 80
	    					}, 
	    					
	    					{
	    						field : 'Running_Rate',
	    						title : '基台运转率',
	    						width : 100
	    					},
	    					
	    					{
	    						field : 'Real_Running_Time',
	    						title : '真实运行时间',
	    						width : 150
	    					},
	    					
	    					{
	    						field : 'Total_Stop_Time',
	    						title : '停机时间',
	    						width : 150
	    					},
	    					
	    					{
	    						field : 'qty',
	    						title : '单板数',
	    						width : 50
	    					},
	    					{
	    						field : 'broad_qty',
	    						title : '连扳数',
	    						width : 50
	    					},
	    				
	    					
	    					 {
	    						field : 'Total_Pickup_Count',
	    						title : '总吸着',
	    						width : 70
	    					}, 
	    					{
	    						field : 'Total_Error_Count',
	    						title : '总失误',
	    						width : 70
	    					}, 

	    					{
	    						field : 'Spoilage_Rate',
	    						title : '损坏率',
	    						width : 70
	    					}
	    					 ] ],
	    					 
	    					 onLoadSuccess:function(data){
	    						  var  rows=data.rows;//全部的数组
	    						  x=new  Array();
		    			    	  series_1=new Array();
		    			    	  for(var i=0;i<rows.length;i++){
			    			    		 x[i]= rows[i].Machine+"-"+rows[i].Stage;
			    			    		//series_1[i]=rows[i].Total_Stop_Time.substring(2, 4);
			    			    		 series_1[i]=Number(rows[i].Total_Stop_Time.substring(2, 4));
			    			      }
		    			    	  $('#container').highcharts({
		    			         	   chart: {  
		    			                     type: 'column',  
		    			                     style: {  
		    			                         fontSize: '13px',  
		    			                         fontWeight: 'bold',  
		    			                         color: 'blue'  
		    			                     }  
		    			                 }, 
		    			                 credits: { enabled:false }, 
		    			                 title: {
		    				    	              text: '这半小时内所有机台停止时间对比'
		    			 	           },
		    			 	           xAxis: {
		    			 	              categories: x
		    			 	           },
		    			 	           yAxis: {
		    			 	              title: {
		    			 	                 text: '停线时间(分)'
		    			 	              }
		    			 	           },
		    			 	           series: [
		    			 	           
		    			 	           {
		    			 	              name: '基台',
		    			 	              data: series_1
		    			 	           }
		    			 	           
		    			 	          ]
		    			         });
	    					 }
					
	     });
	     //先简单默认12个序列集
	     var  x=null;
	     var series_1=null;
	    
	     
	     //图表实例化
	      $('#container').highcharts({
         	   chart: {  
                     type: 'column',  
                     style: {  
                         fontSize: '13px',  
                         fontWeight: 'bold',  
                         color: 'blue'  
                     }  
                 }, 
                 credits: { enabled:false }, 
                 title: {
	    	              text: '这半小时内所有机台停止时间对比'
 	           },
 	           xAxis: {
 	              categories: x
 	           },
 	           yAxis: {
 	              title: {
 	                 text: '停线时间'
 	              }
 	           },
 	           series: [
 	                   {
 	      	              name: '基台',
 	      	              data: series_1
 	      	           },
 	      	       ]
         	
         	
         });
	     
	     
	     
	     
	     window.setInterval(
	    		 function(){
	    			 $("#dg").datagrid("reload");
	    		 },	
	             1000*60*10
	      );
	     
	     </script>
	   
  </body>
</html>

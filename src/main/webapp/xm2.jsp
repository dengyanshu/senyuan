<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include  file="/common/head.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
      <link  rel="stylesheet"   type="text/css"  href="${path}/css/mesblue.css">
             <link   rel="stylesheet" type="text/css" href="${path}/bootstrap/bootstrap.min.css">
	  <link   rel="stylesheet" type="text/css" href="${path}/bootstrap/bootstrap-theme.min.css">
	  <script type="text/javascript" src="${path}/bootstrap/bootstrap.min.js"></script>
  </head>
  
  <body>
         <div class="yanshu-panel yanshu-fl yanshu-bg-blue">
         <div class="yanshu-notice">
                     <div  class="yanshu-notice-voice">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                     <span class="label label-danger"  id="time">贴片机今日运行情况</span>
         </div>
          <div  class="yanshu-content2" >
             <div id="dg"></div>
          </div>
		</div>
      </div>

      <script type="text/javascript">
	     $("#dg").datagrid({
	    	    url:"${path}/report/getXiaomiline.action",
		    	 nowrapL:true,
				 striped:true,
				 fitColumns:true,
		    	 pagination:true,
		    	 pageNumber:1,
		    	 pageSize:20,
		    	 pageList:[20,25,30,40,50],
		    	 rowStyler: function(index,row){
						
						if (row.status=="抛料"){
							return 'background-color: #8E2323;color:fff;'; //#cc9933 brown   // #2cfd5d 浅绿色；   //#157fcc #87c6eb浅蓝色  //#FFA500  浅黄色  ；
						}
						else{
							return 'background-color:#7ABE5A;color:black;'; 
						}
					},
					
					
					
	    		  columns : [[
	    					{
	    						field : 'status',
	    						title : '状态',
	    						width : 40
	    					},
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
	    						field : 't',
	    						title : '机台',
	    						width : 40
	    					}, 
	    					
	    					{
	    						field : 'slotname',
	    						title : '槽位',
	    						width : 100
	    					},
	    					
	    					{
	    						field : 'productname',
	    						title : '物料',
	    						width : 200
	    					},
	    					
	    					
	    					
	    					{
	    						field : 'qty',
	    						title : '单板',
	    						width : 50
	    					},
	    					
	    					{
	    						field : 'broad_qty',
	    						title : '连板',
	    						width : 50
	    					},
	    					/*
	    					{
	    						field : 'library',
	    						title : '站位表',
	    						width : 80
	    					},
	    					*/
	    					
	    					
	    					 {
	    						field : 'Pickup_Count',
	    						title : '总吸着',
	    						width : 70
	    					}, 
	    					{
	    						field : 'Error_Count',
	    						title : '总失误',
	    						width : 70
	    					}, 

	    					{
	    						field : 'spoilage_Rate',
	    						title : '损坏率',
	    						width : 70
	    					}, 
	    					{
	    						field : 'error_Rate',
	    						title : '错误率',
	    						width : 70
	    					},
	    					
	    					
	    					
	    					{
	    						field : 'pickup_Error',
	    						title : '吸着失误',
	    						width :70
	    					},
	    					{
	    						field : 'recognition_Error',
	    						title : '识别失误',
	    						width :70
	    					},
	    					{
	    						field : 'thick_Error',
	    						title : '厚度失误',
	    						width : 70
	    					},
	    					{
	    						field : 'placement_Error',
	    						title : '贴装失误',
	    						width : 70
	    					},
	    					{
	    						field : 'part_Drop_Error',
	    						title : '落下失误',
	    						width : 70
	    					}
	    				
	    					,
	    					{
	    						field : 'transfer_unit_parts_drop_error_Count',
	    						title : '写元件落下错误',
	    						width : 160
	    					}
	    					
	    					 ] ]
	     });
	     
	     
	     window.setInterval(
	    		 function(){
	    			 $("#dg").datagrid("reload");
	             },
	             1000*60
	      );
	     
	     </script>
	   
  </body>
</html>

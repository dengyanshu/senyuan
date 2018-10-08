<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include  file="/common/head.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="${path}/css/mesblue.css">
	<script type="text/javascript" src="${path}/js/highcharts.js"></script>
  </head>
  
  <body >
      <div class="yanshu-panel yanshu-fl yanshu-bg-blue">
         <div class="yanshu-notice">
                    <form id="ff">
                                                                             车间： <select id="site" class="easyui-combobox" name="site" style="width:150px;" data-options="required:true,editable:false">   
							    <option value="1B-3FA">1B-3FA</option>   
							    <option value="1B-3FB">1B-3FB</option>   
							    <option value="1B-4FA">1B-4FA</option>   
							    <option value="1B-4FB">1B-4FB</option>   
							    <option value="1B-6FA">1B-6FA</option>   
							    <option value="1B-6FB">1B-6FB</option>   
							</select> 
                                                                             线体：<input id="workcenter"   style="width:150px;" class="easyui-combobox" name="workcenter"   
                         data-options="valueField:'WorkcenterId',textField:'WorkcenterName'" /> 
				                       日期起：  <input id="adate" type="text"  style="width:150px;" class="easyui-datebox" name="adate" required="required" ></input>  
				                        日期起：  <input id="bdate" type="text" style="width:150px;" class="easyui-datebox" name="bdate" required="required"></input>  
				                      班次： <input id="banci" type="text" style="width:150px;" class="easyui-combobox" name="banci" required="required" data-options="
				                      valueField:'value',textField:'label',
				        data: [{
							label: '白班',
							value: '1'
						},{
							label: '晚班',
							value: '2'
						}]
				        
				        "></input>  
        
                      <a id="btn" href="#" class="easyui-linkbutton" style="width: 200px;"   onclick="javascript:select()" data-options="iconCls:'icon-remove'">--查询--</a>  
     
               </form> 
         </div>
          <div  class="yanshu-content2" >
             <div id="dg" style="height:500px;"></div>
              <div id="container"></div>
          </div>
		</div>
      </div>

      <script type="text/javascript">
	     $("#dg").datagrid({
	    	   // url:"${path}/report/smtline_third.action",
		    	 nowrapL:true,
				 striped:true,
				 fitColumns:true,
		    	 pagination:true,
		    	 columns : [[
		    					{title : '日期',field : 'fDate',width : 90,styler:rendererFather,},
		    					{title : '线别',field : 'WorkcenterName',width : 240,styler:rendererFather},
		    					{title : '机型',field : 'ProductDescription',width : 290,styler:rendererFather}, 
		    					{title : '标产',field : 'StandardProductivity',width : 60,styler:rendererFather},
		    					{title : '8:00',field : '1',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '9:00',field : '2',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '10:00',field : '3',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon}, 
		    					{title : '11:00',field : '4',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '12:00',field : '5',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '13:00',field : '6',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '14:00',field : '7',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '15:00',field : '8',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '16:00',field : '9',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '17:00',field : '10',width: 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '18:00',field : '11',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '19:00',field : '12',width : 50,align:'center',formatter:undefinedtozero,styler:rendererSon},
		    					{title : '当班累计',field : '累计',width : 150,align:'center',styler:rendererFather}
		    			 ] ]
	     });
	     var  x=null;
	     var series_1=null;
	     var series_2=null;
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
	    	              text: '各线体实产对比图'
 	           },
 	           xAxis: {
 	              categories: x
 	           },
 	           yAxis: {
 	              title: {
 	                 text: '数量QTY'
 	              }
 	           },
 	           series: [
 	           /*
 	           {
 	              name: '标产',
 	              data: series_1
 	           }
 	           , */
 	           {
 	              name: '实产',
 	              data: series_2
 	           }]
         	
         	
         });
	     
	     
	    
	     $(function(){
	    	  $("#site").combobox("setValue","");
	 	      $("#site").combobox({
	 	    	 onSelect:function(record){
	 	    		 //车间选择 触发线体
	 	    		 var  site=record.value;
	 	    		 var  url="${path}/report/zbsite_getworkcenter.action?site="+site;
	 	    		 $("#workcenter").combobox("reload",url);
	 	    	 }
	 	     });
	 	      
	    	  $("#banci").combobox({
	 	    	 onSelect:function(record){
	 	    		 //车间选择 触发线体
	 	    		 var  banci=record.value;
	 	    		 if(banci=="1"){
	 	    			  $('#dg').datagrid('getColumnOption','1').title= '8:00';
	                       $('#dg').datagrid('getColumnOption','2').title= '9:00';
	                       $('#dg').datagrid('getColumnOption','3').title= '10:00';
	                       $('#dg').datagrid('getColumnOption','4').title= '11:00';
	                       $('#dg').datagrid('getColumnOption','5').title= '12:00';
	                       $('#dg').datagrid('getColumnOption','6').title= '13:00';
	                       $('#dg').datagrid('getColumnOption','7').title= '14:00';
	                       $('#dg').datagrid('getColumnOption','8').title= '15:00';
	                       $('#dg').datagrid('getColumnOption','9').title= '16:00';
	                       $('#dg').datagrid('getColumnOption','10').title= '17:00';
	                       $('#dg').datagrid('getColumnOption','11').title= '18:00';
	                       $('#dg').datagrid('getColumnOption','12').title= '19:00';
	                       $('#dg').datagrid();
	                   }
	                   else if(banci=='2'){
	                         $('#dg').datagrid('getColumnOption','1').title= '20:00';
	                         $('#dg').datagrid('getColumnOption','2').title= '21:00';
	                         $('#dg').datagrid('getColumnOption','3').title= '22:00';
	                         $('#dg').datagrid('getColumnOption','4').title= '23:00';
	                         $('#dg').datagrid('getColumnOption','5').title= '24:00';
	                         $('#dg').datagrid('getColumnOption','6').title= '1:00';
	                         $('#dg').datagrid('getColumnOption','7').title= '2:00';
	                         $('#dg').datagrid('getColumnOption','8').title= '3:00';
	                         $('#dg').datagrid('getColumnOption','9').title= '4:00';
	                         $('#dg').datagrid('getColumnOption','10').title= '5:00';
	                         $('#dg').datagrid('getColumnOption','11').title= '6:00';
	                         $('#dg').datagrid('getColumnOption','12').title= '7:00';
	                         $('#dg').datagrid();
	                   }
	 	    	 },
	 	    	 onLoadSuccess:function(){
	 	    		  var  hours=new Date().getHours();
	 		    	  if(hours>=8 &&hours<20){
	 					  $("#banci").combobox("select","1");
	 				  }
	 				  else
	 					  $("#banci").combobox("select","2");
	 	    	 }
	 	     });
	 	     
	    	  
	    	  $("#adate").datebox("setValue",
	    			  new  Date().getFullYear()+"-"+(new  Date().getMonth()+1)+"-"+(new  Date().getDay()+7)
	    	  );
	    	  
	    	  $("#bdate").datebox("setValue",
	    			  new  Date().getFullYear()+"-"+(new  Date().getMonth()+1)+"-"+(new  Date().getDay()+7)
		    	  );
	    	  
	    	  $("#ff").form("disableValidation");
	    	 
	     });
	     
	   
	     
	     function  select(){
	    	 $("#ff").form("enableValidation");
	    	 if($("#ff").form("validate")){
	    		 //验证通过   提交表单
	    		 $('#ff').form('submit', {    
	    			    url:"${path}/report/zbsite_getresult.action",    
	    			    success:function(data){    
	    			    	var data=JSON.parse(data);
	    			    	 $("#dg").datagrid("loadData",data);
	    			    	 
	    			    	 var rows=data.rows;
	    			    	 x=new  Array();
    			    		 series_2=new Array();
	    			    	 for(var i=0;i<rows.length;i++){
	    			    		 x[i]= rows[i].WorkcenterName;
	    			    		 series_2[i]=rows[i].累计;
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
	    				    	              text: '各线体实产对比图'
	    			 	           },
	    			 	           xAxis: {
	    			 	              categories: x
	    			 	           },
	    			 	           yAxis: {
	    			 	              title: {
	    			 	                 text: '数量QTY'
	    			 	              }
	    			 	           },
	    			 	           series: [
	    			 	           /*
	    			 	           {
	    			 	              name: '标产',
	    			 	              data: series_1
	    			 	           }
	    			 	           , */
	    			 	           {
	    			 	              name: '实产',
	    			 	              data: series_2
	    			 	           }]
	    			         });
	    			    }    
	    	    }); 
	    	 }
	     }
	     
	     
	   
	     
	     
	     function rendererFather(v,m) {
				return 'background-color:#cc9933;color:white;';
			}
		  function rendererSon(value, row,index) {
	      	var stand = row.StandardProductivity;
	      	stand=stand*1.0;
			if (value>=stand*0.98){
				return 'background-color:#2cfd5d;color:black;';
			}
			else if (value>=stand*0.9&value<stand*0.98){
				return 'background-color:#FFA500;color:black;';
			}
			else{
				return 'background-color:#8E2323;color:black;';
			}
		  }
		  
		  function undefinedtozero(value, row,index) {
			    if(value==undefined)
		      		value=0;
				return  value;
		  }
		  
	     
      </script>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include  file="/common/head.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<link style="text/css" rel="stylesheet"  href="${path}/css/bianqian.css"/>
	<link href="/zowee/css/myloading.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/zowee/js/myloading.js"></script>
  </head>
  
  <body id="loading">
      <script type="text/javascript">
	           //ajax 请求 获取所有的json信息 然后递归出来
	        $.ajax({
			   type: "POST",
			   url: "${path}/report/getline.action",
			   
			   beforeSend: function () {
	    			 jQuery('#loading').showLoading();
  			   },
  			   complete: function () {
  				  jQuery('#loading').hideLoading();
  			   },
			   
			   success: function(data){
				      var  rows=data;
	    			  
	    			  var str="";
	    			  for(var i=0;i<rows.length;i++){
	    				    var  Workcenterid=rows[i].Workcenterid;
	    				    var  WorkcenterName=rows[i].WorkcenterName;
	    				    var  MoName=rows[i].MoName;
	    				    var  hasNext=rows[i].hasNext;
	    				    var  isAlert=rows[i].isAlert;
	    				    
	    				    var  div_class="";
	    				    var  monum="";
	    				    if(isAlert=="1")
	    				    	div_class="orangenotes";
 				    	    else
 				    		    div_class="greennotes";
	    				    if(hasNext=="1")
	    				    	monum="多工单";
 				    	    else
 				    		   monum="单工单";
	    				    
	    				   str+="<div id='archives' class='"+div_class+"'><h3  style='margin: 0;background-color:#D4D4D4'>"+monum+"</h3>"+
	    					"<h2 class='heading' style='margin: 0'>"+WorkcenterName+"</h2>"+
	    					"<div class='content'><ul><li class='first'>"+MoName+"</li><li style='display: none;'>"+Workcenterid+"</li></ul></div></div>";
	    			  }
	    			  $("body").append(str);
			   }
			});
	        
	        //动态添加元素  直接使用原始的jquery.click(function(){})  有问题 
	        //处理点击事件    获取mo 和workcenterid moname
	        $("body").on("click","#archives",function(){
	        	//var moname=$("#archives li:first").text();
	        	//var workcenterid=$("#archives li:last").text();
	        	//this  get  from the  only first
	        	var moname=$(this).find("li").first().text();
	        	var workcenterid=$(this).find("li").last().text();
	        	//获取主界面的tabs添加tab  需要进行判断  如果不存在添加 存在需要根据点击的进行内容更新
	        	var  url="${path}/report/linetomo.action?moname="+moname+"&workcenterid="+workcenterid;
	        	
	        	if(parent.$("#tab").tabs("exists","线体物料第二层")){
	        		// need update
	        		parent.$("#tab").tabs("select","线体物料第二层");
	        		var  tab=parent.$("#tab").tabs("getSelected");
	        		parent.$('#tab').tabs('update', {
	        			tab: tab,
	        			options: {
	        				content: "<iframe src="+url+" name='线体物料第二层' width=100% height=100% style='border:0px;'></iframe>"
	        			}
	        		});

	        	}
	        	else{
		        	parent.$("#tab").tabs("add",{
		        		title:'线体物料第二层',    
	        		    content:"<iframe src="+url+" name='线体物料第二层' width=100% height=100% style='border:0px;'></iframe>",    
	        		    closable:true,    
		        	});
	        	}
	        })
	      
      </script>
  </body>
</html>

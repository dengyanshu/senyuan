Ext.define('MyApp.view.usergrid', { 
	   extend:"Ext.form.Panel",
	   alias:"widget.userlist",
	    title: 'Simple Form',
	    bodyPadding: 5,
	    width: 550,

	    // 将会通过 AJAX 请求提交到此URL
	    url: 'save-form.php',

	    // 表单域 Fields 将被竖直排列, 占满整个宽度
	    /*layout: 'anchor',
	    defaults: {
	        anchor: '100%'
	    },*/

	    // The fields
	    //default,
	    items: [{
	        fieldLabel: 'Last Name',
	        name: 'last',
	        allowBlank: false
	        ,xtype: 'textfield'
	    },
	    {
	    	layout:'column',
	    	items:[
	    	       {
	    	    	   layout:'form',
	    	    	   columnWidth:.2,
	    	    	   items:[
                         {name:'fieldName2',xtype: 'textfield' }
	    	    	   ]
	    	       },
	    	       {
	    	    	   layout:'form',
	    	    	   columnWidth:.8,
	    	    	   items:[
	                          {name:'fieldName2',xtype: 'textfield' }
	 	    	    	   ]
	    	       }
	    	       
	    	]
	    	
	    },
	    
	    
        {xtype:'label',text:'生产厂家',tdAttrs:{style:"width:80px;"},cellCls: 'thead' },{name:'fieldName2',xtype: 'textfield' },
        {xtype:'label',text:'所属单位',tdAttrs:{style:"width:80px;"},cellCls: 'thead' },{name:'fieldName3',xtype: 'textfield'},
	    
	    ],

	   
	    
	});
	   







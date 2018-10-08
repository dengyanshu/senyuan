	Ext.QuickTips.init();
	Ext.Loader.setConfig({
		enabled:true
	});
	Ext.application({
	    name: 'MyApp',
	    appFolder : "MyApp",
	    //autoCreateViewport: true,
	    launch: function() {
	    	Ext.create('Ext.container.Viewport', {
	            items: {
	                xtype:'userlist'
	            }
	        });
	    },
	    controllers: ['MyApp.controller.users']
	 });
	
	

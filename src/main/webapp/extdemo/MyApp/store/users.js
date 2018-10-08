Ext.define('MyApp.store.users', {
	  extend:"Ext.data.Store",
	 model: 'MyApp.model.user',
     proxy: {
         type: 'ajax',
         url: '../json/users.json',
         reader: {
             type: 'json',
         }
     },
     autoLoad: true
});


////User数据集合
//Ext.define('AM.store.Users', {
//	extend: 'Ext.data.Store',
//	model: 'AM.model.User',
//	storeId: 's_user',
//	proxy:{
//	    type:'ajax',
//	    url:'/extjs/extjs!getUserList.action',
//	    reader: {
//	        type: 'json',
//	        root: 'topics'
//	    },writer:{
//			type:'json'
//		}
//	},
//	autoLoad: true //很关键
//});
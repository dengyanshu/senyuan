Ext.define('MyApp.controller.users', {
    extend: 'Ext.app.Controller',
    models: ['MyApp.model.user'],
    stores: ['MyApp.store.users'],
    views:['MyApp.view.usergrid'],
    init: function() {
    	this.control({
    		
    		
    	});
    }
});
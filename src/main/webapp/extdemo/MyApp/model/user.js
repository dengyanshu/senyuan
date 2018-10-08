Ext.define('MyApp.model.user', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'name',  type: 'string'},
        {name: 'age',   type: 'int'},
        {name: 'phone', type: 'string'},
    ]
});


//Ext.define('AM.model.User', {
//    extend: 'Ext.data.Model',
//	fields: [
//		{name: 'name',  type: 'string',sortable : true},
//	    {name: 'age',   type: 'int',sortable : true},
//	    {name: 'email',   type: 'string',sortable : true}
//	]
//});
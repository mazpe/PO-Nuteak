Ext.onReady(function()
{
	var gridForm = new Ext.form.BasicForm(
		Ext.get("general-form"),
		{}
	);
	 
    var store = new Ext.data.Store(
    {
        proxy: new Ext.data.HttpProxy(
        {
            url: ""
        }),
        reader: new Ext.data.JsonReader(
        {
            root: 'data',
            id: 'id',
            totalProperty: 'totalCount'
        }, [
		{
            name: 'Id'
        },
        {
            name: 'Family'
        }, 
        {
            name: 'Code'
        }, 
		{
			name:'Description'
		},
        {
            name: 'Options'
        },
        {
            name: 'Quantity',
            type: 'int'
        }, 
        {
            name: 'Price',
            type: 'Float'
        }, 
        {
            name: 'TotalPrice',
            type: 'float'
        },
	    {
		    name:'Weight',
		    type:'float'		
	    },
	{
		name:'TotalWeight',
		type:'float'
	},
        {
            name: 'Sf',
            type: 'float'
        },
	{
		name:'Sf',
		type:'float'
	},
        {
            name: 'Units',
            type: 'float'
        }
        ]),
        remoteSort: false
    });
    
    store.setDefaultSort('Description', 'desc');
    
    var dsProduct = new Ext.data.JsonStore(
    {
        proxy: new Ext.data.HttpProxy(
         {
         url: "/client/items/list",
         headers:
         {
         'Content-Type': 'application/json;charset=utf-8'
         }
         }),
        root: 'data',
        id: 'Family',
        fields: [
        {
            name: 'Family'
        }, 
        {
            name: 'Description'
        }],
        remoteSort: true,
        sortInfo: 
        {
            field: 'Description',
            direction: 'ASC'
        }
    });
    
    dsProduct.load();
    
    var product = new Ext.form.ComboBox(
    {
        store: dsProduct,        
        editable: false,
        mode: 'local',
        allowBlank: false,
        triggerAction: 'all',
        displayField: 'Description',
        valueField: 'Family'
    });
    
    var dsCaulking = new Ext.data.JsonStore(
    {
        proxy: new Ext.data.HttpProxy(
         {
         url:'/client/items',
         method:'post',
         headers:
         {
         'Content-Type': 'application/json;charset=utf-8'
         }
         }),
        root: 'data',
        idProperty: 'Id',
        fields: [
		{
            name: 'Id'
        },
		{
            name: 'Family'
        },
        {
            name: 'Code'
        }, 
        {
            name: 'Options'
        }, 
        {
            name: 'Price'
        },
	    {
		    name:'Weight',
		    type:'float'
	    },
        {
            name:'Sf',
            type:'float'
        },
        {
            name:'Units',
            type:'float'
        }

        ],	
        remoteSort: true,
        sortInfo: 
        {
            field: 'Options',
            direction: 'ASC'
        }
    });
    
    dsCaulking.load();
    
    var caulking = new Ext.form.ComboBox(
    {
        store: dsCaulking,
        editable: false,
        mode: 'local',
        allowBlank: false,
        triggerAction: 'all',
        displayField: 'Options',
        valueField: 'Code'
    });
    
    caulking.on('expand', function()
    {
        var value = product.getValue();
        
        dsCaulking.clearFilter(true);
        
        dsCaulking.filter('Family', value, false, true, true);
    });
    
    product.on('select', function()
    {
        
    });
    
    var cm = new Ext.grid.ColumnModel([
    {
        header: "Code",
        dataIndex: 'Code',
        width: 140,
        sortable: true
    }, 
    {
        header: "Description",
        dataIndex: 'Description',
        width: 275,
        sortable: true,
        editor: product,
        renderer: function(v, p, r)
        {
            var record = null;
            
            for (var i = 0; i < product.store.getCount(); i++) 
            {
                record = product.store.getAt(i);
                
                if (v == record.data.Family) 
                {
					r.set('Family', record.data.Family);
                    r.set('Description', record.data.Description);
                    
                    return record.data.Description;
                }
            }
            
            return v;
        }
    }, 
    {
        header: "Options",
        dataIndex: 'Code',
        width: 80,
        sortable: true,
        editor: caulking,
        renderer: function(v, p, r)
        {
            var record = null;
            
            for (var i = 0; i < dsCaulking.getCount(); i++) 
            {
                record = dsCaulking.getAt(i);
                
                if (v == record.data.Code) 
                {
		    r.set('Id', record.data.Id);
		    r.set('Code', record.data.Code);                    
                    r.set('Options', record.data.Options);                    
                    r.set('Price', parseFloat(record.data.Price));
                    r.set('Weight', record.data.Weight);
                    r.set('Sf', record.data.Sf);
                    r.set('Units', record.data.Units);

                    return record.data.Options;
                }
            }
            
            return v;
        }
    }, 
    {
        header: "Qty",
        dataIndex: 'Quantity',
        width: 30,
        align: 'right',
        sortable: true,
        summaryType: 'sum',
        editor: new Ext.form.NumberField(
        {
            allowNegative: true
        })
    }, 
    {
        header: "Unit Price",
        dataIndex: 'Price',
        width: 80,
        align: 'right',        
        renderer: 'usMoney',
        sortable: true
    }, 
    {
        header: "Total Price",
        dataIndex: 'TotalPrice',
        width: 100,
        align: 'right',
        summaryType: 'sum',
        sortable: true,
        renderer: function(v, p, r){
			if (parseInt(r.data.Quantity) >= 0 && parseInt(r.data.Price) >= 0)
			{
				r.set('TotalPrice', r.data.Quantity * r.data.Price);
				return Ext.util.Format.usMoney(r.data.Quantity * r.data.Price);
			} 
			else 
				return 0;
		},
		summaryRenderer:function(v, p, r)
		{
			return Ext.util.Format.usMoney(v);			
		}
    },
{
	header:'Weight',
	dataIndex:'TotalWeight',
	width:70,
	align:'right',
	summaryType:'sum',
	sortable:true,
	renderer:function(v, p, r)
	{
		if(r.data.Quantity > 0)
		{
			v = r.data.Quantity * r.data.Weight;
		
			r.set('TotalWeight', v);
		}

		return v;
	},
	summaryRenderer:function(v)
	{
		if(parseFloat(v) >= 0)
			return v;		
		else
			return 0;
	}
},
{
    header:'SQF',
    dataIndex:'TotalSf',
    width:50,
    align:'right',
    summaryType:'sum',
    sortable:true,
    renderer:function(v, p, r)
    {
	if(r.data.Quantity > 0)
	{
		v = r.data.Quantity * r.data.Sf;
		r.set('TotalSf', v);
	}

        return v;
    },
	summaryRenderer:function(v)
	{
		if(parseFloat(v) >=  0)
			return v;
		else
			return 0;
	}
},
{
    header:'Units',
    dataIndex:'Units',
    width:75,
    align:'right',
    summaryType:'sum',
    sortable:true,
    renderer:function(v, p, r)
    {
        return r.data.Quantity * r.data.Units;
    }
}]);
    
    var summary = new Ext.ux.grid.GridSummary();
    
    var grid = new Ext.grid.EditorGridPanel(
    {
        sm: new Ext.grid.RowSelectionModel(
        {
            singleSelect: false
        }),
        width: 900,
        autoHeight: true,
        minHeight: 100,
        store: store,
        trackMouseOver: false,
        disableSelection: true,
        loadMask: true,
        plugins: summary,
        clicksToEdit: 1,
        cm: cm,
        viewConfig: 
        {
            forceFit: true,
            enableRowBody: true,
            showPreview: false,
            getRowClass: function(record, rowIndex, p, store)
            {
                if (this.showPreview) 
                {
                    p.body = '<p>' + 'Aditional Information Here' + '</p>';
                    return 'x-grid3-row-expanded';
                }
                return 'x-grid3-row-collapsed';
            }
        },
        bbar: [
        {
            text: 'Add new row',
            handler: addRow,
		cls:'x-btn-over'
        },'-' ,
        {
            text: 'Delete Selected Row',
		cls:'x-btn-over',
            handler: deleteSelection
        },'-' ,
	{
		text:'Submit',
		cls:'x-btn-text x-btn-over',
			handler:save	
		}]
    });
    
    grid.render('grid');
    
    addRow();
    
    function addRow()
    {
        store.add(new Ext.data.Record(
        {
			insert:true,
            Id: 0,
			Family: '',
            Code: '',
            Description: null,
            Options: null,
            Quantity: 0,
            Price: 0,
            TotalPrice: 0,
	        Weight:0,
		TotalWeight:0,
            Sf: 0,
		TotalSf:0,
            Units: 0
            
        }));
    }
    
    function deleteSelection()
    {
        var records = grid.getSelectionModel().getSelections();
        
        if (records.length > 0) 
            store.remove([records]);
        else 
            alert('Not implemented.');
    }
    
    function save()
    {
        var jsonData = "", poNumber = 0;
	poNumber = parseInt(document.getElementById('po-number').value);

	if(!(poNumber > 0))
	{
		alert('Please enter a PO Number.');
		return;
	}

        for (var i = 0; i < store.getCount(); i++) 
        {
            record = store.getAt(i);
           	   
            if (record.data.insert || record.dirty)
		{
		if(record.data.Quantity > 0)
	                jsonData += Ext.util.JSON.encode(record.data) + ",";
		else
		{
			alert('Please enter a quantity greater than 0 for ' + record.data.Description + '.');
			return;
		}
	}
        }
        
        if (jsonData.length > 0) 
        {
            jsonData = "[" + jsonData.substring(0, jsonData.length - 1) + "]";
            
            gridForm.submit(
            {
                waitMsg: 'Submitting PO, please wait...',
                url: "/client/purchaseorder/save",
                params: 
                {
                    data: jsonData,
                    task: 'save'
                },
                success: function(form, action)
                {
                    loadDataSource();
                    alert('done');
                },
                failure: function(form, action)
                {
                    window.location="/client/purchaseorder/submitted/"+ poNumber;

                }
            });
        }
        else 
            alert('No changes to submit.');
    }
});

/**
 * @author gbritton
 */
Ext.onReady(function()
{
	var gridForm = new Ext.form.BasicForm(
		Ext.get("general-form"),
		{}
	);
	 
    // create the Data Store
    var store = new Ext.data.Store(
    {
        proxy: new Ext.data.HttpProxy(
        {
            url: ""
        }),
        reader: new Ext.data.JsonReader(
        {
            root: 'data',
            id: 'Code',
            totalProperty: 'totalCount'
        }, [
        {
            name: 'productId'
        }, 
        {
            name: 'product'
        }, 
        {
            name: 'caulkingId'
        }, 
        {
            name: 'caulking'
        }, 
        {
            name: 'quantity',
            type: 'int'
        }, 
        {
            name: 'price',
            type: 'float'
        }, 
        {
            name: 'totalprice',
            type: 'float'
        }]),
        remoteSort: false
    });
    
    store.setDefaultSort('description', 'desc');
    
    /*create the Data Store*/
    var dsProduct = new Ext.data.JsonStore(
    {
        /*proxy: new Ext.data.ScriptTagProxy(
        {
            url: 'http://gbrnd.com:3004/client/items/list'
        }),*/
        proxy: new Ext.data.HttpProxy(
         {
         url: "http://gbrnd.com:3004/client/items/list",
         headers:
         {
         'Content-Type': 'application/json;charset=utf-8'
         }
         }),
        root: 'data',
        //totalProperty: 'd.totalCount',
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
        /*store:new Ext.data.ArrayStore({
         fields: ['ProductId', 'Description'],
         data : [['NF-45SBP','**Flexible Single Plank 45mm (1.8")'],
         ['NF-45SWM','Flexible Margin 45mm (1.8")'],
         ['NF-45SBM','Flexible Margin 45mm (1.8")'],
         ['NF-2x45DBP','Flexible Double Plank 2 x45mm (2 x1.8")'],
         ['NF-45SWP','**Flexible Single Plank 45mm (1.8")'],
         ['NF-60SBP','**Flexible Plank 60mm (2.4")']] // from states.js
         }),*/
        editable: false,
        mode: 'local',
        allowBlank: false,
        triggerAction: 'all',
        displayField: 'Description',
        valueField: 'Code'
    });
    
    /*create the Data Store*/
    var dsCaulking = new Ext.data.JsonStore(
    {
        /*proxy: new Ext.data.ScriptTagProxy(
        {
            url: 'http://gbrnd.com:3004/client/items'
        }),*/
        proxy: new Ext.data.HttpProxy(
         {
         url:'http://gbrnd.com:3004/client/items',
         method:'post',
         headers:
         {
         'Content-Type': 'application/json;charset=utf-8'
         }
         }),
        root: 'data',
        //totalProperty: '',
        //idProperty: 'Value',
        fields: [
        {
            name: 'Code'
        }, 
        {
            name: 'Value'
        }, 
        {
            name: 'Price'
        }, 
        {
            name: 'Text'
        }, 
        {
            name: 'When'
        }],
        remoteSort: true,
        sortInfo: 
        {
            field: 'Text',
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
        displayField: 'Text',
        valueField: 'Value'
    });
    
    caulking.on('expand', function()
    {
        var value = product.getValue();
        
        dsCaulking.clearFilter(true);
        
        dsCaulking.filter('When', value, false, true, true);
    });
    
    product.on('select', function()
    {
        /*dsCaulking.load(
         {
         params:
         {
         productId: product.getValue()
         }
         });*/
    });
    
    var cm = new Ext.grid.ColumnModel([
    {
        header: "Code",
        dataIndex: 'productId',
        width: 70,
        //renderer: renderTopic,
        sortable: true
    }, 
    {
        header: "Description",
        dataIndex: 'product',
        width: 250,
        sortable: true,
        editor: product,
        renderer: function(v, p, r)
        {
            var record = null;
            
            for (var i = 0; i < product.store.getCount(); i++) 
            {
                record = product.store.getAt(i);
                
                if (v == record.data.Code) 
                {
                    r.set('productId', record.data.Code);
                    r.set('product', record.data.Description);
                    
                    return record.data.Description;
                }
            }
            
            return v;
        }
    }, 
    {
        header: "Caulking",
        dataIndex: 'caulkingId',
        width: 70,
        sortable: true,
        editor: caulking,
        renderer: function(v, p, r)
        {
            var record = null;
            
            for (var i = 0; i < dsCaulking.getCount(); i++) 
            {
                record = dsCaulking.getAt(i);
                
                if (v == record.data.Value) 
                {
                    r.set('caulkingId', record.data.Value);
                    r.set('caulking', record.data.Text);
                    
                    r.set('price', parseFloat(record.data.Price));
                    
                    return record.data.Text;
                }
            }
            
            return v;
        }
    }, 
    {
        header: "Quantity",
        dataIndex: 'quantity',
        width: 150,
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
        dataIndex: 'price',
        width: 100,
        align: 'right',        
        renderer: 'usMoney',
        sortable: true
    }, 
    {
        header: "Total Price",
        dataIndex: 'totalprice',
        width: 100,
        align: 'right',
        summaryType: 'sum',
        sortable: true,
        renderer: function(v, p, r)
        {
            if (parseInt(r.data.quantity) >= 0 && parseInt(r.data.price) >= 0) 
                return Ext.util.Format.usMoney(r.data.quantity * r.data.price);
            else 
                return 0;
        }
    }]);
    
    // pluggable renders
    /*function renderTopic(value, p, record){
     return String.format('<b><a href="http://extjs.com/forum/showthread.php?t={2}" target="_blank">{0}</a></b><a href="http://extjs.com/forum/forumdisplay.php?f={3}" target="_blank">{1} Forum</a>', value, record.data.forumtitle, record.id, record.data.forumid);
     }
     function renderLast(value, p, r){
     return String.format('{0}<br/>by {1}', value.dateFormat('M j, Y, g:i a'), r.data['lastposter']);
     }*/
    var summary = new Ext.ux.grid.GridSummary();
    
    var grid = new Ext.grid.EditorGridPanel(
    {
        sm: new Ext.grid.RowSelectionModel(
        {
            singleSelect: false
        }),
        width: 700,
        //height: 500,
        autoHeight: true,
        minHeight: 100,
        store: store,
        trackMouseOver: false,
        disableSelection: true,
        loadMask: true,
        plugins: summary,
        // grid columns
        cm: cm,
        // customize view config
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
        // paging bar on the bottom
        bbar: [
        {
            text: 'Add new row',
            handler: addRow
        }, 
        {
            text: 'Delete Selected Row',
            handler: deleteSelection
        }, 
        {
            pressed: false,
            enableToggle: true,
            text: 'Show Details',
            cls: 'x-btn-text-icon',
            toggleHandler: function(btn, pressed)
            {
                var view = grid.getView();
                view.showPreview = pressed;
                view.refresh();
            }
        },
		{
			text:'Save',
			handler:save	
		}]
    });
    
    // render it
    grid.render('grid');
    
    addRow();
    
    function addRow()
    {
        store.add(new Ext.data.Record(
        {
			insert:true,
            productId: null,
            product: '',
            caulkingId: null,
            calking: null,
            quantity: 0,
            price: 0,
            totalprice: 0
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
        var jsonData = "";
        
        for (var i = 0; i < store.getCount(); i++) 
        {
            record = store.getAt(i);
            
            if (record.data.insert || record.dirty) 
                jsonData += Ext.util.JSON.encode(record.data) + ",";
        }
        
        if (jsonData.length > 0) 
        {
            jsonData = "[" + jsonData.substring(0, jsonData.length - 1) + "]";
            
            gridForm.submit(
            {
                waitMsg: 'Saving changes, please wait...',
                url: "http://gbrnd.com:3004/client/purchaseorder/save",
                params: 
                {
                    data: jsonData,
                    task: 'save'
                },
                success: function(form, action)
                {
                    loadDataSource();
                },
                failure: function(form, action)
                {
                    alert('Error processing the action.');
                }
            });
        }
        else 
            alert('No changes to submit.');
    }
});

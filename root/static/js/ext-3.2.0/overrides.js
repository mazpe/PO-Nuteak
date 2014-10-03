Ext.ux.JsonHttpProxy = Ext.extend(Ext.data.HttpProxy, {
    doRequest: function(action, rs, params, reader, cb, scope, arg) {
        var o = {
            params: Ext.util.JSON.encode(params),
            //params : params || {},
            //jsonData: Ext.util.JSON.decode(params.data) || '{}',

            method: (this.api[action]) ? this.api[action]['method'] : undefined,
            request: {
                callback: cb,
                scope: scope,
                arg: arg
            },
            reader: reader,
            callback: this.createCallback(action, rs),
            scope: this
        };
        // Set the connection url.  If this.conn.url is not null here,
        // the user may have overridden the url during a beforeaction event-handler.
        // this.conn.url is nullified after each request.
        if (this.conn.url === null) {
            this.conn.url = this.buildUrl(action, rs);
        }
        else if (this.restful === true && rs instanceof Ext.data.Record && !rs.phantom) {
            this.conn.url += '/' + rs.id;
        }
        if (this.useAjax) {

            Ext.applyIf(o, this.conn);

            // If a currently running request is found for this action, abort it.
            if (this.activeRequest[action]) {
                // Disabled aborting activeRequest while implementing REST.  activeRequest[action] will have to become an array

                //Ext.Ajax.abort(this.activeRequest[action]);
            }
            this.activeRequest[action] = Ext.Ajax.request(o);
        } else {
            this.conn.request(o);
        }
        // request is sent, nullify the connection url in preparation for the next request
        this.conn.url = null;
    }
});

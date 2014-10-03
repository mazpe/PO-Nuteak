use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Nuteak' }
BEGIN { use_ok 'Nuteak::Controller::Clients::PurchaseOrder' }

ok( request('/clients/purchaseorder')->is_success, 'Request should succeed' );



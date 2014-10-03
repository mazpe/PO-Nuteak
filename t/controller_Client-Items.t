use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Nuteak' }
BEGIN { use_ok 'Nuteak::Controller::Client::Items' }

ok( request('/client/items')->is_success, 'Request should succeed' );



use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Nuteak' }
BEGIN { use_ok 'Nuteak::Controller::AJAX' }

ok( request('/ajax')->is_success, 'Request should succeed' );



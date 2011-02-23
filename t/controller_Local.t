use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SPPM::WorkShop';
use SPPM::WorkShop::Controller::Local;

ok( request('/local')->is_success, 'Request should succeed' );
done_testing();

use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SPPM::WorkShop';
use SPPM::WorkShop::Controller::Oauth;

ok( request('/oauth')->is_success, 'Request should succeed' );
done_testing();

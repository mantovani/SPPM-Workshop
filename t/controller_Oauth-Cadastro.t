use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SPPM::WorkShop';
use SPPM::WorkShop::Controller::Oauth::Cadastro;

ok( request('/oauth/cadastro')->is_success, 'Request should succeed' );
done_testing();

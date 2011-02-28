use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SPPM::WorkShop';
use SPPM::WorkShop::Controller::Inscricao;

ok( request('/inscricao')->is_success, 'Request should succeed' );
done_testing();

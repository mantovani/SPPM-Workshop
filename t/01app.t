#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use Catalyst::Test 'SPPM::WorkShop';

ok(my($res, $ctx) = ctx_request('/'), 'Request should default to 404');
is($ctx->action, 'default');
is($ctx->controller, $ctx->controller('Root'));

done_testing();

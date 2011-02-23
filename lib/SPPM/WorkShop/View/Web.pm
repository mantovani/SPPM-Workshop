package SPPM::WorkShop::View::Web;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die         => 1,
    INCLUDE_PATH       => [
        SPPM::WorkShop->path_to( 'root', 'templates', 'src' ),
        SPPM::WorkShop->path_to( 'root', 'templates', 'lib' ),
    ],
    WRAPPER => 'site/wrapper',

);

=head1 NAME

SPPM::WorkShop::View::Web - TT View for SPPM::WorkShop

=head1 DESCRIPTION

TT View for SPPM::WorkShop.

=head1 SEE ALSO

L<SPPM::WorkShop>

=head1 AUTHOR

Daniel Mantovani,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

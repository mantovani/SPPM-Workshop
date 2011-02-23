package SPPM::WorkShop::Controller::Local;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

SPPM::WorkShop::Controller::Local - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
}

sub dinamic : Chained('/base') : PathPart('') : Args(1) {
    my ( $self, $c, $tt ) = @_;
    my $path = $c->path_to( 'root', 'templates', 'src', 'local', "$tt.tt" );

    if ( -e $path ) {
        $c->stash( template => 'local/' . "$tt.tt" );
    }
    else {
        $c->res->redirect(
            $c->uri_for(
                $c->controller('Local')->action_for('dinamic'), 'main'
            )
        );
    }
}

=head1 AUTHOR

Daniel Mantovani,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

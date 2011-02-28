package SPPM::WorkShop::Controller::Inscricao;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }
use PagSeguro;
use PagSeguro::Item;

=head1 NAME

SPPM::WorkShop::Controller::Inscricao - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    $c->res->redirect(
        $c->uri_for( $c->controller('Inscricao')->action_for('main') ) );
}

sub base : Chained('/base') : PathPart('inscricao') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash(
        pagseguro => sub {
            my $pagseguro =
              PagSeguro->new( email_cobranca => 'thiago@aware.com.br', );

            $pagseguro->add_items(
                PagSeguro::Item->new(
                    id    => 10,
                    descr => 'Descricao do Produto',
                    quant => 1,
                    valor => 100,
                    frete => 0,
                    peso  => 0
                )
            );
            return $pagseguro->make_form;
        }
    );
}

sub main : Chained('base') : PathPart('main') : Args(0) {
    my ( $self, $c ) = @_;

}

sub cadastro_autenticacao : Chained('base') :
  PathPart('cadastro_autentificacao') : Args(0) {
    my ( $self, $c ) = @_;
}

sub autorizado : Chained('base') : PathPart('autorizado') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    if ( !$c->session->{twitter} ) {
        $c->res->redirect(
            $c->uri_for( $c->controller('Inscricao')->action_for('main') ) );
    }
}

sub cadastrar : Chained('autorizado') : PathPart('cadastrar') : Args(0) {
    my ( $self, $c ) = @_;
}

=head1 AUTHOR

Daniel Mantovani,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

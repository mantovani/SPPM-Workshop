package SPPM::WorkShop::Controller::Oauth;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

use Net::Twitter;

has 'twitter' => (
    is      => 'ro',
    isa     => 'Object',
    default => sub {
        Net::Twitter->new(
            traits          => [qw/API::REST OAuth/],
            consumer_key    => "Kc2ZSWG3xUoshXHjFL1mCA",
            consumer_secret => "",
        );
    },
    lazy => 1,
);

=head1 NAME

SPPM::WorkShop::Controller::Oauth - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    if ( !$c->session->{twitter} ) {
        $c->res->redirect(
            $c->uri_for( $c->controller('Oauth')->action_for('authorize') ) );
    }
    else {
        $c->res->redirect(
            $c->uri_for(
                $c->controller('Local')->action_for('dinamic'), 'main'
            )
        );
    }
}

sub base : Chained('/base') : PathPart('oauth') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub authorize : Chained('base') : PathPart('authorize') : Args(0) {
    my ( $self, $c ) = @_;

    my $nt  = $self->twitter;
    my $url = $nt->get_authorization_url(
        callback => $c->uri_for(
            $c->controller('Oauth')->action_for('twitter_auth_callback')
        )
    );

    $c->response->cookies->{oauth} = {
        value => {
            token        => $nt->request_token,
            token_secret => $nt->request_token_secret,
        },
    };

    $c->response->redirect($url);
}

sub twitter_auth_callback : Chained('base') : PathPart('twitter_auth_callback')
  : Args(0) {
    my ( $self, $c ) = @_;

    my %cookie   = $c->request->cookies->{oauth}->value;
    my $verifier = $c->req->params->{oauth_verifier};

    my $nt = $self->twitter;
    $nt->request_token( $cookie{token} );
    $nt->request_token_secret( $cookie{token_secret} );

    my ( $access_token, $access_token_secret, $user_id, $screen_name ) =
      $nt->request_access_token( verifier => $verifier );

# Save $access_token and $access_token_secret in the database associated with $c->user
    $c->session->{twitter} = {
        access_token        => $access_token,
        access_token_secret => $access_token_secret,
    };
    $c->res->redirect(
        $c->uri_for( $c->controller('Local')->action_for('main') ) );
}

=head1 AUTHOR

Daniel Mantovani,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

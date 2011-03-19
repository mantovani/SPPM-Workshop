package SPPM::WorkShop::Controller::Inscricao;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/base') : PathPart('inscricao') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash->{inscricoes} = $c->model('DB::Inscricao');
}

sub object :Chained('base') PathPart('') CaptureArgs(0) {
    my($self, $c) = @_;
    my $rs = $c->stash->{inscricoes};
    my $obj = $c->stash->{inscricao} = $rs->find_or_new($c->req->body_parameters);
}

sub inscricao : Chained('object') PathPart('') Args(0) {
    my($self, $c) = @_;
    my $params = $c->req->body_parameters;

    $c->stash->{mensagem}{nome} = q{*};
    $c->stash->{erro}{nome} = q{Favor fornecer o nome completo}
        unless $params->{nome};

    $c->stash->{mensagem}{email} = q{*};
    $c->stash->{erro}{email} = q{Favor fornecer um email}
        unless $params->{email};

    $c->stash->{mensagem}{celular} = q{*};
    $c->stash->{erro}{celular} = q{Favor fornecer o celular}
        unless $params->{celular};

    return if %{$c->stash->{erro} || {}};
    $c->stash->{inscricao}->insert if $c->req->method eq 'POST';
}

sub cadastro : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;
    $c->forward('handle_POST');
    sleep(3); # js tests.
    #$c->stash->{insert} = $c->model('DB::Usuario')->cadastrar($c->req->body_paramaters);
    $c->forward('handle_JSON');
}

sub login : Chained('base') : Args(0) {
    my ($self, $c) = @_;
    $c->forward('handle_POST');
    $c->stash->{login} = $c->model('Authentication')->login;
    $c->forward('handle_JSON');
}

sub logout : Chained('base') : Args(0) {
    my ($self, $c) = @_;
    $c->logout;
    $c->forward('handle_JSON');
}

sub planos : Chained('base') : Args(0) {
    my ($self, $c) = @_;
    $c->stash->{planos} = [ ];
    $c->forward('handle_JSON');
}

sub boleto : Chained('base') : Args(0) {
    my ($self, $c) = @_;
    $c->stash->{boleto} = 1;
    $c->forward('handle_JSON');
}

sub handle_JSON : Private {
    my ( $self, $c ) = @_;
    $c->detach('View::JSON');
}

sub handle_POST : Private {
    my ( $self, $c ) = @_;

    my $meth = $c->req->method;
    $c->detach('handle_JSON') if $meth eq 'GET';
    $c->detach('/error_404') unless $meth eq 'POST';
}

__PACKAGE__->meta->make_immutable;

1;

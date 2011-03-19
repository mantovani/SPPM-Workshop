use strict;
use warnings;
use Test::More;
use Catalyst::Test 'SPPM::WorkShop';
use HTTP::Request::Common;

ok( my $controller = SPPM::WorkShop->controller('Inscricao') );
my $c   = SPPM::WorkShop->new;
my $req = $c->req;
$req->method('POST');
my %normal = (
    nome    => 'Teste',
    email   => 'teste@teste.com',
    apelido => 'teste',
    celular => 99999999
);
my %sem_nome = %normal;
delete $sem_nome{nome};

my %sem_email = %normal;
delete $sem_email{email};

my %sem_apelido = %normal;
delete $sem_apelido{apelido};

my %sem_celular = %normal;
delete $sem_celular{celular};

# fazer inscrição com todos os campos
{
    my $schema = SPPM::WorkShop->model('DB')->schema;
    eval { $schema->txn_do(
        sub {
            my ( $res, $ctx ) = ctx_request( POST '/inscricao', [%normal] );
            ok( my $inscricao = $ctx->stash->{inscricao} );
            ok($inscricao->in_storage);
            my %columns = $inscricao->get_columns;
            delete @columns{qw(id confirmado)};
            is_deeply( \%columns, \%normal );
            die 'rollback';
        }
    )};
    die $@ unless $@ =~ /rollback/;
}

# não pode fazer inscrição sem fornecer nome
{
    my ( $res, $ctx ) = ctx_request( POST '/inscricao', [%sem_nome] );
    ok( my $inscricao = $ctx->stash->{inscricao} );
    ok( !$inscricao->in_storage, 'não faz inscricao sem fornecer nome' );
}

# não pode fazer inscricao sem fornecer email
{
    my ( $res, $ctx ) = ctx_request( POST '/inscricao', [%sem_email] );
    ok( my $inscricao = $ctx->stash->{inscricao} );
    ok( !$inscricao->in_storage, 'não faz inscricao sem fornecer email' );
}

# pode fazer inscricao sem fornecer um apelido
{
    my ( $res, $ctx ) = ctx_request( POST '/inscricao', [%sem_apelido] );
    ok( my $inscricao = $ctx->stash->{inscricao} );
    my %columns = $inscricao->get_columns;
    delete $columns{apelido} unless $columns{apelido};
    delete @columns{qw(id confirmado)};
    is_deeply( \%columns, \%sem_apelido );
}

# não pode fazer inscrição sem fornecer celular
{
    my ( $res, $ctx ) = ctx_request( POST '/inscricao', [%sem_celular] );
    ok( my $inscricao = $ctx->stash->{inscricao} );
    ok( !$inscricao->in_storage, 'não faz inscricao sem fornecer celular' );
}

done_testing;

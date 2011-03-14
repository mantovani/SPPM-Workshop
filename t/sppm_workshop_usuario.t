
use warnings;
use strict;

use Test::More qw(no_plan);
use aliased 'SPPM::Workshop::Schema';

my $schema = Schema->connect( 'dbi:Pg:dbname=sppm_workshop', 'thiago', '' );
my $users = $schema->resultset('Usuario');

my $count = $users->count;

my $user = $users->create(
    {
        cpf => '0000000000',

        data_nascimento => DateTime->new(
            year  => 2010,
            month => 10,
            day   => 10
        ),
        nome     => 'Alice',
        email    => 'alice@perlworkshop.com.br',
        senha    => 'senha',
        telefone => '(11)8888-8888',
        endereco => 'Rua Foobar',
        bairro   => 'foo',
        estado   => 'SP',
        cep      => '40004444',
        plano_id => 1
    }
);

is( $count + 1, $users->count );
$user->delete;
is( $count, $users->count );

1;


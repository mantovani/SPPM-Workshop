
use warnings;
use strict;

use Test::More qw(no_plan);
use aliased 'SPPM::Workshop::Schema';
use aliased 'SPPM::Workshop::Usuario';

my $schema = SPPM::Workshop::Schema->connect('', '', '');
my $user = Usuario->new( resultset => $conn->resultset('Usuario') );

my %args = (
    cpf => '0000000000',
    data_nascimento => DateTime->new(
        year => 2010,
        month => 10,
        day => 10
    ),
    nome => 'Alice',
    email => 'alice@perlworkshop.com.br',
    senha => 'senha',
    sexo => 'feminino',
    estado_civil => 'solteira',
    telefone => '(11)8888-8888',
    bairro => 'foo',
    estado => 'SP',
    cep => '40004444'
    plano => 1
);

$user->cadastrar(%args);

1;


package SPPM::Workshop::Schema::Result::Usuario;

use Moose;
use Scalar::Util ();
use DateTime;

extends 'DBIx::Class';
use MooseX::Types::CPF qw(CPF);
use MooseX::Types::Email qw(EmailAddress);

__PACKAGE__->load_components(qw/InflateColumn::DateTime Core/);
__PACKAGE__->table("usuario");

__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1,
        size              => 4
    },
    cpf => {
        data_type => 'varchar',
        size      => 14
    },
    nome => {
        data_type => 'varchar',
        size      => 255
    },
    email => {
        data_type => 'varchar',
        size      => 255,
    },
    senha => {
        data_type => 'varchar',
        size      => 32,
    },
    telefone     => {
        data_type => 'varchar',
        size      => 32
    },
    data_nascimento => {
        data_type => 'timestamp',
        size      => 8,
    },
    last_access => {
        data_type     => 'timestamp',
        size          => 4,
        default_value => \'now()',
    },
    plano_id => { data_type => 'integer' },
    endereco => {
        data_type => 'varchar',
        size => 255
    },
    bairro => { 
        data_type => 'varchar',
        size => 255
    },
    estado => {
        data_type => 'varchar',
        size => 2
    },
    cep => {
        data_type => 'varchar',
        size => 9
    },


);

before email => sub {
    my $self = shift;
    return unless @_;
    if ( my $error =
        Moose::Util::TypeConstraints::find_type_constraint(EmailAddress)
        ->validate(@_) )
    {
        $self->meta->throw_error('Email inválido');
    }
};

before cpf => sub {
    my $self = shift;
    return unless @_;
    if ( my $error =
        Moose::Util::TypeConstraints::find_type_constraint(CPF)->validate(@_) )
    {
        $self->meta->throw_error('CPF inválido');
    }
};

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( [qw/email cpf/] );

__PACKAGE__->belongs_to( plano => 'SPPM::Workshop::Result::Plano' =>
      { 'foreign.id' => 'self.plano_id' } );

sub age {
    my $self = shift;
    return ( ( 'DateTime'->now - $self->data_nascimento )->years );
}

1;


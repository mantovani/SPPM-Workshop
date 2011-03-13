package SPPM::Workshop::Schema::Result::Usuario;

use Moose;
use Scalar::Util ();
use DateTime;

use base 'DBIx::Class::Core';
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
    sexo         => { data_type => 'sexo' },
    estado_civil => { data_type => 'estado_civil' },
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
    plano_id => { data_type => 'integer' }

);

around data_nascimento => sub {
    my $orig = shift;
    my $self = shift;
    return $self->$orig() unless @_;
    my $type = Moose::Util::TypeConstraints::find_type_constraint('DateTime');
    my ($value) = @_;
    if ( my $coerced = $type->coerce($value) ) { $value = $coerced }
    if ( my $error = $type->validate($value) ) {
        $self->meta->throw_error($error);
    }
    return $self->$orig($value);
};

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

__PACKAGE__->has_one( plano => 'SPPM::Workshop::Result::Plano' =>
      { 'foreing.id' => 'self.plano_id' } );

sub age {
    my $self = shift;
    return ( ( 'DateTime'->now - $self->data_nascimento )->years );
}

1;


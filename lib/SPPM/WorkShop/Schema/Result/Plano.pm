package SPPM::Workshop::Schema::Result::Plano;

use Moose;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/InflateColumn::DateTime Core/);
__PACKAGE__->table("plano");

__PACKAGE__->add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1,
        size              => 4
    },
    nome => {
        data_type => 'varchar',
        size      => 255
    },
    tt_ini => {
        data_type => 'timestamp',
        size      => 8,
    },
    tt_fim => {
        data_type => 'timestamp',
        size      => 8
    },
    valor => { data_type => 'decimal' }
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( [qw/nome tt_ini tt_fim/] );

__PACKAGE__->has_many( usuarios => 'SPPM::Workshop::Result::Usuario' =>
      { 'foreign.plano_id' => 'self.id' } );

1;


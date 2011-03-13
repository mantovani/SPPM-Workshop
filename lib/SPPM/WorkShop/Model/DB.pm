package SPPM::Workshop::Model::DB;

use Moose;
extends 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'SPPM::Workshop::Schema',
    connect_info => {
        dsn => 'dbi:Pg:dbname=sppm_workshop',
        user => 'workshop', 
        password => 'workshop',
        AutoCommit => 1
    }
);

1;


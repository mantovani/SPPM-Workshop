package SPPM::WorkShop::Schema::Result::Inscricao;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

SPPM::WorkShop::Schema::Result::Inscricao

=cut

__PACKAGE__->table("inscricao");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 nome

  data_type: 'text'
  is_nullable: 0

=head2 apelido

  data_type: 'text'
  is_nullable: 1

=head2 email

  data_type: 'text'
  is_nullable: 0

=head2 celular

  data_type: 'integer'
  is_nullable: 0

=head2 confirmado

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "nome",
  { data_type => "text", is_nullable => 0 },
  "apelido",
  { data_type => "text", is_nullable => 1 },
  "email",
  { data_type => "text", is_nullable => 0 },
  "celular",
  { data_type => "integer", is_nullable => 0 },
  "confirmado",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07006 @ 2011-03-19 18:22:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FlECyFkgUS5qNYE9ziBsDA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

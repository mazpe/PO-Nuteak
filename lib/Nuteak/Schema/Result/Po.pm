package Nuteak::Schema::Result::Po;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("po");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "user_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "po_number",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "company",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "contact",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "address_1",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "address_2",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "city",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "state",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 32,
  },
  "zip_code",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 5 },
  "telephone",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 32,
  },
  "fax",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 32,
  },
  "email",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "ship_company",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "ship_contact",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "ship_address_1",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "ship_address_2",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "ship_city",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 64,
  },
  "ship_state",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 32,
  },
  "ship_zip_code",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 5 },
  "ship_telephone",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 10,
  },
  "status",
  {
    data_type => "VARCHAR",
    default_value => "Submitted",
    is_nullable => 0,
    size => 12,
  },
  "notes",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "created",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "updated",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("po_number", ["po_number"]);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2010-05-19 10:53:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Vzg+GqehBPDtqTmIehFHSQ

__PACKAGE__->add_columns(
    "created",
    { data_type => 'datetime', set_on_create => 1 },
    "updated",
    { data_type => 'datetime', set_on_create => 1, set_on_update => 1 },
);

# You can replace this text with custom content, and it will be preserved on regeneration
1;

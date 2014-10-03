package Nuteak::Schema::Result::PoItems;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("po_items");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "po_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "family",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 32,
  },
  "code",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 128,
  },
  "description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 128,
  },
  "options",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 32,
  },
  "style",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 24,
  },
  "sf",
  {
    data_type => "DECIMAL",
    default_value => "0.00",
    is_nullable => 0,
    size => 5,
  },
  "price",
  {
    data_type => "DECIMAL",
    default_value => "0.00",
    is_nullable => 0,
    size => 5,
  },
  "quantity",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "weight",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "units",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2010-05-19 10:53:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jOsNB+s+vwGbUP3fXsYS0g


# You can replace this text with custom content, and it will be preserved on regeneration
1;

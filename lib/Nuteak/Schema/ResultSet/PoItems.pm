package Nuteak::Schema::ResultSet::PoItems;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
use Data::Dumper;

=head1 NAME

Nuteak::Schema::ResultSet::PoItems - ResultSet

=head1 DESCRIPTION

PoItems ResultSet

=cut

sub find_client {
    my ( $self, $args ) = @_;
    my $row;

    $row = $self->find($args);

    return $row;
}



=head1 AUTHOR

Lester Ariel Mesa,,305-402-6717,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;


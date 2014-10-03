package Nuteak::Model::NuteakDB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'Nuteak::Schema',
    connect_info => [
        'dbi:mysql:database',
        'username',
        'password',
        { AutoCommit => 1 },
        
    ],
);

=head1 NAME

Nuteak::Model::NuteakDB - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<Nuteak>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<Nuteak::Schema>

=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

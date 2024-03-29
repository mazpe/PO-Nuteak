package Nuteak::View::TTEmail;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION  => '.tt2',
    INCLUDE_PATH        => [
        Nuteak->path_to ( 'root', 'src' ),
    ],
);


=head1 NAME

Nuteak::View::TTEmail - TT View for Nuteak

=head1 DESCRIPTION

TT View for Nuteak.

=head1 SEE ALSO

L<Nuteak>

=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;


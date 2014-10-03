package Nuteak::View::Email;

use strict;
use base 'Catalyst::View::Email::Template';

__PACKAGE__->config(
    stash_key       => 'email',
    template_prefix => ''
);

=head1 NAME

Nuteak::View::Email - Templated Email View for Nuteak

=head1 DESCRIPTION

View for sending template-generated email from Nuteak. 

=head1 AUTHOR

root

=head1 SEE ALSO

L<Nuteak>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

package Nuteak::Controller::Logout;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Nuteak::Controller::Logout - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

Logout logic

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    # Clear the user's state
    $c->logout;

    # Send the user to the starting point
    $c->response->redirect($c->uri_for('/'));
}


=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

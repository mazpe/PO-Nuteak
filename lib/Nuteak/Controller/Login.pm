package Nuteak::Controller::Login;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Nuteak::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

=head2 index

Login logic

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    # Get the username and password from form
    my $username = $c->request->params->{username};
    my $password = $c->request->params->{password};

    # If the username and password values were found in form
    if ($username && $password) {
        # Attempt to log the user in
        if ($c->authenticate({ username => $username,
                               password => $password  } )) {
            # If successful, then let them use the application
            if ($c->user->username eq 'admin') {
                $c->response->redirect($c->uri_for(
                    $c->controller('Admin::Orders')->action_for('index')));
            } else {
                $c->response->redirect($c->uri_for(
                    $c->controller('Client::PurchaseOrder')->action_for('index')));
            }
            return;
        } else {
            # Set an error message
            $c->stash(error_msg => "Bad username or password.");
        }
    } else {
        # Set an error message
        $c->stash(error_msg => "Empty username or password.");
    }

    # If either of above don't work out, send to the login page
    $c->stash(template => 'login.tt2');
}

=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

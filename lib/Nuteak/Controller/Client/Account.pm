package Nuteak::Controller::Client::Account;

use Moose;
BEGIN { extends 'Catalyst::Controller' }
use Nuteak::Form::Client::Account;

has 'form' => (
    isa => 'Nuteak::Form::Client::Account',
    is => 'ro',
    lazy => 1,
    default => sub { Nuteak::Form::Client::Account->new },
);


=head1 NAME

Nuteak::Controller::Client::Account - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $client;
    my $form;

    # Check if we are logged in
    if ($c->user_exists) {
    # Client is logged in

        # Get our client object row
        $client = $c->model('Client')->get_client($c->user->id)

    } else {
    # Custmer is not logged it

        # Hold a new row in the database for our record
        $client = $c->model('NuteakDB::Client')->new_result({})
    
    }

    # Set our template and form to use
    $c->stash(
        template    => 'client/account.tt2',
        form        => $self->form,
    );

    # Process our form
    $form =  $self->form->process (
        item            => $client,
        params          => $c->req->params,
    );


}


=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

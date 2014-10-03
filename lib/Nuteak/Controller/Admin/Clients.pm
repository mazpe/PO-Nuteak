package Nuteak::Controller::Admin::Clients;

use strict;
use warnings;
use parent 'Catalyst::Controller::HTML::FormFu';


=head1 NAME

Nuteak::Controller::Admin::Clients - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index : Path Args(0) {

    my ( $self, $c ) = @_;

    $c->stash(
        template => 'admin/clients.tt2'
    );
}

sub create_or_update : Local {
    my ( $self, $c ) = @_;
    my $client;

    $client = $c->model('Client')->create( $c->req->params );

    $c->stash(
        json => { success => 1 },
    );

    $c->forward('View::JSON');
}

sub delete : Local {
    my ( $self, $c ) = @_;
    my $client;

    $client = $c->model('Client')->delete( $c->req->params );

    $c->stash(
        json => { success => 1 },
    );

    $c->forward('View::JSON');
}

=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

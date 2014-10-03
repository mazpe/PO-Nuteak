package Nuteak::Controller::Client::Orders;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Nuteak::Controller::Client::Orders - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my $orders = [$c->model('NuteakDB::Po')->search({user_id => $c->user->id})];

    $c->stash( 
        orders      => $orders,
        template    => 'client/orders.tt2' 
    );
}

sub view :Chained('/') :PathPart('client/orders/po') :Args(1) {
    my ( $self, $c, $po_number ) = @_;
    my $po;
    my $po_items;

    $po = $c->model('NuteakDB::Po')->find({po_number => $po_number}) ;

    $po_items = [$c->model('NuteakDB::PoItems')->search(
        { po_id => $po->id }
    )];


$c->log->debug($po_items);

    $c->stash( 
        po          => $po,
        po_items    => $po_items,
        template => 'client/order.tt2',
    );
}


=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

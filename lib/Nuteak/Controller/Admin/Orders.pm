package Nuteak::Controller::Admin::Orders;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Nuteak::Controller::Admin::Orders - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my $orders = [$c->model('NuteakDB::Po')->all];

    $c->stash(
        orders      => $orders,
        template    => 'admin/orders.tt2'
    );
}

sub view :Chained('/') :PathPart('admin/orders/po') :Args(1) {
    my ( $self, $c, $po_id ) = @_;
    my $po;
    my $po_items;

    #$po = $c->model('NuteakDB::Po')->find({po_number => $po_number}) ;
    $po = $c->model('NuteakDB::Po')->find($po_id) ;

    $po_items = [$c->model('NuteakDB::PoItems')->search(
        { po_id => $po->id }
    )];

    $c->stash(
        po          => $po,
        po_items    => $po_items,
        template => 'admin/order.tt2',
    );
}

sub delete :Chained('/') :PathPart('admin/orders/po_delete') :Args(1) {
    my ( $self, $c, $po_id ) = @_;
    my $po;
    my $po_items;

    if ($po_id) {

        $c->model('NuteakDB::PoItems')->search( { po_id => $po_id } )->delete;
        $c->model('NuteakDB::Po')->search( { id => $po_id } )->delete;

        $c->response->redirect(
            $c->uri_for( $self->action_for('admin/orders')) . '/' );

    }

}

sub update : Local {
    my ( $self, $c ) = @_;
    my $item;
    my $object;

    my $po = $c->model('Po')->update( $c->req->params );

    $c->response->redirect('/admin/orders');

}


=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

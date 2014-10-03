package Nuteak::Controller::Client::PurchaseOrder;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use JSON::XS;

=head1 NAME

Nuteak::Controller::Client::PurchaseOrder - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my $items   = [$c->model('NuteakDB::Item')->all];
    my $client  = $c->model('NuteakDB::User')->find($c->user->id);

    $c->stash( 
        client      => $client, 
        items       => $items,
        template    => 'client/po.tt2',
    );
}

sub save : Local {
    my ( $self, $c ) = @_;
    my $item;
    my $json;
    my $object;
    my $email;

    my $po = $c->model('Po')->create( $c->req->params ); 

    $c->stash(
        json => { success => 1 },
    );
    

    $c->forward('View::JSON');

    $email = $c->forward( 'send_email', [$po->id] );
}

sub update : Local {
    my ( $self, $c ) = @_;
    my $item;
    my $object;

    my $po = $c->model('Po')->update( $c->req->params );

    $c->response->redirect('/client/orders');

}

sub submitted :Chained('/') :PathPart('client/purchaseorder/submitted') :Args(1) {
    my ( $self, $c, $po_number ) = @_;
    my $po_items;

    $c->stash(
        po          => $po_number,
        template => 'client/submitted.tt2',
    );

    $c->detach( 'send_email', [$po_number] );
}


sub send_email : Local {
    my ( $self, $c, $po_number ) = @_;
    my $subject;
    my $po;

    $po = $c->model('NuteakDB::Po')->find( {po_number => $po_number} );
 
    # Load items from cart
    $c->stash(
        po              => $po,
    );

    $subject = 'NuTeak - Purchase Order Request';

    # Send email
    $c->stash->{email} = {
            to          => 'diane@nuteak.com',
            cc          => 'renaud@nuteak.com',
            from        => 'po@nuteak.com',
            subject     => $subject,
            template    => 'email_po.tt2',
            content_type => 'text/plain',
    };

    $c->forward( $c->view('Email::Template') );

}

=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

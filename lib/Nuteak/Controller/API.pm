package Nuteak::Controller::API;

use strict;
use warnings;
use parent 'Catalyst::Controller::REST';

=head1 NAME

Nuteak::Controller::API - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


__PACKAGE__->config(default => 'application/json');

sub clients : Local ActionClass('REST') {}

sub clients_POST {
    my ($self, $c) = @_;

    #my ($page, $search_by, $search_text, $rows, $sort_by, $sort_order) =
    #    @{ $c->req->params }{qw/page qtype query rp sortname sortorder/};

    my ($page, $search_by, $search_text, $rows, $sort_by, $sort_order) =
             @{ $c->req->params }{qw/start qtype query limit sort dir/};
     

    s/\W*(\w+).*/$1/ for $sort_by, $sort_order, $search_by; # sql injections bad

    my %data;

    my $rs = $c->model('NuteakDB::User')->search({}, {
        order_by => "company",
    });

    $rs = $rs->search_literal("lower($search_by) LIKE ?", lc($search_text))
        if $search_by && $search_text;

    my $paged_rs = $rs->search({}, {
        page => $page,
        rows => $rows,
    });

    $data{totalCount} = $rs->count;
    $data{page}  = $page;
    $data{data}  = [
        map { +{
            id => $_->id,
            #cell => [
                #$_->id,
                company => $_->company,
                contact => $_->contact,
                address_1 => $_->address_1,
                address_2 => $_->address_2,
                city => $_->city,
                state => $_->state,
                zip_code => $_->zip_code,
                telephone => $_->telephone,
                fax => $_->fax,
                email => $_->email,
                username => $_->username,
                
            #]
        } } $paged_rs->all
    ];

    $self->status_ok($c, entity => \%data);
}

sub client : Local ActionClass('REST') {
    my ($self, $c, $id) = @_;

    $c->stash(client => $c->model('NuteakDB::Client')->find($id));
}

sub client_DELETE {
    my ($self, $c, $id) = @_;

    $c->stash->{client}->delete;

    $self->status_ok($c, entity => { message => 'success' });
}


sub items : Local ActionClass('REST') {}

sub items_POST {
    my ($self, $c) = @_;

    my ($page, $search_by, $search_text, $rows, $sort_by, $sort_order) =
        @{ $c->req->params }{qw/start qtype query limit sort dir/};

    s/\W*(\w+).*/$1/ for $sort_by, $sort_order, $search_by; # sql injections bad

    my %data;

    my $rs = $c->model('NuteakDB::Item')->search({}, {
        order_by => "$sort_by $sort_order",
    });

    $rs = $rs->search_literal("lower($search_by) LIKE ?", lc($search_text))
        if $search_by && $search_text;

    my $paged_rs = $rs->search({}, {
        page => $page,
        rows => $rows,
    });

    $data{totalCount} = $rs->count;
    $data{page}  = $page;
    $data{data}  = [
        map { +{
            id => $_->id,
            #cell => [
                #$_->id,
                family => $_->family,
                code => $_->code,
                description => $_->description,
                options => $_->options,
                style => $_->style,
                sf => $_->sf,
                price => $_->price,
                weight => $_->weight,
                units => $_->units
            #]
        } } $paged_rs->all
    ];

    $self->status_ok($c, entity => \%data);
}

sub item : Local ActionClass('REST') {
    my ($self, $c, $id) = @_;

    $c->stash(item => $c->model('NuteakDB::Item')->find($id));
}

sub item_DELETE {
    my ($self, $c, $id) = @_;

    $c->stash->{item}->delete;

    $self->status_ok($c, entity => { message => 'success' });
}


=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

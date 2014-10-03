package Nuteak::Controller::Client::Items;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use Data::Dumper;

=head1 NAME

Nuteak::Controller::Client::Items - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my @products;
    my @pro_options;
    my $options;
    my $i = 0;
    my $y = 0;
    my $items;
    my @output;

    ##$items = [$c->model('NuteakDB::Item')->all];

    ##for my $item (@$items) { 
    ##    $options = [ $c->model('NuteakDB::Item')->search(
    ##        family => $item->family,
    ##        {
    ##            columns     => [ qw/id family code options price/ ],
    ##            distinct    => 1,
    ##        }
	##
    ##    )];; 
	##
    ##    for my $opt (@$options) { 
    ##        push @output, { 
    ##            Id => $item->id, 
    ##            Family => $opt->family,
    ##            Code => $opt->code,
    ##            Options => $opt->options, 
    ##            Price => $opt->price 
    ##        } 
    ##    } 
    ##}

    ##$c->log->debug(Dumper(@output));*/

    $items = [$c->model('NuteakDB::Item')->all];

    for my $item (@$items) {
        push @output, {
        	Id => $item->id,
        	Code => $item->code,
        	Options => $item->options,
            Family => $item->family,
            Price => $item->price,
            Weight => $item->weight,
            Sf => $item->sf,
            Units => $item->units,
        }
    }
    
    $c->stash( data => \@output );

    $c->forward('View::JSON');

}

sub list : Local {
    my ( $self, $c ) = @_;
    my @output;

    my $items = [$c->model('NuteakDB::Item')->all];

    for my $item (@$items) {
        push @output, {
            Family => $item->family,
            Description => $item->description,
        }


    }

    $c->stash( data => \@output );
    $c->forward('View::JSON');

}

=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

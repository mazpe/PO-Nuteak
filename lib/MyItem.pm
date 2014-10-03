package MyItem;

use Moose;
use MooseX::Types::Moose qw(Str Int ArrayRef);
use namespace::autoclean;
use Data::Dumper;
use JSON::XS;

has 'user'      => ( is => 'ro', required => 1, weak_ref => 1 );
has 'session'   => ( is => 'ro', required => 1, weak_ref => 1 );
has 'schema'    => ( is => 'rw', required => 1, handles => [qw / resultset /] );

sub create {
    my ( $self, $args ) = @_;
    my $json;
    my $object;
    my $item;

    $json = new JSON;
    $object = $json->decode ($args->{data});

    for my $obj (@$object) {

        if ( $obj->{'insert'}  ) {
            delete $obj->{'insert'};
            delete $obj->{'id'};
            $self->resultset('Item')->create( $obj );
        } else {
            $self->resultset('Item')->find( $obj->{'id'} )->update( $obj );
        }
    }
}

sub get_item { # Return list of items
    my ( $self, $args ) = @_;
    my $item;


    if ( $args ) {
    # we have arguments

        # Find our item
        $item
            = $self->resultset('Item')->find_item($args);

    } else {
    # we have no arguments


    }

    return $item
}

sub delete {
    my ( $self, $args ) = @_;
    my $json;
    my $object;
    my $item;

    $json = new JSON;
    $object = $json->decode ($args->{data});

    for my $obj (@$object) {

        $self->resultset('Item')->find( $obj->{'id'} )->delete;

    };
}


1;

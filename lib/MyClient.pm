package MyClient;

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
    my $client;

    $json = new JSON;
    $object = $json->decode ($args->{data});

    for my $obj (@$object) {

        if ( $obj->{'insert'}  ) {
            delete $obj->{'insert'};
            delete $obj->{'id'};
            $self->resultset('User')->create( $obj );
        } else {
            unless ($obj->{'password'}) { delete $obj->{'password'} };
            $self->resultset('User')->find( $obj->{'id'} )->update( $obj );
        }
    }
}

sub get_client { # Return list of items
    my ( $self, $args ) = @_;
    my $client;


    if ( $args ) {
    # we have arguments

        # Find our client
        $client
            = $self->resultset('User')->find_user($args);

    } else {
    # we have no arguments


    }

    return $client
}

sub delete {
    my ( $self, $args ) = @_;
    my $json;
    my $object;
    my $client;

    $json = new JSON;
    $object = $json->decode ($args->{data});

    for my $obj (@$object) {

        $self->resultset('User')->find( $obj->{'id'} )->delete;

    };
}


1;

package MyOrder;

use Moose;
use MooseX::Types::Moose qw(Str Int ArrayRef);
use namespace::autoclean;
use Data::Dumper;

has 'user'      => ( is => 'ro', required => 1, weak_ref => 1 );
has 'session'   => ( is => 'ro', required => 1, weak_ref => 1 );
has 'schema'    => ( is => 'rw', required => 1, handles => [qw / resultset /] );

sub get_order { # Return list of orders
    my ( $self, $args ) = @_;
    my $order;


    if ( $args ) {
    # we have arguments

        # Find our order
        $order
            = $self->resultset('Order')->find_order($args);

    } else {
    # we have no arguments


    }

    return $order
}

1;

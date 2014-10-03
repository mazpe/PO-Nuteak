package MyPo;

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
    my $po;
    my $items_to_po;
    my $item;
    my $json;
    my $object;

    $po = $self->resultset('Po')->find_or_create(
        {
            user_id     => $self->user->id,
            po_number   => $args->{po_number},
            company     => $args->{company},
            contact     => $args->{contact},
            address_1   => $args->{address_1},
            city        => $args->{city},
            state       => $args->{state},
            zip_code    => $args->{zip},
            telephone   => $args->{telephone},
            fax         => $args->{fax},
            email       => $args->{email},
            notes       => $args->{notes},
            ship_company     => $args->{ship_company},
            ship_contact     => $args->{ship_contact},
            ship_address_1   => $args->{ship_address_1},
            ship_city        => $args->{ship_city},
            ship_state       => $args->{ship_state},
            ship_zip_code    => $args->{ship_zip},
            ship_telephone   => $args->{ship_telephone},

        },
        { key => 'po_number' },

    );

    $json = new JSON;
    $object = $json->decode ($args->{data});

    for my $obj (@$object) {

        $item = {
            po_id       => $po->id,
            code        => $obj->{'Code'},
            description => $obj->{'Description'},
            options     => $obj->{'Options'},
            price       => $obj->{'Price'},
            quantity    => $obj->{'Quantity'},
            weight      => $obj->{'Weight'},
            sf          => $obj->{'Sf'},
            units       => $obj->{'Units'}
        };

        $self->resultset('PoItems')->create( $item );

    };  


    return $po;
}

sub update {
    my ( $self, $args ) = @_;
    my $po;

    delete $args->{submit};

    $po = $self->resultset('Po')->find( $args->{id} )->update( $args );

    return $po;

}

sub get_po { # Return list of purchase_orders
    my ( $self, $args ) = @_;
    my $po;


    if ( $args ) {
    # we have arguments

        # Find our purchase_order
        $po = $self->resultset('po')->find_po($args);

    } else {
    # we have no arguments


    }

    return $po
}


1;

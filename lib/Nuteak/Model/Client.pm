package Nuteak::Model::Client;

use Moose;
use MyClient;
use namespace::autoclean;
extends 'Catalyst::Model';

with 'Catalyst::Component::InstancePerContext';

=head1 NAME

Nuteak::Model::Client - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head 1 METHODS

=cut

sub build_per_context_instance {
    my ( $self, $c ) = @_;

    return MyClient->new(
        user        => $c->user,
        session     => $c->session,
        sessionid   => $c->sessionid,
        schema      => $c->model('NuteakDB')->schema
    );

}

=head1 AUTHOR

Lester Ariel Mesa,,305-402-6717,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;


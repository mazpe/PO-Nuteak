package Nuteak::Controller::AJAX;

use strict;
use warnings;
use parent 'Catalyst::Controller::HTML::FormFu';

=head1 NAME

Nuteak::Controller::AJAX - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


#sub index : Path Args(0) {
sub index :Path :Args(0) {
    my ($self, $c) = @_;

    $c->stash(
        no_wrapper => 1,
        template => 'admin/client_list.tt2'
    );
}

sub client_form_add : Local Args(0) FormConfig('admin/client_add.yml') {
    my ($self, $c) = @_;

    my $form = $c->stash->{form};

    if ($form->submitted_and_valid) {
        my $client = $c->model('NuteakDB::Client')->new_result({});
        $form->model->update($client);
    }

    $c->stash(
        no_wrapper => 1,
        template => 'admin/client_add.tt2'
    );
}

sub client_form_edit : Local Args(1) FormConfig('admin/client_add.yml') {
    my ($self, $c, $id) = @_;

    my $form = $c->stash->{form};
    my $client = $c->model('NuteakDB::Client')->find($id);

    if ($form->submitted_and_valid) {
        $form->model->update($client);
    } else {
        $form->model->default_values($client);
    }

    $c->stash(
        no_wrapper => 1,
        template => 'admin/client_add.tt2'
    );
}

sub end : ActionClass('RenderView') {}



=head1 AUTHOR

Lester Ariel Mesa,,lesterm@gmail.com,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

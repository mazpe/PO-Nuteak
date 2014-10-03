package Nuteak::Form::Client::Account;
use HTML::FormHandler::Moose;
use HTML::FormHandler::Types ( 'NoSpaces', 'WordChars' );
extends 'HTML::FormHandler::Model::DBIC';
use Data::Dumper;

with 'HTML::FormHandler::Render::Simple'; # if you want to render the form

has '+item_class' => ( default => 'Client' );

has_field 'company'        => (
    type                => 'Text',
    label               => 'Company',
    css_class           => 'form_col_a',
);
has_field 'contact'        => (
    type                => 'Text',
    label               => 'Contact',
    css_class           => 'form_col_a',
);
has_field 'address_1'        => (
    type                => 'Text',
    label               => 'Address 1',
    required            => 1,
    required_message    => 'You must enter your Address1',
    css_class           => 'form_col_a',
);
has_field 'address_2'        => (
    type                => 'Text',
    label               => 'Address 2',
    css_class           => 'form_col_a',
);
has_field 'city'        => (
    type                => 'Text',
    label               => 'City',
    required            => 1,
    required_message    => 'You must enter your City',
    css_class           => 'form_col_a',
);
has_field 'state'        => (
    type                => 'Select',
    label               => 'State',
    required            => 1,
    required_message    => 'You must enter your State',
    css_class           => 'form_col_a',
);
has_field 'zip_code'        => (
    type                => 'Text',
    label               => 'Zip Code',
    required            => 1,
    required_message    => 'You must enter your Zip Code',
    css_class           => 'form_col_a',
);
has_field 'country'        => (
    type                => 'Select',
    label               => 'Country',
    required            => 1,
    required_message    => 'You must enter your Country',
    css_class           => 'form_col_a',
);
has_field 'submit'       => ( type => 'Submit', value => 'Save' );

sub options_state {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'States' )->get_state_names;

    return $rows;
}

sub options_country {
    my $self = shift;
    my $rows;

    return unless $self->schema;

    $rows = $self->schema->resultset( 'Countries' )->get_country_names;

    return $rows;
}

no HTML::FormHandler::Moose;
1;


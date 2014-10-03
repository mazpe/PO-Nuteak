package Nuteak;

use strict;
use warnings;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use parent qw/Catalyst/;
use Catalyst qw/-Debug
                ConfigLoader
                Static::Simple
            
                StackTrace

                Authentication

                Session
                Session::Store::FastMmap
                Session::State::Cookie

/;
our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in nuteak.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config( name => 'Nuteak' );

__PACKAGE__->config( default_view => 'TT' );
__PACKAGE__->config(
    'Plugin::Authentication' => {
        default_realm => 'users',
        realms => {
            users => {
                credential => {
                    class          => 'Password',
                    password_field => 'password',
                    password_type  => 'self_check'
                },
                store => {
                    class => 'DBIx::Class',
                    user_model => 'NuteakDB::User',
                }
            }
        }
    },
    'View::JSON' => {
        allow_callback  => 1,
        callback_param  => 'cb',
        expose_stash    => [ qw(data json) ],
    },
    'View::JSON2' => {
        allow_callback  => 1,
        callback_param  => 'cb',
        expose_stash    => 'json',
    },
);
__PACKAGE__->config(
    'View::Email::Template' => {
        default => {
            content_type => 'text/html',
            charset => 'utf-8',
            view => 'TTEmail',
        },
        sender => {
            mailer => 'SMTP',
            mailer_args => {
                Host     => 'mail.gbrnd.com', # defaults to localhost
                username => 'web71_admin',
                password => 's4b0r3',
            }
        },
        template_prefix => 'email',
    }
);

# Start the application
__PACKAGE__->setup();


=head1 NAME

Nuteak - Catalyst based application

=head1 SYNOPSIS

    script/nuteak_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Nuteak::Controller::Root>, L<Catalyst>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

package Blooxm;
use 5.008_001;
use Moose;

use Blooxm::Config;
use Blooxm::Dispatcher;
use Blooxm::Types;

our $VERSION = 0.000_001;

has config => (
    is       => 'rw',
    isa      => 'Blooxm::Config',
    required => 1,
    coerce   => 1,
);

has dispatcher => (
    is  => 'rw',
    isa => 'Blooxm::Dispatcher',
    default => sub {
        Blooxm::Dispatcher->new( config => shift->config );
    },
);

sub BUILD {
    my $self = shift;

    # setup plugins
    for my $plugin (@{ $self->config->plugins }) {
        $plugin->meta->apply($self->dispatcher);
    }
}

sub handler {
    my $self = shift;
    sub { $self->handle_request(@_) };
}

sub handle_request {
    my ($self, $c) = @_;

    my @hooks = qw/
      parse_request
      load_templates
      find_entries
      render
      /;

    $self->dispatcher->$_($c) for @hooks;
}

=head1 NAME

Blooxm - Module abstract (<= 44 characters) goes here

=head1 SYNOPSIS

  use Blooxm;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for this module was created by ExtUtils::ModuleMaker.
It looks like the author of the extension was negligent enough
to leave the stub unedited.

Blah blah blah.

=head1 AUTHOR

Daisuke Murase <typester@cpan.org>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

1;

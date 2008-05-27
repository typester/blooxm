package Blooxm::Dispatcher;
use Moose;

use Blooxm::Context;
use Blooxm::Config;
use Blooxm::Types;

has config => (
    is       => 'rw',
    isa      => 'Blooxm::Config',
    required => 1,
);

has context => (
    is   => 'rw',
    isa  => 'Blooxm::Context',
    lazy => 1,
    default => undef,
);

# steel from blosxom.cgi
sub parse_request {
    my ($self, $c) = @_;

    my $path = '';
    my @path = split m!/!, $c->req->path;

    my $match_category = sub {
        $_[0]
          and $_[0] =~ /^[a-zA-Z].*$/
          and $_[0] !~ /\./;
    };

    while ($match_category->($path[0])) {
        $path .= '/' . shift @path;
    }

    my $flavour;
    if (my ($fn, $ext) = ($path[-1] || '') =~ /(.+)\.(.+)$/) {
        $flavour = $ext;
        $path .= "/$fn.$ext" unless $fn eq 'index';
        pop @path;
    }
    else {
        $flavour = $self->config->default_flavour;
    }

    $path =~ s!(^/*|/*$)!!g;

    my ($year, $month, $day) = @path;

    my $request_context = Blooxm::Context->new(
        path    => $path,
        flavour => $flavour,
        year    => $year,
        month   => $month,
        day     => $day,
    );
    $self->context($request_context);
}

sub load_templates {}

sub find_entries {}

sub render {}

1;

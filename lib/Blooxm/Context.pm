package Blooxm::Context;
use Moose;

has path => (
    is       => 'rw',
    isa      => 'Maybe[Str]',
    required => 1,
);

has flavour => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
);

has year => (
    is => 'rw',
    isa => 'Maybe[Int]',
);

has month => (
    is => 'rw',
    isa => 'Maybe[Int]',
);

has day => (
    is => 'rw',
    isa => 'Maybe[Int]',
);

1;


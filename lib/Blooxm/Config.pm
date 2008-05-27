package Blooxm::Config;
use Moose;
use Blooxm::Types;

use YAML;

with 'MooseX::ConfigFromFile';

has entries_dir => (
    is       => 'ro',
    isa      => 'Blooxm::Types::Dir',
    required => 1,
    coerce   => 1,
);

has file_extension => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
    default  => sub { 'txt' },
);

has default_flavour => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
    default  => sub { 'html' },
);

has plugins => (
    is      => 'ro',
    isa     => 'ArrayRef[Blooxm::Types::Plugin]',
    coerce  => 1,
    default => sub { [] },
);

sub get_config_from_file {
    my ($class, $file) = @_;
    YAML::LoadFile($file);
}

1;

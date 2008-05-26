package Blooxm::Config;
use Moose::Role;
use Blooxm::Types;

use YAML;

with 'MooseX::ConfigFromFile';

has entries_dir => (
    is       => 'rw',
    isa      => 'Blooxm::Types::Dir',
    required => 1,
    coerce   => 1,
);

sub get_config_from_file {
    my ($class, $file) = @_;
    YAML::LoadFile($file);
}

1;


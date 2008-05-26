package Blooxm::Types;
use Moose;
use Moose::Util::TypeConstraints;

subtype 'Blooxm::Types::Dir'
    => as 'Object'
    => where { $_->isa('Path::Class::Dir') && -e $_ && -d _ };

coerce 'Blooxm::Types::Dir'
    => from 'ArrayRef'
       => via { Path::Class::Dir->new(@$_) }
    => from 'Str'
       => via { Path::Class::Dir->new($_) };

1;

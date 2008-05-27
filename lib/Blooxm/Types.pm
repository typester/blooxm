package Blooxm::Types;
use Moose;
use Moose::Util::TypeConstraints;

subtype 'Blooxm::Types::Config'
    => as 'Object'
    => where { $_->isa('Blooxm::Config') };

coerce 'Blooxm::Config'
    => from 'HashRef'
       => via { Blooxm::Config->new($_) }
    => from 'Str'
       => via { Blooxm::Config->new_with_config( configfile => $_ ) };


subtype 'Blooxm::Types::Dir'
    => as 'Object'
    => where { $_->isa('Path::Class::Dir') && -e $_ && -d _ };

coerce 'Blooxm::Types::Dir'
    => from 'ArrayRef'
       => via { Path::Class::Dir->new(@$_) }
    => from 'Str'
       => via { Path::Class::Dir->new($_) };

subtype 'Blooxm::Types::Plugin'
    => as 'Str';

coerce 'Blooxm::Types::Plugin'
    => from 'HashRef'
       => via {
           my $conf = $_;

           my $plugin = $conf->{module};
           if ($plugin =~ /^\+/) {
               $plugin =~ s/^\+//;
           } else {
               $plugin = "Blooxm::Plugin::$plugin";
           }

           Class::MOP::load_class($plugin)
                   unless Class::MOP::is_class_loaded($plugin);

           $plugin;
       };

subtype 'ArrayRef[Blooxm::Types::Plugin]'
    => as 'ArrayRef';

coerce 'ArrayRef[Blooxm::Types::Plugin]'
    => from 'ArrayRef'
       => via {
           my $t = Moose::Util::TypeConstraints::find_type_constraint("Blooxm::Types::Plugin");
           [ map { $t->coerce($_) } @$_ ]
       };

1;

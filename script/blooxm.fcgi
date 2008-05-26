#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use File::Spec;
use lib File::Spec->catfile($FindBin::Bin, qw/.. lib/);

use HTTP::Engine;

use Blooxm;
use Blooxm::Interface::FCGI;

my $engine = HTTP::Engine->new(
    interface => Blooxm::Interface::FCGI->new_with_options(
        request_handler => 'Blooxm::handle_request',
    ),
);

$engine->run;


package Blooxm::Interface::FCGI;
use Moose;

extends 'HTTP::Engine::Interface::FCGI';
with 'MooseX::Getopt';

has '+request_processor' => (
    metaclass => 'NoGetopt',
);

1;

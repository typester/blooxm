use inc::Module::Install;
name 'Blooxm';
all_from 'lib/Blooxm.pm';

test_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;

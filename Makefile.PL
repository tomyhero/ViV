use inc::Module::Install;
name 'ViV';
all_from 'lib/ViV.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
test_requires 'Test::LoadAllModules';
auto_include;
WriteAll;

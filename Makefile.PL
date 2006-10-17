use inc::Module::Install;
name 'WebService-Hatena-Graph';
all_from 'lib/WebService/Hatena/Graph.pm';
license 'MIT';
build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;

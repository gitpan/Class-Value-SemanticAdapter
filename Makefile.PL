use inc::Module::Install;
include 'Module::AutoInstall';

name 'Class-Value-SemanticAdapter';
all_from 'lib/Class/Value/SemanticAdapter.pm';
perl_version '5.006';

requires 'Class::Value';
requires 'Data::Semantic';
requires 'UNIVERSAL::require';

build_requires 'Test::More' => '0.70';

process_templates(
    first_year => 2007,
    rest_from  => "$ENV{HOME}/.mitlib/standard_pod",
    start_tag  => '{%',
    end_tag    => '%}',
);

use_standard_tests(without => 'pod_coverage');
auto_install;
auto_include;
WriteAll;

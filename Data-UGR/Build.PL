use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Data::UGR',
    license             => 'artistic2',
    dist_author         => 'Óscar Zafra <oskyar@gmail.com>',
    dist_version_from   => 'lib/Data/UGR.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'Data-UGR-*' ],
);

$builder->create_build_script();

# NOTE: If you need to test post() method, set both username and
# password on Hatena into environment variables named HATENA_USERNAME
# and HATENA_PASSWORD

use strict;
use Test::More;
use WebService::Hatena::Graph;

plan skip_all => '$ENV{HATENA_USERNAME} and $ENV{HATENA_PASSWORD} required for testing post() method'
    unless $ENV{HATENA_USERNAME} && $ENV{HATENA_PASSWORD};

plan tests => 1;

is(
    do {
        my $graph = WebService::Hatena::Graph->new(
            username => $ENV{HATENA_USERNAME},
            password => $ENV{HATENA_PASSWORD},
        );
        my $response = $graph->post(
            graphname => 'test graph',
            value     => int(rand(100)),
        );
        $response->code;
    },
    201,
    'test for post() method',
);

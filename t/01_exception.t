use strict;
use Test::Base;
use WebService::Hatena::Graph;

BEGIN {
    eval q{use Test::Exception};
    plan skip_all => 'Test::Exception required for testing exception' if $@;
}

plan tests => 6;
filters qw(chomp);

my $first  = first_block();
my $second = next_block();
my $graph  = WebService::Hatena::Graph->new(
    username => $first->username,
    password => $first->password,
);

### test for new() method
dies_ok(
    sub {my $graph = WebService::Hatena::Graph->new; },
    'new():  args not passed in',
);

dies_ok(
    sub {my $graph = WebService::Hatena::Graph->new(username => $first->username); },
    'new():  only username passed in'
);

dies_ok(
    sub {my $graph = WebService::Hatena::Graph->new(password => $first->password); },
    'new():  only password passed in'
);


### test for post() method
dies_ok(
    sub { $graph->post; },
    'post(): args not passed in'
);

dies_ok(
    sub { $graph->post(graphname => $second->graphname); },
    'post(): only graphname passed in'
);

dies_ok(
    sub { $graph->post(value => $second->value); },
    'post(): only value passed in'
);

__END__
===
--- username
John Doe
--- password
s3cr3t

===
--- graphname
test graph
--- value
999

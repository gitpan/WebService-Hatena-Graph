package WebService::Hatena::Graph;

use strict;
use warnings;
use Carp qw(croak);
use LWP::UserAgent;

our $VERSION = '0.03';

sub new {
    my ($class, $username, $password) = @_;
    croak ('Both username and password are required')
        unless (defined $username && defined $password);

    my $ua = LWP::UserAgent->new(agent => __PACKAGE__."/$VERSION");
       $ua->credentials('graph.hatena.ne.jp:80', '', $username, $password);

    return bless { ua => $ua }, $class;
}

sub post {
    my ($self, $graphname, $date, $value) = @_;
    my $response = $self->{ua}->post('http://graph.hatena.ne.jp/api/post', {
            graphname => $graphname,
            date      => $date,
            value     => $value,
    });

    croak (sprintf "%d: %s", $response->code, $response->message)
        if $response->code != 201;
}

1;

__END__

=head1 NAME

WebService::Hatena::Graph - A Perl interface to Hatena::Graph API

=head1 VERSION

This document describes WebService::Hatena::Graph version 0.03

=head1 SYNOPSIS

  use WebService::Hatena::Graph;

  my $graph = WebService::Hatena::Graph->new($username, $password);
     $graph->post($graphname, $date, $value);

=head1 DESCRIPTION

WebService::Hatena::Graph allows you to post some values resulting
from your daily activities easily to Hatena::Graph to record them
graphically.

=head1 METHODS

=head2 new ( I<$username>, I<$password> )

=over 4

  my $graph = WebService::Hatena::Graph->new($username, $password);

Creates and returns a new WebService::Hatena::Graph object.

=back

=head2 post ( I<$graphname>, I<$date>, I<$value>  )

=over 4

  $graph->post($graphname, $date, $value);

Posts a new I<$value> for I<$date> to the graph represented by
I<$graphname>. Unless the response code is 201, this method will croak
immediately.

I<$date> can take any form described below:

=back

=over 4

=item * 2006-10-13, 06-10-13, 10-13

Date values separated with dashes.

=item * 2006/10/13, 06/10/13, 10/13

Date values separated with slashes.

=item * 20061013, 061013

Date values unseparated.

For more details, consult the help documentation of Hatena::Graph.

=back

=head1 SEE ALSO

=over 4

=item * Hatena::Graph

L<http://graph.hatena.ne.jp/>

=item * Hatena::Graph API documentation

L<http://d.hatena.ne.jp/keyword/%a4%cf%a4%c6%a4%ca%a5%b0%a5%e9%a5%d5%bf%f4%c3%cd%c5%d0%cf%bfAPI>

=back

=head1 AUTHOR

Kentaro Kuribayashi E<lt>kentaro@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE (The MIT License)

Copyright (c) 2006, Kentaro Kuribayashi E<lt>kentaro@cpan.orgE<gt>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=cut

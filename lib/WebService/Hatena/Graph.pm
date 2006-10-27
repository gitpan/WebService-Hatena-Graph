package WebService::Hatena::Graph;

use strict;
use warnings;
use Carp qw(croak);
use LWP::UserAgent;

our $VERSION = '0.04';

sub new {
    my ($class, %args) = @_;
    croak ('Both username and password are required')
        unless (defined $args{username} && defined $args{password});

    my $ua = LWP::UserAgent->new(agent => __PACKAGE__."/$VERSION");
       $ua->credentials('graph.hatena.ne.jp:80', '', @args{qw(username password)});

    return bless { ua => $ua }, $class;
}

sub post {
    my ($self, %args) = @_;
    croak ('Both graphname and value are required')
        unless (defined $args{graphname} && defined $args{value});

    my $response = $self->{ua}->post('http://graph.hatena.ne.jp/api/post', {
        map { $_ => $args{$_} } qw(graphname date value)
    });

    croak (sprintf "%d: %s", $response->code, $response->message)
        if $response->code != 201;

    return $response;
}

1;

__END__

=head1 NAME

WebService::Hatena::Graph - A Perl interface to Hatena::Graph API

=head1 VERSION

This document describes WebService::Hatena::Graph version 0.04

=head1 SYNOPSIS

  use WebService::Hatena::Graph;

  my $graph = WebService::Hatena::Graph->new(
         username => $username,
         password => $password,
     );

     $graph->post(
         graphname => $graphname,
         date      => $date,      # optional
         value     => $value,
     );

=head1 DESCRIPTION

WebService::Hatena::Graph allows you to post some values resulting
from your daily activities easily to Hatena::Graph to record them
graphically.

=head1 METHODS

=head2 new ( I<%args> )

=over 4

  my $graph = WebService::Hatena::Graph->new(
      username => $username,
      password => $password,
  );

Creates and returns a new WebService::Hatena::Graph object. Both
username and password are required.

=back

=head2 post ( I<%args>  )

=over 4

  $graph->post(
      graphname => $graphname,
      date      => $date,      # optional
      value     => $value,
  );

Posts a new I<$value> on I<$date> to the graph indicated by
I<$graphname>. Unless the required parameters are not passed in or the
response code is 201, this method will croak immediately.

You can omit to pass the date explicitly. In that case, Hatena::Graph
will regard as if you pass the date on the day.

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

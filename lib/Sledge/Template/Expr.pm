package Sledge::Template::Expr;
# $Id$
#
# Tatsuhiko Miyagawa <miyagawa@edge.co.jp>
# Livin' On The EDGE, Limited.
#

use strict;
use vars qw($VERSION);
$VERSION = 0.01;

use Sledge::Hammer 0.18_04;
use base qw(Sledge::Template);

use HTML::Template::Expr 0.03;

sub import {
    my $class = shift;
    my $pkg = caller(0);
    no strict 'refs';
    *{"$pkg\::create_template"} = sub {
	my($self, $file) = @_;
	return $class->new($file, $self);
    };
}

sub output {
    my $self = shift;
    $self->_associate_dump;
    my $template = HTML::Template::Expr->new(%{$self->{_options}});
    $template->param(%{$self->{_params}});
    return $template->output;
}

sub register_function {
    my $class = shift;
    HTML::Template::Expr->register_function(@_);
}

1;

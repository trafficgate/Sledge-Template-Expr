package Sledge::Template::Expr;
# $Id$
#
# Tatsuhiko Miyagawa <miyagawa@edge.co.jp>
# Livin' On The EDGE, Limited.
#

use strict;
use vars qw($VERSION);
$VERSION = 0.03;

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

__END__

=head1 NAME

Sledge::Template::Expr - HTML::Template::Expr adapter

=head1 SYNOPSIS

  package Your::Pages;
  use Sledge::Template::Expr;

=head1 DESCRIPTION

テンプレートとして HTML::Template::Expr を利用するためのプラグインです。

=head1 METHODS

以下のメソッドがtemplateオブジェクトから利用可能です。

=over 4

=item register_function

  $page->tmpl->register_function(add => sub { $_[0] + $_[1] });

HTML::Tempalte::Expr の C<Cregister_function> へのwrapperです。

=back

=head1 AUTHOR

Tatsuhiko Miyagawa with Sledge development team.

=head1 SEE ALSO

L<HTML::Template::Expr>, L<Sledge::Template>, L<Sledge::Template::TT>

=cut



# $Id$
#
# Tatsuhiko Miyagawa <miyagawa@edge.co.jp>
# Livin' On The EDGE, Limited.
#
use strict;
use Test::More;

BEGIN {
    eval { require HTML::Template::Expr; };
    plan $@ ? (skip_all => 'no H::T::Expr') : 'no_plan';
}

use CGI;


{
    package Mock::Pages;
    use Sledge::Template::Expr;
    use Sledge::Pages::Compat;

    sub create_config { bless {}, 'Mock::Config' }

    package Mock::Config;
    sub tmpl_path { 't/template' }

    Sledge::Template::Expr->register_function(
	redify => sub { return qq(<FONT color="red">$_[0]</FONT>) },
    );
}

{
    my $page = bless {}, 'Mock::Pages';
    $page->{r} = CGI->new({});
    $page->load_template('foo');

    $page->tmpl->associate_namespace(cgi => CGI->new({
	name => 'cgi_obj', speed => 0.1,
    }));
    $page->tmpl->param(foo => 'foo');

    local $Sledge::Template::NSSepChar = '__';
    my $out = $page->tmpl->output;
    like $out, qr/^Foo: foo/m;
    like $out, qr/^Name: cgi_obj/m;
    like $out, qr/^CGIName: cgi_obj/m;
    like $out, qr/^CGISpeed: 1\.1/m;
    like $out, qr,^Redify: <FONT color="red">foo</FONT>,m;
}

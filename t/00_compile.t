use strict;
use Test::More;

BEGIN {
    eval { require HTML::Template::Expr; };
    plan $@ ? (skip_all => 'no H::T::Expr') : 'no_plan';
}

require_ok 'Sledge::Template::Expr';


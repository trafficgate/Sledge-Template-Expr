use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Sledge::Template::Expr',
    'VERSION_FROM' => 'lib/Sledge/Template/Expr.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::More => 0.32,
    },
);

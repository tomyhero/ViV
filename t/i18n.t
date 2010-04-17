use Test::More;
use Polocky::Util::Initializer 'ViV::Web';
use ViV::I18N;

my $i18n = ViV::I18N->new();

ok($i18n->load() );

is( $i18n->get('label.password') , 'パスワード');

done_testing();

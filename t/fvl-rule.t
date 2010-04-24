use Test::Most;
use ViV::FVL::Rule;
use ViV::Container 'con';

ok( !ViV::FVL::Rule::unique_id( 'admin',{ table => 'member' , field => 'login_name' } ) );
ok( ViV::FVL::Rule::valid_id(  1, { table => 'member' } ) );

done_testing();

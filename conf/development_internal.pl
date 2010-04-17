use  Plack::Session::State::Cookie;
use Plack::Session::Store::Cache;
use Cache::FastMmap;
+{
    default => {
        'logger' => {
            'dispatchers' => [
                'screen'
                ],
                'screen' => {
                    'stderr' => '1',
                    'class' => 'Log::Dispatch::Screen',
                    'min_level' => 'debug'
                }
        },
    },
    'application' => {
        'web' => {
            plugins => [
                {
                    'ViV::WAF::Plugin::FVL' => {
                        yaml_file => '__path_to(conf/dfv.yaml)__',
                    },          
                },
                'ViV::WAF::Plugin::Auth',
            ],
            'middlewares' => [
            {
                'module' => 'Plack::Middleware::StackTrace'
            },
            {
                'module' => 'Plack::Middleware::Debug',
            },
            {
                'module' => 'Plack::Middleware::Session',
                opts => {
                    state => Plack::Session::State::Cookie->new( session_key => 'viv_session' ),
                    store => Plack::Session::Store::Cache->new( cache => Cache::FastMmap->new()),
                }
            },
            ]
        }

    }
}

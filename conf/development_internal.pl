use Plack::Session::State::Cookie;
use Plack::Session::Store::File;

+{
    default => {
        'logger' => {
            'dispatchers' => [
                'screen'
                ],
                'screen' => {
                    'stderr' => '1',
                    'class' => 'Log::Dispatch::Colorful',
                    'min_level' => 'debug',
                    color     => {
                        info  => {
                            text => 'red',
                        },
                        error   => {
                            background => 'red',
                        },
                        alert   => {
                            text       => 'red',
                            background => 'white',
                        },
                        warning => {
                            text       => 'red',
                            background => 'white',
                            bold       => 1,
                        },
                    },
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
                'Polocky::WAF::CatalystLike::Plugin::ShowDispatcher',
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
                    store => Plack::Session::Store::File->new( dir => '/tmp/viv_session' )
                }
            },
            ]
        }

    }
}

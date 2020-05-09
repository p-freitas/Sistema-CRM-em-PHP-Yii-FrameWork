<?php

$params = require(__DIR__ . '/params.php');

$config = [
    'id' => 'CRM',
    'basePath' => dirname(__DIR__),
    'language' => 'pt-BR',
    'sourceLanguage' => 'pt-BR',
    'bootstrap' => ['log'],
//    'homeUrl' => '',
//    'defaultRoute' => '',
    'name' => 'CRM',
    'timeZone' => 'America/Bahia',
    'components' => [
        'request' => [
            'enableCookieValidation' => true,
            'cookieValidationKey' => 'f8d764b106e0bd5196e5e5605e26f2cb',
            'parsers' => [
                'application/json' => 'yii\web\JsonParser',
                'text/xml' => 'light\yii2\XmlParser',
                'application/xml' => 'light\yii2\XmlParser',
            ]
        ],
        'errorHandler' => [
            'errorAction' => 'site/error',
            'maxSourceLines' => 20,
        ],
        'session' => [
            'name' => 'patrimonio', // unique for backend
            'savePath' => __DIR__ . '/../runtime', // a temporary folder on backend
        ],
        'urlManager' => [
            'class' => 'yii\web\UrlManager',
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'rules' => [

            ]
        ],
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],
        'user' => [
            'class' => 'app\components\UserConfigCustom',
            'identityClass' => 'app\models\Usuario',
            'on afterLogin' => function ($event) {
                \webvimark\modules\UserManagement\models\UserVisitLog::newVisitor($event->identity->id);
            }
        ],
        'formatter' => [
            'class' => 'app\components\CustomFormatter',
            'dateFormat' => 'dd/MM/yyyy',
            'decimalSeparator' => ',',
            'thousandSeparator' => '.',
            'datetimeFormat' => 'dd/MM/yyyy HH:mm:ss',
            'timeFormat' => 'HH:mm:ss',
            'defaultTimeZone' => 'America/Bahia', // time szone
            'currencyCode' => 'BRL',
            /*'numberFormatterOptions' => [
                NumberFormatter::MIN_FRACTION_DIGITS => 2,
                NumberFormatter::MAX_FRACTION_DIGITS => 2,
            ]*/
        ],
        'pdf' => [
            'class' => \kartik\mpdf\Pdf::classname(),
            'format' => \kartik\mpdf\Pdf::FORMAT_A4,
            'orientation' => \kartik\mpdf\Pdf::ORIENT_PORTRAIT,
            'destination' => \kartik\mpdf\Pdf::DEST_DOWNLOAD,

        ],
        's3' => [
            'class' => '\app\components\CustomS3Service',
            'credentials' => [
                'key' => 'XXXXXXXXXXXXX',
                'secret' => 'XXXXXXXXXXXXXXXXXXXXXXXXXXXX',
            ],
            'region' => 'sa-east-1',
            'defaultBucket' => 'cdn.keep',
            'defaultAcl' => 'public-read',
            'httpOptions' => ['verify' => false],
        ],
        'mailer' => [
            'class' => 'yii\swiftmailer\Mailer',
            'useFileTransport' => false, //set this property to false to send mails to real email addresses
            //comment the following array to send mail using php's mail function
            'transport' => [
                'class' => 'Swift_SmtpTransport',
                'host' => 'mail.xxxxx.com',
                'username' => 'noreply@xxxxx.com',
                'password' => '123654',
                'port' => '25',
//                'encryption' => 'tls',
            ],
        ],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'db' => require(__DIR__ . '/db.php'),
        'view' => [
            'theme' => [
                'basePath' => '@web/themes/eliteadmin',
                'pathMap' => [
                    '@vendor/webvimark/module-user-management/views/' => '@app/views/user-management/',
                    '@app/views' => '@app/themes/eliteadmin',
                ],
                'baseUrl' => '@web/themes/eliteadmin',
            ],
        ],
        'assetManager' => [
            'appendTimestamp' => true,
        ],
        'i18n' => [
            'translations' => [
                'yii' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    'sourceLanguage' => 'en',
                    'basePath' => '@app/messages',
                ],
                'app' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    'sourceLanguage' => 'en',
                    'basePath' => '@app/messages',
                ],
                'modules/user-management/*' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    'sourceLanguage' => 'en',
                    'basePath' => '@app/messages',
                    'fileMap' => [
                        'modules/user-management/back' => 'back.php',
                        'modules/user-management/front' => 'front.php',
                    ],
                ],
                'widgets/GridBulkActions/*' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    'sourceLanguage' => 'en',
                    'basePath' => '@app/messages',
                    'fileMap' => [
                        'widgets/GridBulkActions/app' => 'app.php'
                    ],
                ],
                'widgets/GridPageSize/*' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    'sourceLanguage' => 'en',
                    'basePath' => '@app/messages',
                    'fileMap' => [
                        'widgets/GridPageSize/app' => 'app.php'
                    ],
                ],
                'kvgrid*' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    'sourceLanguage' => 'en',
                    'forceTranslation' => true,
                    'basePath' => '@app/messages',
                    'fileMap' => [
                        '@kvgrid/messages/kvgrid' => 'kvgrid.php'
                    ],
                ]
            ],
        ],
    ],
    'modules' => [
        'api' => [
            'class' => 'app\modules\APIRest\Api',
        ],
        'gridview' => ['class' => 'kartik\grid\Module'],
        'user-management' => [
            'class' => 'webvimark\modules\UserManagement\UserManagementModule',
            'registrationFormClass' => 'app\models\forms\CustomRegistrationForm',
            'rolesAfterRegistration' => [
                'usuarioWeb'
            ],
            'mailerOptions' => [
                'from' => 'noreply@keepinformatica.com',
                'passwordRecoveryFormViewFile' => '@app/views/user-management/mail/passwordRecoveryMail'
            ],
            'controllerMap' => [
                'user' => 'app\controllers\UserController',
                'auth' => 'app\controllers\AuthController'
            ],
            'on beforeAction' => ['app\modules\CustomAuthHelper', 'customLayoutHandler'],
        ],
        'gridviewKrajee' => [
            'class' => '\kartik\grid\Module',
        ]
    ],
    'params' => $params,
];

if (YII_ENV_DEV) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = [
        'class' => 'yii\debug\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        //'allowedIPs' => ['127.0.0.1', '::1'],
    ];

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        //'allowedIPs' => ['127.0.0.1', '::1'],
    ];
    //Add kint
    $config['bootstrap'][] = 'kint';
    $config['modules']['kint'] = [
        'class' => 'digitv\kint\Module',
    ];
}

return $config;

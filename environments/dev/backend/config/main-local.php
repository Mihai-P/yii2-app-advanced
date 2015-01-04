<?php

$config = [
    'components' => [
        'request' => [
            // !!! insert a secret key in the following (if it is empty) - this is required by cookie validation
            'cookieValidationKey' => '',
        ],
    ],
];

if (!YII_ENV_TEST) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = 'yii\debug\Module';

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
        'generators' => [
            'crud'   => [
                'class'     => 'core\gii\crud\Generator',
                'templates' => ['crud' => '@core/gii/crud']
            ],
            'model'   => [
                'class'     => 'core\gii\model\Generator',
                'templates' => ['model' => '@core/gii/model/default']
            ],
        ]
    ];
}

return $config;

<?php
/**
 * Created by PhpStorm.
 * User: wilton
 * Date: 27/10/17
 * Time: 11:16
 */

namespace app\assets;


use yii\web\AssetBundle;
use yii\web\View;

class RegistrationAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web';

    public $depends = [
        'yii\web\JqueryAsset',
    ];

    public $css = [
        'css/registration.css'
    ];

    public $js = [
        'js/registration.js'
    ];
}
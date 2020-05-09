<?php
/**
 * Created by PhpStorm.
 * User: wilton
 * Date: 26/07/17
 * Time: 11:21
 */

namespace app\assets;


use yii\web\AssetBundle;

class MainAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web/themes/eliteadmin';
    public $css = [
        'plugins/bower_components/switchery/dist/switchery.min.css',
        'plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css',
        'eliteadmin-inverse-php/css/animate.css',
        'eliteadmin-inverse-php/css/style.css',
        'eliteadmin-inverse-php/css/colors/default.css',
        'plugins/bower_components/toast-master/css/jquery.toast.css',
        'plugins/bower_components/idleTimeout/css/jquery-idleTimeout-plus.css',
    ];
    public $js = [
        'plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.js',
        'eliteadmin-inverse-php/js/jquery.slimscroll.js',
        'eliteadmin-inverse-php/js/waves.js',
        'plugins/bower_components/waypoints/lib/jquery.waypoints.js',
        'plugins/bower_components/switchery/dist/switchery.min.js',
        'plugins/bower_components/toast-master/js/jquery.toast.js',
        'plugins/bower_components/idleTimeout/js/jquery-idleTimeout-plus.js',
        'plugins/bower_components/sweetalert/sweetalert2.all.js',
        'eliteadmin-inverse-php/js/custom.js',
    ];
    public $depends = [
        'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapPluginAsset',
    ];
}
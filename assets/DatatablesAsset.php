<?php

namespace app\assets;


use yii\web\AssetBundle;

class DatatablesAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web/themes/eliteadmin';
    public $css = [
        'plugins/bower_components/datatables/jquery.dataTables.min.css',
    ];
    public $js = [
        'plugins/bower_components/datatables/jquery.dataTables.min.js',
    ];
    public $depends = [
        'app\assets\AppAsset',
    ];
}
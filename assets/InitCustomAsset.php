<?php
/**
 * Created by PhpStorm.
 * User: wilton
 * Date: 26/07/17
 * Time: 11:19
 */

namespace app\assets;
use yii\web\AssetBundle;
use yii\web\View;


class InitCustomAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web';
    public $css = [
        'css/site.css',
    ];
    public $js = [
        'js/init.js'
    ];
    public $depends = [

    ];
    public $jsOptions = array(
        'position' => View::POS_END // appear in the bottom of my page, but jquery is more down again
    );
}
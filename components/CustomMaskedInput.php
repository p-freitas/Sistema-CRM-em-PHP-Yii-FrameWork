<?php
/**
 * Created by PhpStorm.
 * User: Luan
 * Date: 22/08/2018
 * Time: 12:17
 */

namespace app\components;

use yii\web\View;
use yii\helpers\Json;
use yii\helpers\Html;
use \yii\widgets\MaskedInput;

class CustomMaskedInput extends MaskedInput
{
    /**
     * @inheritdoc
     */
    protected function hashPluginOptions($view)
    {
        $encOptions = empty($this->clientOptions) ? '{}' : Json::htmlEncode($this->clientOptions);
        $this->_hashVar = self::PLUGIN_NAME . '_' . hash('crc32', $encOptions);
        $this->options['data-plugin-' . self::PLUGIN_NAME] = $this->_hashVar;
        $view->registerJs("var {$this->_hashVar} = {$encOptions};", View::POS_END);
    }

    public function run()
    {
        $this->registerClientScript();
        if ($this->hasModel()) {
            echo Html::activeTextInput($this->model, $this->attribute, $this->options);
        } else {
            echo Html::textInput($this->name, $this->value, $this->options);
        }
    }

}
<?php

use webvimark\modules\UserManagement\UserManagementModule;
use yii\bootstrap\ActiveForm;
use yii\captcha\Captcha;
use yii\helpers\Html;
use yii\helpers\Url;

/**
 * @var yii\web\View $this
 * @var webvimark\modules\UserManagement\models\forms\RegistrationForm $model
 */

$this->title = UserManagementModule::t('front', 'Register');
\app\assets\RegistrationAsset::register($this);

$this->registerJs(
    "$('#customregistrationform-cep').popover({
            content: 'Digite o CEP e depois clique na lupa para buscar o endereço.',
            placement: 'top',
            trigger: 'focus'
        });",
    \yii\web\View::POS_READY,
    'popover_cep'
);

$this->registerJs(
    "$('#customregistrationform-fk_entidade').parent().popover({
            content: 'Digite o nome do município.',
            placement: 'top',
            trigger: 'manual'
        });",
    \yii\web\View::POS_READY,
    'popover_orgao'
);
?>

<div class="login-box-2">
    <div class="white-box">
        <h1 class="text-center"><b><?= $this->title ?></b></h1>
        <!-- /.login-logo -->
        <div class="login-box-body">
            <?php $form = ActiveForm::begin([
                'id' => 'user',
                'options' => ['autocomplete' => 'off']
            ]); ?>
            <div class="row">
                <div class="col-md-8">
                    <?= $form->field($model, 'fk_entidade')->widget(\kartik\select2\Select2::classname(), [
                        'theme' => 'bootstrap',
                        'language' => 'pt-BR',
                        'options' => ['placeholder' => 'Selecione um orgão'],
                        'pluginEvents' => [
                            "select2:open" => "function(){\$('#customregistrationform-fk_entidade').parent().popover('show');}",
                            "select2:close" => "function(){\$('#customregistrationform-fk_entidade').parent().popover('hide');}",
                        ],
                        'value' => $model->fk_entidade,
                        'initValueText' => empty($model->fk_entidade) ? '' : \app\models\Entidade::findOne([\app\models\Entidade::tableName().'.id' => $model->fk_entidade])->nome,
                        'pluginOptions' => [
                            'allowClear' => true,
                            'minimumInputLength' => 3,
                            'ajax' => [
                                'url' => \yii\helpers\Url::to(['//entidade/busca-ajax']),
                                'dataType' => 'json',
                                'data' => new \yii\web\JsExpression('function(params) { return {q:params.term}; }')
                            ],
                        ],
                    ])->label('Entidade') ?>
                </div>               
            </div>
            <div class="row">
                <div class="col-md-6">
                    <?= $form->field($model, 'username')->textInput(['maxlenght' => true])->label('Login') ?>
                </div>
                <div class="col-md-6">
                    <?= $form->field($model, 'email')->textInput(['maxlength' => true]) ?>
                </div>
            </div>
           
            <hr>
            <div class="row form-group">
                <div class="col-md-4">
                    <?= $form->field($model, 'password')->passwordInput(['maxlength' => 255]) ?>
                </div>
                <div class="col-md-4">
                    <?= $form->field($model, 'repeat_password')->passwordInput(['maxlength' => 255]) ?>
                </div>
                <div class="col-md-4">
                    <?= $form->field($model, 'captcha', [
                        'template' => '<div class="col-sm-12">{input}{error}</div>'
                    ])->widget(Captcha::className(), [
                        'template' => '<div class="row"><div class="col-sm-6"><label class="control-label">Captcha</label>{input}</div><div class="col-sm-6 m-t-15">{image}</div></div>',
                        'captchaAction' => ['/auth/captcha']
                    ]) ?>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-sm-12">
                    <div class="text-center">
                        <?= Html::a('<i class="fa fa-arrow-left"></i> Voltar', Url::previous(), ['class' => 'btn btn-default']) ?>
                        <?= Html::submitButton(
                            '<span class="glyphicon glyphicon-ok"></span> ' . UserManagementModule::t('front', 'Register_btn'),
                            ['class' => 'btn btn-primary']
                        ) ?>
                    </div>
                </div>
            </div>

            <?php ActiveForm::end(); ?>
        </div>
    </div>
</div>

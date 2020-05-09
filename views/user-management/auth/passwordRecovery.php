<?php

use webvimark\modules\UserManagement\UserManagementModule;
use yii\bootstrap\ActiveForm;
use yii\captcha\Captcha;
use yii\helpers\Html;
use yii\helpers\Url;

/**
 * @var yii\web\View $this
 * @var webvimark\modules\UserManagement\models\forms\PasswordRecoveryForm $model
 */

$this->title = UserManagementModule::t('front', 'Recover');
?>

<div class="login-box">
    <div class="white-box">
        <h1 class="text-center"><b><?= $this->title ?></b></h1>
        <!-- /.login-logo -->
        <div class="login-box-body">
            <p class="login-box-msg">Insira seu email para redefinir a senha</p>
            <div class="password-recovery">
                <?php $form = ActiveForm::begin([
                    'id' => 'user',
                    'layout' => 'horizontal',
                    'validateOnBlur' => false,
                    'validateOnChange' => false,
                    'fieldConfig' => [
                        'horizontalCssClasses' => [
                            'label' => '',
                            'offset' => '',
                            'wrapper' => '',
                            'error' => '',
                            'hint' => '',
                        ],
                    ],
                ]); ?>

                <div class="row">
                    <div class="col-md-12">
                        <?= $form->field($model, 'email', [
                            'template' => '<div class="col-md-12">{label}{input}{error}{hint}</div>'
                        ])->textInput(['maxlength' => 255, 'autofocus' => true]) ?>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <?= $form->field($model, 'captcha', [
                            'template' => '<div class="col-md-12">{label}{input}{error}{hint}</div>'
                        ])->widget(Captcha::className(), [
                            'template' => '<div class="row"><div class="col-sm-6">{input}</div><div class="col-sm-6">{image}</div></div> ',
                            'captchaAction' => ['/user-management/auth/captcha']
                        ]) ?>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-12">
                        <div class="text-center">
                            <?= Html::a('<i class="fa fa-arrow-left"></i> Voltar', Url::previous(), ['class' => 'btn btn-default']) ?>
                            <?= Html::submitButton(
                                '<span class="glyphicon glyphicon-ok"></span> ' . UserManagementModule::t('front', 'Recover'),
                                ['class' => 'btn btn-primary']
                            ) ?>
                        </div>
                    </div>
                </div>

                <?php ActiveForm::end(); ?>
            </div>
        </div>
    </div>
</div>

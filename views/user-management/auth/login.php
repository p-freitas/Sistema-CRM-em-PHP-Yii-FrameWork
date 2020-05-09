<?php

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use webvimark\modules\UserManagement\components\GhostHtml;
use webvimark\modules\UserManagement\UserManagementModule;
use dmstr\widgets\Alert;

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model app\models\forms\CustomLoginForm */

$this->title = 'CRM - Login';
?>
<!-- /.login-logo -->
<div class="login-box">
    <div class="white-box">
        <h1 class="text-center"><b>CRM</b></h1>
        <div class="login-box-body">
            <div class="row">
                <div class="col-md-12">
                    <?= Alert::widget() ?>
                    <?php $form = ActiveForm::begin([
                        'id' => 'login-form',
                        'options' => ['autocomplete' => 'off', 'class' => 'form-horizontal form-material'],
                        'validateOnBlur' => false,
                        'validateOnChange' => false,
                        'fieldConfig' => [
                            'template' => "{input}\n{error}",
                        ],
                    ]) ?>

                    <?= $form->field($model, 'cod_entidade')
                        ->DropDownList(\app\modules\Helper::map(\app\models\Entidade::find()->asArray()->all(), 'id', 'razao_social'), ['class' => 'form-control select2', 'prompt' => 'Empresa', 'autocomplete' => 'off']) ?>

                    <?= $form->field($model, 'username')
                        ->textInput(['placeholder' => 'Nome de usuário', 'autocomplete' => 'off']) ?>

                    <?= $form->field($model, 'password')
                        ->passwordInput(['placeholder' => 'Senha', 'autocomplete' => 'off']) ?>

                    <?= (isset(Yii::$app->user->enableAutoLogin) && Yii::$app->user->enableAutoLogin) ? $form->field($model, 'rememberMe',
                        [
                            'checkboxTemplate' => '<div class="checkbox">{input}{beginLabel}Manter conectado{endLabel}{error}{hint}</div>'
                        ]
                    )->checkbox(['value' => true]) : '' ?>

                    <div class="form-group">
                        <strong>Esqueceu sua senha? </strong>
                        <?= GhostHtml::a(
                            UserManagementModule::t('front', "Forgot password ?"),
                            ['/user-management/auth/password-recovery']
                        ) ?>
                    </div>

                    <?= Html::submitButton(
                        UserManagementModule::t('front', 'Enter'),
                        ['class' => 'btn btn-lg btn-primary btn-block']
                    ) ?>

                    <?php ActiveForm::end(); ?>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /.login-box-body -->

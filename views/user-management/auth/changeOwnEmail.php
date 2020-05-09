<?php

use webvimark\modules\UserManagement\UserManagementModule;
use yii\bootstrap\ActiveForm;
use yii\helpers\Html;

/**
 * @var yii\web\View $this
 * @var webvimark\modules\UserManagement\models\forms\ChangeOwnPasswordForm $model
 */

$this->title = UserManagementModule::t('front', 'Change E-mail');
$this->params['breadcrumbs'][] = $this->title;

if(empty($model->email_atual))
    $model->email_atual = 'Não cadastrado';
?>
<div class="change-own-email">
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="user-form">

                <?php $form = ActiveForm::begin([
                    'id'=>'user',
                    'layout'=>'horizontal',
                    'validateOnBlur'=>false,
                ]); ?>

                <?= $form->field($model, 'email_atual')->textInput(['maxlength' => 255, 'autocomplete'=>'off', 'disabled' => 'disabled'])->label('Email atual') ?>

                <?= $form->field($model, 'novo_email')->textInput(['maxlength' => 255, 'autocomplete'=>'off'])->label('Novo email') ?>

                <?= $form->field($model, 'confirma_email')->textInput(['maxlength' => 255, 'autocomplete'=>'off'])->label('Repete novo email') ?>


                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-9">
                        <?= Html::submitButton(
                            '<span class="glyphicon glyphicon-ok"></span> ' . UserManagementModule::t('back', 'Save'),
                            ['class' => 'btn btn-primary']
                        ) ?>
                    </div>
                </div>

                <?php ActiveForm::end(); ?>

            </div>
        </div>
    </div>

</div>

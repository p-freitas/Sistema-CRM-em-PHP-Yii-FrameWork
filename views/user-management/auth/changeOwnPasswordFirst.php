<?php

use webvimark\modules\UserManagement\UserManagementModule;
use yii\bootstrap\ActiveForm;
use yii\helpers\Html;

/**
 * @var yii\web\View $this
 * @var webvimark\modules\UserManagement\models\forms\ChangeOwnPasswordForm $model
 */

$this->title = UserManagementModule::t('back', 'Change own password');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="change-own-password">
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="user-form">
                <div class="row">
                    <div class="col-md-12">
                        <div class="alert-warning alert fade in">
                            <i class="icon fa fa-exclamation"></i> É altamente recomendável que você mude sua senha no primeiro acesso ao sistema.
                        </div>
                    </div>
                </div>

                <?php $form = ActiveForm::begin([
                    'id'=>'user',
                    'layout'=>'horizontal',
                    'validateOnBlur'=>false,
                ]); ?>

                <?= $form->field($model, 'password')->passwordInput(['maxlength' => 255, 'autocomplete'=>'off']) ?>

                <?= $form->field($model, 'repeat_password')->passwordInput(['maxlength' => 255, 'autocomplete'=>'off']) ?>


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

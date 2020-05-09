<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\ContatoCliente */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="contato-cliente-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'fk_cliente')->textInput() ?>

    <?= $form->field($model, 'fk_departamento')->textInput() ?>

    <?= $form->field($model, 'fk_cargo')->textInput() ?>

    <?= $form->field($model, 'nome')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'email')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'foto')->textInput(['maxlength' => true]) ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

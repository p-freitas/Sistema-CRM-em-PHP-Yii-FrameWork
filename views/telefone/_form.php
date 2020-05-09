<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Telefone */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="telefone-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'fk_contato_cliente')->textInput() ?>

    <?= $form->field($model, 'fk_tipo_telefone')->textInput() ?>

    <?= $form->field($model, 'telefone')->textInput(['maxlength' => true]) ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

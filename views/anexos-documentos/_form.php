<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\AnexosDocumentos */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="anexos-documentos-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'fk_tipo_documento')->textInput() ?>

    <?= $form->field($model, 'fk_cliente')->textInput() ?>

    <?= $form->field($model, 'anexo')->textInput(['maxlength' => true]) ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

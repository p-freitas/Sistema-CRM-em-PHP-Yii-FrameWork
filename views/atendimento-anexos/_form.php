<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\AtendimentoAnexos */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="atendimento-anexos-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'fk_atendimento')->textInput() ?>

    <?= $form->field($model, 'anexo')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'descricao')->textInput(['maxlength' => true]) ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

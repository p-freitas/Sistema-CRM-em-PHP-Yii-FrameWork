<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\AditivoSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="aditivo-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'fk_contrato') ?>

    <?= $form->field($model, 'numero') ?>

    <?= $form->field($model, 'data_inicio') ?>

    <?= $form->field($model, 'data_termino') ?>

    <?php // echo $form->field($model, 'valor') ?>

    <?php // echo $form->field($model, 'justificativa') ?>

    <?php // echo $form->field($model, 'anexo') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

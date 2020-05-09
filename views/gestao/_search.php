<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\GestaoSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="gestao-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'fk_cliente') ?>

    <?= $form->field($model, 'periodo') ?>

    <?= $form->field($model, 'prefeito') ?>

    <?= $form->field($model, 'data_nascimento') ?>

    <?php // echo $form->field($model, 'vice_prefeito') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

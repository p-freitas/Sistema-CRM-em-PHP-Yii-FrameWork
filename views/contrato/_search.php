<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\ContratoSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="contrato-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'fk_cliente') ?>

    <?= $form->field($model, 'fk_modalidade') ?>

    <?= $form->field($model, 'data_inicio') ?>

    <?= $form->field($model, 'data_termino') ?>

    <?php // echo $form->field($model, 'valor_global') ?>

    <?php // echo $form->field($model, 'valor_mensal') ?>

    <?php // echo $form->field($model, 'anexo') ?>

    <?php // echo $form->field($model, 'status') ?>

    <?php // echo $form->field($model, 'objeto') ?>

    <?php // echo $form->field($model, 'numero') ?>

    <?php // echo $form->field($model, 'info_complementar') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

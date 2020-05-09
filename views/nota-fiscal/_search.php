<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\NotaFiscalSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="nota-fiscal-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'fk_cliente') ?>

    <?= $form->field($model, 'fk_usuario') ?>

    <?= $form->field($model, 'numero_nota') ?>

    <?= $form->field($model, 'data_emissao') ?>

    <?php // echo $form->field($model, 'competencia') ?>

    <?php // echo $form->field($model, 'descricao_servico') ?>

    <?php // echo $form->field($model, 'valor') ?>

    <?php // echo $form->field($model, 'aliquota_iss') ?>

    <?php // echo $form->field($model, 'valor_iss') ?>

    <?php // echo $form->field($model, 'condicao_pagamento') ?>

    <?php // echo $form->field($model, 'info_complementar') ?>

    <?php // echo $form->field($model, 'rastreamento') ?>

    <?php // echo $form->field($model, 'data_entrega') ?>

    <?php // echo $form->field($model, 'situacao') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

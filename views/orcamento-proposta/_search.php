<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\OrcamentoPropostaSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="orcamento-proposta-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'fk_cliente') ?>

    <?= $form->field($model, 'fk_contato_cliente') ?>

    <?= $form->field($model, 'implantacao_parcela') ?>

    <?= $form->field($model, 'implantacao_valor') ?>

    <?php // echo $form->field($model, 'validade') ?>

    <?php // echo $form->field($model, 'obs') ?>

    <?php // echo $form->field($model, 'data') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

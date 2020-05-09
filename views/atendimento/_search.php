<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\AtendimentoSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="atendimento-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'fk_cliente') ?>

    <?= $form->field($model, 'fk_contato_cliente') ?>

    <?= $form->field($model, 'fk_usuario') ?>

    <?= $form->field($model, 'fk_usuario_solucao') ?>

    <?php // echo $form->field($model, 'fk_contrato') ?>

    <?php // echo $form->field($model, 'fk_produto') ?>

    <?php // echo $form->field($model, 'fk_tipo_atendimento') ?>

    <?php // echo $form->field($model, 'fk_tipo_ocorrencia') ?>

    <?php // echo $form->field($model, 'data_atendimento') ?>

    <?php // echo $form->field($model, 'status') ?>

    <?php // echo $form->field($model, 'solicitacao') ?>

    <?php // echo $form->field($model, 'solucao') ?>

    <?php // echo $form->field($model, 'data_solucao') ?>

    <?php // echo $form->field($model, 'numero_atendimento') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

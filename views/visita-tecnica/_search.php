<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\VisitaTecnicaSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="visita-tecnica-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'fk_user') ?>

    <?= $form->field($model, 'fk_cliente') ?>

    <?= $form->field($model, 'fk_produto') ?>

    <?= $form->field($model, 'data') ?>

    <?php // echo $form->field($model, 'solicitante') ?>

    <?php // echo $form->field($model, 'agendamento') ?>

    <?php // echo $form->field($model, 'situacao') ?>

    <?php // echo $form->field($model, 'data_situacao') ?>

    <?php // echo $form->field($model, 'motivo') ?>

    <?php // echo $form->field($model, 'ocorrencias') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

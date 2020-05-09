<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\BloqueioSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="bloqueio-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'fk_cliente') ?>

    <?= $form->field($model, 'fk_contrato') ?>

    <?= $form->field($model, 'fk_produto') ?>

    <?= $form->field($model, 'fk_usuario') ?>

    <?php // echo $form->field($model, 'data_bloqueio') ?>

    <?php // echo $form->field($model, 'data_limite') ?>

    <?php // echo $form->field($model, 'status') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\RequestsSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="requests-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'nome_arquivo') ?>

    <?= $form->field($model, 'ip') ?>

    <?= $form->field($model, 'data_ini_req') ?>

    <?= $form->field($model, 'data_fim_req') ?>

    <?php // echo $form->field($model, 'status') ?>

    <?php // echo $form->field($model, 'mensagem') ?>

    <div class="form-group">
        <?= Html::submitButton(Yii::t('app', 'Search'), ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton(Yii::t('app', 'Reset'), ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

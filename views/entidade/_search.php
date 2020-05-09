<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\EntidadeSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="entidade-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'cnpj') ?>

    <?= $form->field($model, 'razao_social') ?>

    <?= $form->field($model, 'nome_fantasia') ?>

    <?= $form->field($model, 'insc_municipal') ?>

    <?php // echo $form->field($model, 'logo_marca') ?>

    <?php // echo $form->field($model, 'cep') ?>

    <?php // echo $form->field($model, 'estado') ?>

    <?php // echo $form->field($model, 'cidade') ?>

    <?php // echo $form->field($model, 'bairro') ?>

    <?php // echo $form->field($model, 'endereco') ?>

    <?php // echo $form->field($model, 'complemento') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

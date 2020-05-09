<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\ClienteSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="cliente-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'fk_entidade') ?>

    <?= $form->field($model, 'fk_tipo_cliente') ?>

    <?= $form->field($model, 'fk_tipo_orgao') ?>

    <?= $form->field($model, 'fk_representante') ?>

    <?php // echo $form->field($model, 'cpf_cnpj') ?>

    <?php // echo $form->field($model, 'razao_social') ?>

    <?php // echo $form->field($model, 'email') ?>

    <?php // echo $form->field($model, 'cep') ?>

    <?php // echo $form->field($model, 'estado') ?>

    <?php // echo $form->field($model, 'cidade') ?>

    <?php // echo $form->field($model, 'bairro') ?>

    <?php // echo $form->field($model, 'endereco') ?>

    <?php // echo $form->field($model, 'complemento') ?>

    <?php // echo $form->field($model, 'data_situacao') ?>

    <?php // echo $form->field($model, 'data_cadastro') ?>

    <?php // echo $form->field($model, 'situacao') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

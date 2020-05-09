<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\search\FinanceiroSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="financeiro-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'fk_nota_fiscal') ?>

    <?= $form->field($model, 'fk_cliente') ?>

    <?= $form->field($model, 'fk_conta') ?>

    <?= $form->field($model, 'fk_tipo_documento') ?>

    <?php // echo $form->field($model, 'fk_banco_portador') ?>

    <?php // echo $form->field($model, 'fk_conta_orcamento') ?>

    <?php // echo $form->field($model, 'numero_titulo') ?>

    <?php // echo $form->field($model, 'data_emissao') ?>

    <?php // echo $form->field($model, 'tipo') ?>

    <?php // echo $form->field($model, 'vencimento') ?>

    <?php // echo $form->field($model, 'valor_titulo') ?>

    <?php // echo $form->field($model, 'valor_pgto') ?>

    <?php // echo $form->field($model, 'data_pgto') ?>

    <?php // echo $form->field($model, 'valor_desconto') ?>

    <?php // echo $form->field($model, 'data_dev') ?>

    <?php // echo $form->field($model, 'valor_dev') ?>

    <?php // echo $form->field($model, 'saldo') ?>

    <?php // echo $form->field($model, 'obs') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

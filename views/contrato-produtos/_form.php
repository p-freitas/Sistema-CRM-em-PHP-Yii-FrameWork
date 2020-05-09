<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\ContratoProdutos */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="contrato-produtos-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'fk_contrato')->textInput() ?>

    <?= $form->field($model, 'fk_produto')->textInput() ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

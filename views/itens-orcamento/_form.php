<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\ItensOrcamento */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="itens-orcamento-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'fk_orcamento')->textInput() ?>

    <?= $form->field($model, 'fk_produto')->textInput() ?>

    <?= $form->field($model, 'quantidade')->textInput() ?>

    <?= $form->field($model, 'valor_unitario')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'valor_total')->textInput(['maxlength' => true]) ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Bloqueio */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="bloqueio-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'fk_cliente')->textInput() ?>

    <?= $form->field($model, 'fk_contrato')->textInput() ?>

    <?= $form->field($model, 'fk_produto')->textInput() ?>

    <?= $form->field($model, 'fk_usuario')->textInput() ?>

    <?= $form->field($model, 'data_bloqueio')->textInput() ?>

    <?= $form->field($model, 'data_limite')->textInput() ?>

    <?= $form->field($model, 'status')->textInput() ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

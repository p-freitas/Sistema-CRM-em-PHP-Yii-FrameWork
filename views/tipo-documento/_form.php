<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\select2\Select2;

/* @var $this yii\web\View */
/* @var $model app\models\TipoDocumento */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="tipo-documento-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="col-md-4">
        <?= $form->field($model, 'tipo')->widget(Select2::classname(), [
            'theme' => 'bootstrap',
            'language' => 'pt-BR',
            'options' => ['placeholder' => 'Selecione'],
            'pluginOptions' => ['allowClear'=>true],
            'data' => \yii\helpers\ArrayHelper::map(\app\models\TipoDocumento::find()->asArray()->all(), 'id', 'descricao'),
        ])->label('Tipo')?>
    </div>

    <div class="col-md-8">
        <?= $form->field($model, 'descricao')->textInput(['maxlength' => true])->label('Descrição') ?>
    </div>

    <div class="form-group">
        <?= Html::submitButton('Salvar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

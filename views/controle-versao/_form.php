<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\ControleVersao */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="controle-versao-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'fk_usuario')->widget(\kartik\select2\Select2::className(),[
                'theme' => 'bootstrap',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions'=>['allowClear'=>true],
                'language' => 'pt-BR',
                'data' => \yii\helpers\ArrayHelper::map(\app\models\Usuario::find()->asArray()->all(), 'id', 'nome_completo'),
            ])->label('Usuário') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'fk_produto')->widget(\kartik\select2\Select2::className(), [
                'theme' => 'bootstrap',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear' => true],
                'language' => 'pt-BR',
                'data' => \yii\helpers\ArrayHelper::map(\app\models\Produto::find()->asArray()->all(), 'id', 'descricao'),
            ])->label('Produto') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'data_hora')->widget(\kartik\daterange\DateRangePicker::className(), [
                'pluginOptions' => [
                    'language'=>'pt-br',
                    'singleDatePicker' => true,
                    'locale'=>['format' => 'DD/MM/YYYY'],
                    'showDropdowns' => true
                ]
            ])->widget(\yii\widgets\MaskedInput::className(), [
                'clientOptions' => [
                    'alias' => 'date',
                    'clearIncomplete' => true,
                    'placeholder' => '__/__/____'
                ],

            ])->label('Data') ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <?= $form->field($model, 'descricao')->textarea(['rows' => 6]) ?>
        </div>

        <div class="col-md-6">
            <?= $form->field($model, 'script')->textarea(['rows' => 6]) ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'numero_versao')->textInput(['maxlength' => true]) ?>
        </div>
    </div>

    <br>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

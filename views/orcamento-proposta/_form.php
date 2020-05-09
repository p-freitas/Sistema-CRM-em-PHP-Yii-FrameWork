<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\select2\Select2;

/* @var $this yii\web\View */
/* @var $model app\models\OrcamentoProposta */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="orcamento-proposta-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'fk_cliente')->widget(Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear'=>true],
                'data' => \yii\helpers\ArrayHelper::map(\app\models\Cliente::find()->asArray()->all(), 'id', 'nome_fantasia'),
            ])->label('Cliente')?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'fk_contato_cliente')->widget(Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear'=>true],
                'data' => \yii\helpers\ArrayHelper::map(\app\models\ContatoCliente::find()->asArray()->all(), 'id', 'email'),
            ])->label('Contato')?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'implantacao_parcela')->textInput(['maxlength' => true])->label('Parcelas da implantação') ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'implantacao_valor')->textInput(['maxlength' => true])->label('Valor da implantação') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'validade')->textInput()->label('Validade') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'data')->widget(\kartik\daterange\DateRangePicker::className(), [
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

        <div class="col-md-12">
            <?= $form->field($model, 'obs')->textarea(['rows' => 6])->label('Observações') ?>
        </div>

    </div>




    <div class="form-group">
        <?= Html::submitButton('Salvar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

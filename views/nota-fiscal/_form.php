<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\select2\Select2;

/* @var $this yii\web\View */
/* @var $model app\models\NotaFiscal */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="nota-fiscal-form">

    <?php $form = ActiveForm::begin(); ?>
        <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'fk_cliente')->widget(Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear'=>true],
                'data' => \app\modules\Helper::map(\app\models\Cliente::find()->findClienteByEntidade()->orderBy([\app\models\Cliente::tableName().'.nome_fantasia' => SORT_ASC])->asArray()->all(), 'id', 'nome_fantasia')
            ])->label('Cliente')?>
        </div>

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
            <?= $form->field($model, 'numero_nota')->textInput(['maxlength' => true])->label('Número da nota') ?>
        </div>
    </div>


    <div class="row">
        <div class="col-md-6">
            <?= $form->field($model, 'data_emissao')->widget(\kartik\daterange\DateRangePicker::className(), [
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

            ]) ?>
        </div>

        <div class="col-md-6">
            <?= $form->field($model, 'competencia')->widget(\kartik\daterange\DateRangePicker::className(), [
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

            ]) ?>
        </div>

    </div>

    <div class="row">
        <div class="col-md-12">
            <?= $form->field($model, 'descricao_servico')->textarea(['rows' => 6])->label('Descrição do serviço') ?>
        </div>

    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'valor')
                ->textInput(['maxlength' => true])
                ->label('Valor')
            ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'aliquota_iss')
                ->textInput(['maxlength' => true])
                ->label('Aliquota Iss')
            ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'valor_iss')
                ->textInput(['maxlength' => true])
                ->label('Valor Iss')
            ?>
        </div>

    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'condicao_pagamento')->textInput(['maxlength' => true])->label('Condição do pagamento') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'info_complementar')->textInput(['maxlength' => true])->label('Informação complementar') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'rastreamento')->textInput(['maxlength' => true]) ?>
        </div>

    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'data_entrega')->widget(\kartik\daterange\DateRangePicker::className(), [
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

            ])->label('Data de entrega') ?>
        </div>

        <div class="col-md-4">
            <?php if(!$model->isNewRecord){ ?>
                <div class="col-md-2">
                    <?= $form->field($model, 'situacao')->textInput()->dropDownList(['1' => 'Ativo', '0' => 'Inativo'],['prompt'=>'Selecione']) ?>
                </div>
            <?php } ?>
        </div>

    </div>

    <div class="form-group">

        <?= Html::submitButton('Salvar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

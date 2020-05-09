<?php

use kartik\select2\Select2;
use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\datetime\DateTimePicker;

/* @var $this yii\web\View */
/* @var $model app\models\VisitaTecnica */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="visita-tecnica-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'fk_cliente')->widget(Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear' => true],
                'data' => \app\modules\Helper::map(\app\models\Cliente::find()->findClienteByEntidade()->orderBy([\app\models\Cliente::tableName() . '.nome_fantasia' => SORT_ASC])->asArray()->all(), 'id', 'nome_fantasia')
            ])->label('Cliente') ?>
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
            <?= $form->field($model, 'fk_usuario')->widget(\kartik\select2\Select2::className(), [
                'theme' => 'bootstrap',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear' => true],
                'language' => 'pt-BR',
                'data' => \yii\helpers\ArrayHelper::map(\app\models\Usuario::find()->asArray()->all(), 'id', 'nome_completo'),
            ])->label('Usuário') ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'data')->widget(DateTimePicker::className(), [
                'type' => DateTimePicker::TYPE_INPUT,
                'pluginOptions' => [
                    'language' => 'pt-br',
                    'autoclose' => true,
                    'format' => 'dd-mm-yyyy hh:ii'
                ]
            ])->widget(\yii\widgets\MaskedInput::className(), [
                'clientOptions' => [
                    'alias' => 'datetime',
                    'clearIncomplete' => true,
                    'placeholder' => '__/__/____ __:__'
                ],

            ])->label('Data') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'solicitante')->textInput(['maxlength' => true]) ?>
        </div>

            <div class="col-md-4">
                <?= $form->field($model, 'agendamento')->widget(DateTimePicker::className(), [
                    'type' => DateTimePicker::TYPE_INPUT,
                    'pluginOptions' => [
                        'language' => 'pt-br',
                        'autoclose' => true,
                        'format' => 'dd-mm-yyyy hh:ii'
                    ]
                ])->widget(\yii\widgets\MaskedInput::className(), [
                    'clientOptions' => [
                        'alias' => 'datetime',
                        'clearIncomplete' => true,
                        'placeholder' => '__/__/____ __:__'
                    ],

                ])->label('Agendamento') ?>
            </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <?= $form->field($model, 'motivo')->textarea(['rows' => 6]) ?>
        </div>

        <div class="col-md-6">
            <?= $form->field($model, 'ocorrencias')->textarea(['rows' => 6]) ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'data_situacao')->widget(DateTimePicker::className(), [
                'type' => DateTimePicker::TYPE_INPUT,
                'pluginOptions' => [
                    'language' => 'pt-br',
                    'autoclose' => true,
                    'format' => 'dd-mm-yyyy hh:ii'
                ]
            ])->widget(\yii\widgets\MaskedInput::className(), [
                'clientOptions' => [
                    'alias' => 'datetime',
                    'clearIncomplete' => true,
                    'placeholder' => '__/__/____ __:__'
                ],

            ])->label('Agendamento') ?>
        </div>
        <div class="col-md-3">
            <?= $form->field($model, 'situacao')->textInput()->dropDownList(['1' => 'Ativo', '0' => 'Inativo'], ['prompt' => 'Selecione']) ?>
        </div>
    </div>








    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

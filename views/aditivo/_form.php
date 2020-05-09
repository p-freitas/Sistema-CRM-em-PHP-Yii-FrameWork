<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Aditivo */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="aditivo-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <div class="col-md-3">
            <?= $form->field($model, 'fk_contrato')->widget(\kartik\select2\Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear'=>true],
                'data' => \app\modules\Helper::map(\app\models\Contrato::find()->orderBy([\app\models\Contrato::tableName().'.numero' => SORT_ASC])->asArray()->all(), 'id', 'numero')
            ])?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'numero')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'valor')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-md-2">
            <?= $form->field($model, 'data_inicio')->widget(\kartik\daterange\DateRangePicker::className(), [
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
        <div class="col-md-2">
            <?= $form->field($model, 'data_termino')->widget(\kartik\daterange\DateRangePicker::className(), [
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

    <?= $form->field($model, 'justificativa')->textarea(['rows' => 3]) ?>

    <div class="row">
        <div class="col-md-3">
            <?= $form->field($model, 'anexo')->widget(\kartik\file\FileInput::classname(), [
                'options' => ['accept' => '*'],
                'language' => 'pt',
                'pluginOptions' => [
                    'showUpload' => false,
                    'showPreview' => false,
                    'showRemove' => true,
                    'browseLabel' => '',
                    'removeLabel' => '',
                    'initialCaption' => empty($model->anexo) ? '' : explode('/',$model->anexo)[7],
                ],
            ]) ?>
        </div>
    </div>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

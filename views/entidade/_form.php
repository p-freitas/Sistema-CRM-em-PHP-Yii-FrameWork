<?php

use kartik\file\FileInput;
use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;

/* @var $this yii\web\View */
/* @var $model app\models\Entidade */
/* @var $form yii\widgets\ActiveForm */

$estado =  empty($model->fk_estado) ? '' : \app\models\Estado::findOne($model->fk_estado);
?>

<div class="entidade-form">

    <?php $form = ActiveForm::begin(['options' => ['enctype' => 'multipart/form-data']]); ?>

    <div class="row">
        <div class="col-md-2">
            <?= $form->field($model, 'cnpj')->widget(\yii\widgets\MaskedInput::className(), [
                'mask' => '99.999.999/9999-99'
            ]) ?>
        </div>
        <div class="col-md-10">
            <?= $form->field($model, 'insc_municipal')->textInput(['maxlength' => true]) ?>
        </div>

    </div>
    <div class="row">
        <div class="col-md-6">
            <?= $form->field($model, 'razao_social')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-md-6">
            <?= $form->field($model, 'nome_fantasia')->textInput(['maxlength' => true]) ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-2">
            <?= $form->field($model, 'cep')->widget(\yii\widgets\MaskedInput::className(), [
                'mask' => '99999-999'
            ])->widget(\yiibr\correios\CepInput::className(), [
                'action' => ['//site/addressSearch'],
                'fields' => [
                    'city' => 'entidade-cidade',
                    'state' => 'entidade-estado',
                    'location' => 'entidade-endereco',
                    'district' => 'entidade-bairro',
                ],
            ]) ?>
        </div>
        <div class="col-md-5">
            <?= $form->field($model, 'estado')->textInput(['maxlength' => true, 'readonly' => true]) ?>
        </div>
        <div class="col-md-5">
            <?= $form->field($model, 'cidade')->textInput(['maxlength' => true, 'readonly' => true]) ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($model, 'bairro')->textInput(['maxlength' => true, 'readonly' => true]) ?>
        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'endereco')->textInput(['maxlength' => true, 'readonly' => true]) ?>
        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'complemento')->textInput(['maxlength' => true]) ?>
        </div>
    </div>

    <div class="row">

        <div class="col-md-4">
            <?= $form->field($model, 'logo_marca')->widget(FileInput::classname(), [
                'options' => ['accept' => 'image/*'],
                'language' => 'pt',
                'pluginOptions' => [
                    'uploadUrl' => Url::to(['web/img']),
                    'showUpload' => false,
                    'showPreview' => false,
                    'showRemove' => true,
                    'browseLabel' => '',
                    'removeLabel' => '',
                    'allowedFileExtensions' => ['jpg', 'gif', 'png', 'jpeg'],
                    'initialCaption' => empty($model->logo_marca) ? '' : explode('/', $model->logo_marca)[7],
                ],
            ]) ?>

        </div>
    </div>


    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? Yii::t('app', 'Create') : Yii::t('app', 'Update'), ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

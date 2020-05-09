<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use kartik\select2\Select2;

/* @var $this yii\web\View */
/* @var $model app\models\Banco */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="banco-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <div class="col-md-6">
            <?= $form->field($model, 'fk_entidade')->widget(Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear'=>true],
                'data' => \yii\helpers\ArrayHelper::map(\app\models\Entidade::find()->asArray()->all(), 'id', 'nome_fantasia'),
            ])->label('Entidade')?>
        </div>

        <div class="col-md-6">
            <?= $form->field($model, 'codigo')->textInput()->label('Código') ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <?= $form->field($model, 'descricao')->textInput(['maxlength' => true])->label('Descrição') ?>
        </div>
    </div>

    <div class="form-group">
        <?= Html::submitButton('Salvar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

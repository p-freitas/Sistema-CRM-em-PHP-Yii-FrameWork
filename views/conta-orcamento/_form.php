<?php

use kartik\select2\Select2;
use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\ContaOrcamento */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="conta-orcamento-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">

        <div class="col-md-4">
            <?= $form->field($model, 'fk_entidade')->widget(Select2::classname(), [
                'theme' => 'bootstrap',
                'language' => 'pt-BR',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear'=>true],
                'data' => \yii\helpers\ArrayHelper::map(\app\models\Entidade::find()->asArray()->all(), 'id', 'nome_fantasia'),
            ])->label('Entidade')?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'numero')->textInput(['maxlength' => true])->label('Número') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'codigo')->textInput(['maxlength' => true])->label('Código') ?>
        </div>
    </div>

    <div class="row">

        <div class="col-md-4">
            <?= $form->field($model, 'descricao')->textInput()->label('Descrição') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'tipo')->dropDownList(['1' => 'Entrada', '0' => 'Saída'],['prompt'=>'Selecione'])->label('Tipo do Orçamento') ?>
        </div>

        <div class="col-md-4">
            <?= $form->field($model, 'tipo_lancamento')->dropDownList(['1' => 'Sim', '0' => 'Não'],['prompt'=>'Selecione'])->label('Tipo do Orçamento') ?>
        </div>
    </div>

    <div class="form-group">
        <?= Html::submitButton('Salvar', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

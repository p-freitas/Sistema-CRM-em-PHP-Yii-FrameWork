<?php

use kartik\select2\Select2;
use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\TipoAtendimento */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="tipo-atendimento-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <?php if ((Yii::$app->user->isSuperadmin)) { ?>
            <div class="col-md-6">
                <?= $form->field($model, 'fk_entidade')->widget(Select2::classname(), [
                    'theme' => 'bootstrap',
                    'language' => 'pt-BR',
                    'options' => ['placeholder' => 'Selecione'],
                    'pluginOptions' => ['allowClear'=>true],
                    'data' => \yii\helpers\ArrayHelper::map(\app\models\Entidade::find()->asArray()->all(), 'id', 'nome_fantasia'),
                ])->label('Entidade')?>
            </div>
        <?php } ?>

        <div class="col-md-6">
            <?= $form->field($model, 'descricao')->textInput(['maxlength' => true])->label('Descrição') ?>
        </div>
    </div>

    <br>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

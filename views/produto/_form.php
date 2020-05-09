<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Produto */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="produto-form">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <?php if(Yii::$app->user->isSuperadmin){ ?>
            <div class="col-md-3">
                <?= $form->field($model, 'fk_entidade')->widget(\kartik\select2\Select2::classname(), [
                    'theme' => 'bootstrap',
                    'language' => 'pt-BR',
                    'options' => ['placeholder' => 'Selecione'],
                    'pluginOptions' => ['allowClear'=>true],
                    'data' => \app\modules\Helper::map(\app\models\Entidade::find()->orderBy([\app\models\Entidade::tableName().'.nome_fantasia' => SORT_ASC])->asArray()->all(), 'id', 'nome_fantasia')
                ])->label('Empresa') ?>
            </div>
        <?php } ?>
    </div>

    <div class="row">
        <div class="col-md-3">
            <?= $form->field($model, 'codigo')->textInput(['maxlength' => true]) ?>
        </div>
        <div class="col-md-9">
            <?= $form->field($model, 'descricao')->textInput(['maxlength' => true]) ?>
        </div>
    </div>


    <div class="form-group">
        <?= Html::submitButton(Yii::t('app', 'Save'), ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

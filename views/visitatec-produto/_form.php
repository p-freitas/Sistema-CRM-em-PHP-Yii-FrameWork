<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\VisitaTecProduto */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="visita-tec-produto-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'fk_visita')->textInput() ?>

    <?= $form->field($model, 'fk_produto')->textInput() ?>

    <div class="form-group">
        <?= Html::submitButton('Save', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>

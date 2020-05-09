<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\TipoAtendimento */

$this->title = 'Update Tipo Atendimento: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Tipo Atendimentos', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="tipo-atendimento-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

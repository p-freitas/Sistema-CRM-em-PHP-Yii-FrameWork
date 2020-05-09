<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\TipoOcorrencia */

$this->title = 'Update Tipo Ocorrencia: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Tipo Ocorrencias', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="tipo-ocorrencia-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

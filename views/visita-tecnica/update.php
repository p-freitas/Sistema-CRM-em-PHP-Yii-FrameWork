<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\VisitaTecnica */

$this->title = 'Update Visita Tecnica: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Visita Tecnicas', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="visita-tecnica-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

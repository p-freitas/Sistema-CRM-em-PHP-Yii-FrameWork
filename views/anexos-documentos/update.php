<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\AnexosDocumentos */

$this->title = 'Update Anexos Documentos: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Anexos Documentos', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="anexos-documentos-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Bloqueio */

$this->title = 'Update Bloqueio: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Bloqueios', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="bloqueio-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

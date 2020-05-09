<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Banco */

$this->title = 'Atualizar';
$this->params['breadcrumbs'][] = ['label' => 'Bancos', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="banco-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

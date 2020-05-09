<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Financeiro */

//d($model->getErrors());

$this->title = 'Atualizar';
$this->params['breadcrumbs'][] = ['label' => 'Financeiros', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="financeiro-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

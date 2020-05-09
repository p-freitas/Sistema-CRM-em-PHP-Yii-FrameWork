<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\OrcamentoProposta */

$this->title = 'Atualizar';
$this->params['breadcrumbs'][] = ['label' => 'Orcamento Propostas', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="orcamento-proposta-update">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

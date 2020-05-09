<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\ItensOrcamento */

$this->title = 'Update Itens Orcamento: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Itens Orcamentos', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="itens-orcamento-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

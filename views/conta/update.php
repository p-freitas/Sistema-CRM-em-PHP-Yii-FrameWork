<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Conta */

$this->title = 'Atualizar';
$this->params['breadcrumbs'][] = ['label' => 'Contas', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="conta-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

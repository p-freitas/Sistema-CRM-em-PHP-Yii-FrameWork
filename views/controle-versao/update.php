<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\ControleVersao */

$this->title = 'Update Controle Versao: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Controle Versaos', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="controle-versao-update">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

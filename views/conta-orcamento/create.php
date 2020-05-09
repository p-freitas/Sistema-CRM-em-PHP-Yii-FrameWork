<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\ContaOrcamento */

$this->params['breadcrumbs'][] = ['label' => 'Conta Orcamentos', 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo Orçamento';
$this->title = 'Criar novo orçamento';
?>
<div class="conta-orcamento-create">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

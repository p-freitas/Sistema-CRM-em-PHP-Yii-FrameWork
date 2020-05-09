<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\OrcamentoProposta */

$this->title = 'Criar novo orçamento';
$this->params['breadcrumbs'][] = ['label' => 'Orcamento Propostas', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="orcamento-proposta-create">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

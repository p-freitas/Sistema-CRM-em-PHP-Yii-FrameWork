<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\NotaFiscal */


$this->params['breadcrumbs'][] = ['label' => 'Nota Fiscals', 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Nova Nota Fiscal';
$this->title = 'Criar nova nota fiscal';
?>
<div class="nota-fiscal-create">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

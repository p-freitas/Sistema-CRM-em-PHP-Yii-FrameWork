<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\ContratoProdutos */

$this->title = 'Create Contrato Produtos';
$this->params['breadcrumbs'][] = ['label' => 'Contrato Produtos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="contrato-produtos-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

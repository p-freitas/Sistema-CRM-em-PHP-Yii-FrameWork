<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\VisitaTecProduto */

$this->title = 'Create Visita Tec Produto';
$this->params['breadcrumbs'][] = ['label' => 'Visita Tec Produtos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="visita-tec-produto-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Produto */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Produtos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo Produto';
$this->title = 'Criar novo produto';
?>
<div class="produto-create">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

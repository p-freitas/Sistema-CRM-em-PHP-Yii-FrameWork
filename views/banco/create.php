<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Banco */

$this->title = 'Criar novo banco';
$this->params['breadcrumbs'][] = ['label' => 'Bancos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="banco-create">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

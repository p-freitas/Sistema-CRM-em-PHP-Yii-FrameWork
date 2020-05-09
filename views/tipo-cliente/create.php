<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\TipoCliente */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Tipos Cliente'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo Tipo Cliente';
$this->title = 'Criar novo tipo';
?>
<div class="tipo-cliente-create">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

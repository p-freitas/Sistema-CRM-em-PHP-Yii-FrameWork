<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Departamento */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Departamentos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo Departamento';
$this->title = 'Criar novo departamento';
?>
<div class="departamento-create">



    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

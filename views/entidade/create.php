<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Entidade */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Entidades'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo Orçamento';
$this->title = 'Criar nova entidade';
?>
<div class="entidade-create">
    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>
</div>

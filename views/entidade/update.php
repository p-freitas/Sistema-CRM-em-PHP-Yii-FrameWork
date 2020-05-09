<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Entidade */

$this->title = 'Atualizar';
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Entidades'), 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->razao_social, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = Yii::t('app', 'Update');
?>
<div class="entidade-update">
    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

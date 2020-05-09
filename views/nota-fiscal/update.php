<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\NotaFiscal */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Notas Fiscais'), 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = Yii::t('app', 'Update');
$this->title = 'Atualizar';
?>
<div class="nota-fiscal-update">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

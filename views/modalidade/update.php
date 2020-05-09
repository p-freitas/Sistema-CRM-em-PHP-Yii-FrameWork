<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Modalidade */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Modalidades'), 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->descricao, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = Yii::t('app', 'Update');
$this->title = 'Atualizar';
?>
<div class="modalidade-update">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

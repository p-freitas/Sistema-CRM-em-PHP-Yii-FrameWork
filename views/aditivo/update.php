<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Aditivo */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Aditivos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->numero, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = Yii::t('app', 'Update');
?>
<div class="aditivo-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

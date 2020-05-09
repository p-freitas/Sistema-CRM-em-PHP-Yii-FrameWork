<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Financeiro */

$this->title = '';
$this->params['breadcrumbs'][] = ['label' => 'Financeiros', 'url' => ['index']];

//ddd($model->getErrors());

?>
<div class="financeiro-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

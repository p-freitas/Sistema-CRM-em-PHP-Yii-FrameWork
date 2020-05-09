<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Bloqueio */

$this->title = 'Create Bloqueio';
$this->params['breadcrumbs'][] = ['label' => 'Bloqueios', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="bloqueio-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Gestao */

$this->title = 'Create Gestao';
$this->params['breadcrumbs'][] = ['label' => 'Gestaos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="gestao-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

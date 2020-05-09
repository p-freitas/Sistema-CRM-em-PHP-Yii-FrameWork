<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\VisitaTecnica */

$this->title = 'Create Visita Tecnica';
$this->params['breadcrumbs'][] = ['label' => 'Visita Tecnicas', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="visita-tecnica-create">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\TipoOcorrencia */

$this->title = 'Create Tipo Ocorrencia';
$this->params['breadcrumbs'][] = ['label' => 'Tipo Ocorrencias', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="tipo-ocorrencia-create">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

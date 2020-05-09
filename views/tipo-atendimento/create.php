<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\TipoAtendimento */

$this->title = 'Create Tipo Atendimento';
$this->params['breadcrumbs'][] = ['label' => 'Tipo Atendimentos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="tipo-atendimento-create">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

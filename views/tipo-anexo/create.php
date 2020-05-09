<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\TipoAnexo */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Tipos Anexo'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo Tipo Anexo';
$this->title = 'Criar novo tipo';
?>
<div class="tipo-anexo-create">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

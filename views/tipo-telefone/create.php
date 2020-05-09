<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\TipoTelefone */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Telefones'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo Tipo Telefone';
$this->title = 'Criar novo tipo';
?>
<div class="tipo-telefone-create">



    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

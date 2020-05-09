<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\TipoOrgao */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Tipos Orgãos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo Tipo Orgão';
$this->title = 'Criar novo tipo';
?>
<div class="tipo-orgao-create">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

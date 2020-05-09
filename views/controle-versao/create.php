<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\ControleVersao */

$this->title = 'Create Controle Versao';
$this->params['breadcrumbs'][] = ['label' => 'Controle Versaos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="controle-versao-create">


    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

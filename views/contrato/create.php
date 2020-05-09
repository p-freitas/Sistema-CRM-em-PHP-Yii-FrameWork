<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Contrato */


$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Contratos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Criar contrato';
$this->title = 'Criar novo contrato';
?>
<div class="contrato-create">


    <?= $this->render('_form', [
        'model' => $model,
        'modelProduto' => $modelProduto,
        'modelsAditivo' => $modelsAditivo,
        'aditivo' => $aditivo,
    ]) ?>

</div>

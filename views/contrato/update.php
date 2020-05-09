<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Contrato */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Contratos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->numero, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = Yii::t('app', 'Update');
$this->title = 'Atualizar';
?>
<div class="contrato-update">



    <?= $this->render('_form', [
        'model' => $model,
        'modelProduto' => $modelProduto,
        'modelsAditivo' => $modelsAditivo,
        'aditivo' => $aditivo,
    ]) ?>

</div>

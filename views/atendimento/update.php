<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Atendimento */
/* @var $modelsAnexo \app\models\AtendimentoAnexos */
/* @var $modelAnexo \app\models\AtendimentoAnexos */

//ddd($model->getErrors());

$this->title = 'Atualizar';
$this->params['breadcrumbs'][] = ['label' => 'Atendimentos', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = Yii::t('app', 'Update');
?>
<div class="atendimento-update">


    <?= $this->render('_form', [
        'view' => null,
        'model' => $model,
        'modelAnexo' => $modelAnexo,
        'modelOcorrencia' => $modelOcorrencia,

    ]) ?>

</div>

<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Atendimento */
/* @var $modelOcorrencia \app\models\TipoOcorrencia */
/* @var $modelAnexo \app\models\AtendimentoAnexos */
/* @var $modelsAnexo [\app\models\AtendimentoAnexos] */

//ddd($model->getErrors());
$this->params['breadcrumbs'][] = ['label' => 'Atendimentos', 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo atendimento';
$this->title = 'Criar novo atendimento';
?>
<div class="atendimento-create">


    <?= $this->render('_form', [
        'modelsAnexo' => $modelsAnexo,
        'model' => $model,
        'modelAnexo' => $modelAnexo,
        'modelOcorrencia' => $modelOcorrencia,
    ]) ?>

</div>

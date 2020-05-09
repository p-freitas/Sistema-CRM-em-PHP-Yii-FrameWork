<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model app\models\Cliente */
/* @var $modelContato app\models\ContatoCliente */
/* @var $modelGestao \app\models\Gestao */
/* @var $modelTelefone app\models\Telefone */
/* @var $modelsAnexoDocumento app\models\AnexosDocumentos */
/* @var $gestoes \app\models\Gestao */
/* @var $telefones app\models\Telefone */


$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Clientes'), 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->razao_social, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = Yii::t('app', 'Update');
$this->title = 'Atualizar';
?>
<div class="cliente-update">


    <?= $this->render('_form', [
        'view' => null,
        'model' => $model,
        'modelContato' => $modelContato,
        'modelGestao' => $modelGestao,
        'modelTelefone' => $modelTelefone,
        'modelsAnexoDocumento' => $modelsAnexoDocumento,
        'contatos' => $contatos,
        'telefones' => $telefones,
        'gestoes' => $gestoes,
    ]) ?>

</div>

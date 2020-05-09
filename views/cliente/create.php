<?php

use app\models\AnexosDocumentos;
use app\models\ContatoCliente;
use app\models\Telefone;
use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Cliente */
/* @var $modelContato app\models\ContatoCliente */
/* @var $modelGestao \app\models\Gestao */
/* @var $modelTelefone app\models\Telefone */
/* @var $modelsAnexoDocumento app\models\AnexosDocumentos */
/* @var $gestoes \app\models\Gestao */
/* @var $telefones app\models\Telefone */

$this->title = "Novo cliente";
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Clientes'), 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Novo Cliente';
?>
<div class="cliente-create">

    <?= $this->render('_form', [
        'view' => $view,
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

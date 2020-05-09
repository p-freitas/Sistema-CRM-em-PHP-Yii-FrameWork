<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\ContatoCliente */

$this->title = 'Create Contato Cliente';
$this->params['breadcrumbs'][] = ['label' => 'Contato Clientes', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;

ddd($model->getErrors());

?>
<div class="contato-cliente-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

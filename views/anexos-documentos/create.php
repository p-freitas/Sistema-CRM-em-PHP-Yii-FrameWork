<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\AnexosDocumentos */

$this->title = 'Create Anexos Documentos';
$this->params['breadcrumbs'][] = ['label' => 'Anexos Documentos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="anexos-documentos-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>

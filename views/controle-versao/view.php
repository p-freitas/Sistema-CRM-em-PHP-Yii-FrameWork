<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\ControleVersao */

$this->title = $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Controle Versaos', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="controle-versao-view">

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'fk_produto',
            'fk_usuario',
            'data_hora',
            'numero_versao',
            'descricao:ntext',
            'script:ntext',
        ],
    ]) ?>

</div>

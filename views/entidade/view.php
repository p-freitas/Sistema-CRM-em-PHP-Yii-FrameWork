<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\Entidade */

$this->title = 'Visualizar';
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Entidades'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="entidade-view">
    <p>
        <?= Html::a(Yii::t('app', 'Update'), ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a(Yii::t('app', 'Delete'), ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => Yii::t('app', 'Are you sure you want to delete this item?'),
                'method' => 'post',
            ],
        ]) ?>
        <?= Html::a(Yii::t('app', 'Voltar'), ['index'], ['class' => 'btn btn-default']) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            [
                'attribute' => 'fkCidade.nome',
                'label' => 'Cidade'
            ],
            'nome',
            'cnpj',
            'endereco',
            'sigla',
            [
                'attribute' => 'brasao',
                'format' => 'raw',
                'value' => function ($model) {
                    return '<a target="_blank" href="' . \yii\helpers\Url::to('@web/img/' . $model->brasao, true) . '">
                    <img src="' . \yii\helpers\Url::to('@web/img/' . $model->brasao, true) . '" style="max-height: 30px;max-width=30px"></a>';
                },
            ],
        ],
    ]) ?>

</div>

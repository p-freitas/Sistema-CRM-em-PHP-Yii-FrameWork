<?php

use yii\helpers\Html;
use kartik\detail\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\TipoCliente */

$this->title = 'Visualizar';
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Tipos Cliente'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $model->descricao;
?>
<div class="tipo-cliente-view">


    <p>
        <?= Html::a(Yii::t('app', 'Update'), ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a(Yii::t('app', 'Delete'), ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => Yii::t('app', 'Are you sure you want to delete this item?'),
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'krajeeDialogSettings' => ['overrideYiiConfirm' => false],
        'hAlign' => 'rigth',
        'vAlign' => 'middle',
        'panel' => false,
        'attributes' => [
            [
                'group' => true,
                'label' => 'Tipo Cliente',
                'groupOptions' => ['class' => 'text-bold text-center'],
            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Descrição',
                            'attribute' => 'descricao',
                            'value' => $model->descricao,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 80%'],
                        ],
                    ]

            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Código',
                            'attribute' => 'codigo',
                            'value' => $model->codigo,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 80%'],
                        ],
                    ]

            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Entidade',
                            'value' => $model->fkEntidade->razao_social,
                            'visible' => \Yii::$app->user->isSuperadmin,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 80%'],
                        ],
                    ]

            ],
        ],
    ]) ?>

</div>

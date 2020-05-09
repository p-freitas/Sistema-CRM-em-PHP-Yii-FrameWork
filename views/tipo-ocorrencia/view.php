<?php

use yii\helpers\Html;
use kartik\detail\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\TipoOcorrencia */

$this->title = $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Tipo Ocorrencias', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="tipo-ocorrencia-view">

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
        'krajeeDialogSettings' => ['overrideYiiConfirm' => false],
        'hAlign' => 'rigth',
        'vAlign' => 'middle',
        'panel' => false,
        'attributes' => [
            [
                'group' => true,
                'label' => 'Tipo Ocorrência',
                'groupOptions' => ['class' => 'text-bold text-center'],
            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Entidade',
                            'attribute' => 'fk_entidade',
                            'value' => $model->fkEntidade->razao_social,
                            'visible' => \Yii::$app->user->isSuperadmin,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Descrição',
                            'attribute' => 'descricao',
                            'value' => $model->descricao,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Prazo',
                            'attribute' => 'prazo',
                            'value' => $model->prazo,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                    ]
            ],
        ]
    ]) ?>

</div>

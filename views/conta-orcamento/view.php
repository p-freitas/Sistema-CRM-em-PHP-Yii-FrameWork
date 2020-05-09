<?php

use kartik\detail\DetailView;
use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\ContaOrcamento */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Atendimentos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $model->id;
$this->title = 'Visualizar';
?>
<div class="conta-orcamento-view">


    <p>
        <?= Html::a('Atualizar', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Deletar', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Tem certeza que deseja deletar este item?',
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
                'label' => 'Orçamento',
                'groupOptions' => ['class' => 'text-bold text-center'],
            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'ID',
                            'attribute' => 'id',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Entidade',
                            'attribute' => 'fk_entidade',
                            'value' => $model->fkEntidade->nome_fantasia,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Número',
                            'attribute' => 'numero',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Código',
                            'attribute' => 'codigo',

                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Descrição',
                            'attribute' => 'descricao',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Tipo',
                            'attribute' => 'tipo',
                            'value' => ($model->tipo == 1) ? 'Entrada' : 'Saída',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Tipo do lançamento',
                            'attribute' => 'tipo_lancamento',
                            'value' => ($model->tipo_lancamento == 1) ? 'Sim' : 'Não',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ]
                    ]
            ],
            //'id',
            //'fk_entidade',
            //'numero',
            //'codigo',
            //'descricao',
            //'tipo',
            //'tipo_lancamento',
        ],
    ]) ?>

</div>

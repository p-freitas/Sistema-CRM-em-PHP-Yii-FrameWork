<?php

use yii\helpers\Html;
use kartik\detail\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\NotaFiscal */

$this->title = 'Visualizar';
$this->params['breadcrumbs'][] = ['label' => 'Notas Fiscais', 'url' => ['index']];
$this->params['breadcrumbs'][] = $model->id;
?>
<div class="nota-fiscal-view">

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
                'label' => 'Notas Fiscias',
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
                            'label' => 'Cliente',
                            'attribute' => 'fk_cliente',
                            'value' => $model->fkCliente->nome_fantasia,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Usuário',
                            'attribute' => 'fk_usuario',
                            'value' => $model->fkUsuario->nome_completo,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Número da nota',
                            'attribute' => 'numero_nota',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Data da emissão',
                            'attribute' => 'data_emissao',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Data da competência',
                            'attribute' => 'competencia',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Descrição do serviço',
                            'attribute' => 'descricao_servico',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Valor',
                            'attribute' => 'valor',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Aliquota do ISS',
                            'attribute' => 'aliquota_iss',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Valor do ISS',
                            'attribute' => 'valor_iss',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Condição do pagamento',
                            'attribute' => 'condicao_pagamento',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Informações complementares',
                            'attribute' => 'info_complementar',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Rastreamento',
                            'attribute' => 'rastreamento',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Data de entrega',
                            'attribute' => 'data_entrega',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Status',
                            'attribute' => 'situacao',
                            'value' => ($model->situacao == 1) ? 'Ativo' : 'Inativo',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                    ]
            ],
            //'id',
            //'fk_cliente',
            //'fk_usuario',
            //'numero_nota',
            //'data_emissao',
            //'competencia',
            //'descricao_servico:ntext',
            //'valor',
            //'aliquota_iss',
            //'valor_iss',
            //'condicao_pagamento',
            //'info_complementar',
            //'rastreamento',
            //'data_entrega',
            //'situacao',
        ],
    ]) ?>

</div>

<?php

use yii\helpers\Html;
use kartik\detail\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\Financeiro */

$this->title = 'Visualizar';
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Financeiro'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $model->id;
?>
<div class="financeiro-view">

    <h1><?= Html::encode($this->title) ?></h1>

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
                'label' => 'Conta',
                'groupOptions' => ['class' => 'text-bold text-center'],
            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'ID',
                            'attribute' => 'id',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Nota Fiscal',
                            'attribute' => 'fk_nota_fiscal',
                            'value' => $model->fk_nota_fiscal != null ? $model->fkNotaFiscal->numero_nota : $model->fk_nota_fiscal,

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
                            'label' => 'Conta',
                            'attribute' => 'fk_conta',
                            'value' => $model->fk_conta != null ? $model->fkConta->descricao : $model->fkConta,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Tipo do documento',
                            'attribute' => 'fk_tipo_documento',
                            'value' => $model->fkTipoDocumento->descricao,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Banco portador',
                            'attribute' => 'fk_banco_portador',
                            'value' => $model->fkBancoPortador->descricao,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Conta orçamento',
                            'attribute' => 'fk_conta_orcamento',
                            'value' => $model->fkContaOrcamento->descricao,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Número do título',
                            'attribute' => 'numero_titulo',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Data de emissão',
                            'attribute' => 'data_emissao',

                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Tipo',
                            'attribute' => 'tipo',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Vencimento',
                            'attribute' => 'vencimento',

                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Valor do título',
                            'attribute' => 'valor_titulo',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Valor do pagamento',
                            'attribute' => 'valor_pgto',

                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Data do pagamento',
                            'attribute' => 'data_pgto',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Valor do desconto',
                            'attribute' => 'valor_desconto',

                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Data dev',
                            'attribute' => 'data_dev',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Valor dev',
                            'attribute' => 'valor_dev',

                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],

            [
                'columns' =>
                    [
                        [
                            'label' => 'Saldo',
                            'attribute' => 'saldo',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Observações',
                            'attribute' => 'obs',

                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],
        ],
    ]) ?>

</div>

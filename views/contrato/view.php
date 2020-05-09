<?php

use yii\helpers\Html;
use yii\helpers\Url;
use kartik\detail\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\Contrato */

$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Contratos'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $model->numero;
$this->title = 'Visualizar';
?>
<div class="contrato-view">



    <p>
        <?= Html::a(Yii::t('app', 'Update'), ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a(Yii::t('app', 'Delete'), ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => Yii::t('app', 'Tem certeza que deseja deletar este item?'),
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
                'label' => 'Contratos',
                'groupOptions' => ['class' => 'text-bold text-center'],
            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Cliente',
                            'attribute' => 'fk_cliente',
                            'value' => $model->fkCliente->nome_fantasia,
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 80%'],
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
                            'label' => 'Modalidade',
                            'attribute' => 'fk_modalidade',
                            'value' => $model->fkModalidade->descricao,
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Data Início',
                            'attribute' => 'data_inicio',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                        [
                            'label' => 'Data Término',
                            'attribute' => 'data_termino',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Valor Global',
                            'attribute' => 'valor_global',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                        [
                            'label' => 'Valor Mensal',
                            'attribute' => 'valor_mensal',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],
            [
                'columns' =>
                    [
                        [
                            'label' => 'Objeto',
                            'attribute' => 'objeto',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],
                        [
                            'label' => 'Info Complementar',
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
                            'label' => 'Anexo',
                            'attribute' => 'anexo',
                            'value' => Html::a($model->anexo,Url::to($model->anexo)),
                            'format' => 'raw',
                            'labelColOptions' => ['style' => 'width: 20%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 40%'],
                        ],

                        [
                            'label' => 'Status',
                            'attribute' => 'status',
                            'value' => ($model->status == 1) ? 'Ativo' : 'Inativo',
                            'labelColOptions' => ['style' => 'width: 10%; text-align:right'],
                            'valueColOptions' => ['style' => 'width: 30%'],
                        ],
                    ]
            ],
        ],
    ]) ?>

    <?php if(!empty($aditivos)){ ?>

        <?= DetailView::widget([
            'model' => $model,
            'mode' => 'view',
            'hAlign' => 'rigth',
            'vAlign' => 'middle',
            'panel' => false,
            'attributes' => [
                [
                    'group' => true,
                    'label' => 'Aditivos',
                    'groupOptions' => ['class' => 'text-bold text-center'],
                ],
            ]

        ]) ?>

        <div id="table-aditivos" class="table-responsive pre-scrollable table-xxs">
            <table class="table table-striped table-bordered toggle-circle table-hover table-xxs">
                <thead>
                <tr>
                    <th class="col-md-2 text-center">Número</th>
                    <th class="col-md-2 text-center">Data Ínicio</th>
                    <th class="col-md-2 text-center">Data Término</th>
                    <th class="col-md-2 text-center">Valor</th>
                    <th class="col-md-2 text-center">Justificativa</th>
                    <th class="col-md-2 text-center">Anexo</th>
                </tr>
                </thead>
                    <?php foreach($aditivos as $aditivo ){ ?>
                        <tr>
                            <td><?= $aditivo->numero ?></td>
                            <td><?= $aditivo->data_inicio ?></td>
                            <td><?= $aditivo->data_termino ?></td>
                            <td><?= $aditivo->valor ?></td>
                            <td><?= $aditivo->justificativa ?></td>
                                <td style="text-align: center"><a href='<?= $aditivo->anexo ?>'><button data-toggle="tooltip" data-placement="top" title="Download" type="button" type="button" class="btn btn-rounded btn-info btn-sm"><i
                                                class="fa fa-arrow-down"></i></button></a></td>
                        </tr>
                    <?php } ?>
                <tbody>

                </tbody>

            </table>
        </div>
    <?php } ?>

    <br>
    <br>
    <?php $produto = $model->contratoProdutos;
    if (!empty($produto)) { ?>
        <?= DetailView::widget([
            'model' => $model,
            'krajeeDialogSettings' => ['overrideYiiConfirm' => false],
            'mode' => 'view',
            'hAlign' => 'rigth',
            'vAlign' => 'middle',
            'panel' => false,
            'attributes' => [
                [
                    'group' => true,
                    'label' => 'Produtos',
                    'groupOptions' => ['class' => 'text-bold text-center'],
                ],
            ]

        ]) ?>


        <div class="row">
            <div class="col-md-12" >
                <div class="table-responsive">
                    <table class="table gestao table-bordered table-hover contact-list footable footable-5 footable-paging footable-paging-center breakpoint-lg">
                        <thead>
                        <tr>
                            <th style="color: black; vertical-align: middle" class="text-center">Descrição</th>
                        </tr>
                        </thead>
                        <tbody id="corpo-produtos">
                        <!--Update - Dados vindo do banco -->
                        <?php foreach ($model->contratoProdutos as $index => $produto) { ?>
                            <tr data-produto="<?= $produto->fkProduto->descricao ?>" data-index-produto="<?= $index ?>">
                                <td class="">
                                    <input  type="hidden" name="ContratoProdutos[<?= $index ?>][fk_produto]"
                                           value="<?= $produto->fk_produto ?>"><?= $produto->fkProduto->descricao ?>
                                </td>
                            </tr>
                        <?php } ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    <?php } ?>


</div>

<?php

use yii\helpers\Html;
use yii\grid\GridView;
use webvimark\modules\UserManagement\components\GhostHtml;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;


/* @var $this yii\web\View */
/* @var $searchModel app\models\search\AtendimentoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */
/* @var $modelCliente app\models\Cliente */

$this->title = Yii::t('app', 'Atendimentos');
$this->params['breadcrumbs'][] = Yii::t('app', 'Atendimentos');

$this->registerCss("
    .table.table-condensed.table-striped > thead > tr > th{
        border-top: 1px solid #e4e7ea;
    }
    
    .badge {
        padding: 1px 5px 2px;
        margin-top: 0;  
    }
    
    
");

$this->registerJs("
        function modalSolucao(id) {  
            var valor = $(id).attr('data-id');
            document.getElementById('id_solucao').value = valor;             
            $('#solucao-modal').modal('show');
        }
            
        ",
    \yii\web\View::POS_HEAD
);

$this->registerJs("
        function modalCancelar(id) {  
            var valor = $(id).attr('data-id');
            document.getElementById('id_atendimento').value = valor;             
            $('#cancelar-modal').modal('show');
        }
            
        ",
    \yii\web\View::POS_HEAD
);


?>
<div class="atendimento-index">
    <?php Pjax::begin(['id' => 'pjax-atendimento']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Novo atendimento', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">

            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>

            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquise por cliente, contato, usuário, tipo do atendimento ou data do atendimento'])->label('Pesquisar: ') ?>

            <?php ActiveForm::end(); ?>
        </div>
    </div>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            ['label' => 'Cliente',
                'headerOptions' => ['class' => 'text-left'],
                'contentOptions' => ['class' => 'text-left'],
                'attribute' => 'fk_cliente',
                'value' => function ($model) {
                    $nomeTooltip = $model->fkCliente->razao_social;

                    if (strlen($nomeTooltip) > 30) {
                        $nomeTooltip = \yii\helpers\StringHelper::truncate($nomeTooltip, 30);
                        $options = [
                            'data-pjax' => 0,
                            'data-toggle' => 'tooltip',
                            'data-trigger' => 'hover',
                            'title' => $model->fkCliente->razao_social
                        ];
                    } else {
                        $options = [
                            'data-pjax' => 0
                        ];
                    }

                    return Html::a($nomeTooltip, ['update', 'id' => $model->id], $options);
                },
                'format' => 'raw',
            ],

            ['label' => 'Contato', 'headerOptions' => ['class' => 'text-left'],
                'contentOptions' => ['class' => 'text-left'],
                'attribute' => 'fk_contato_cliente',
                'value' => function ($model) {
                    return $model->fkContatoCliente->nome;
                },
            ],
            ['label' => 'Usuário', 'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'attribute' => 'fk_usuario',
                'value' => function ($model) {
                    return $model->fkUsuario->nome_completo;
                },
            ],
            ['label' => 'Tipo do atendimento', 'headerOptions' => ['class' => 'text-left'],
                'contentOptions' => ['class' => 'text-left'],
                'attribute' => 'fk_tipo_atendimento',
                'value' => function ($model) {
                    return $model->fkTipoAtendimento->descricao;
                },
            ],
            ['label' => 'Data do atendimento',
                'attribute' => 'data_atendimento',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center '],
            ],
            [
                'attribute' => 'Status',
                'filter' => Html::activeDropDownList($model, 'status', [2 => 'Cancelado', 0 => 'Pendente', 1 => 'Concluído'], ['class' => 'form-control']),
                'format' => 'raw',
                'value' => function ($model) {
                    switch ($model->status) {
                        case 0:
                            {
                                $class = 'warning';
                                break;
                            }
                        case 1:
                            {
                                $class = 'success';
                                break;
                            }
                        default:
                            {
                                $class = 'danger';
                                break;
                            }
                    }
                    return \yii\helpers\Html::tag('span', \app\models\Atendimento::$statusDesc[$model->status], ['class' => 'label label-' . $class]);
                }
            ],

            ['class' => \app\modules\DropDownActionColumn::className(),
                'template' => false,
                'items' => [
                    [
                        'label' => 'Solução',
                        'icon' => 'fa fa-folder-open',
                        'url' => null,
                        'linkOptions' => [
                            'class' => 'btn-sm cursor-pointer',
                            'data-pjax' => 0,
                            'onclick' => "modalSolucao(this)",
                            'id' => 'adicionar-solucao',
                        ],
                        'visible' => function ($model) {
                            if ($model->status == 1 || $model->status == 2)
                                return false;
                        },
                        'adParameter' => 'id'
                    ],
                    [
                        'label' => Yii::t('yii', 'View'),
                        'url' => ['view'],
                        'icon' => 'glyphicon glyphicon-eye-open',
                        'linkOptions' => [
                            'class' => 'btn-sm',
                            'data-pjax' => 0
                        ],
                        'visible' => true,
                    ],
                    [
                        'label' => Yii::t('yii', 'Alterar'),
                        'url' => ['update'],
                        'icon' => 'glyphicon glyphicon-pencil m-r-5',
                        'linkOptions' => [
                            'class' => 'btn-sm',
                            'data-pjax' => 0
                        ],
                        'visible' => true
                    ],
                    [
                        'label' => 'Cancelar',
                        'icon' => 'fa fa-times-circle',
                        'url' => null,
                        'linkOptions' => [
                            'class' => 'btn-sm cursor-pointer',
                            'data-pjax' => 0,
                            'onclick' => "modalCancelar(this)",
                            'id' => 'adicionar-motivo',
                        ],
                        'visible' => function ($model) {
                            if ($model->status == 1 || $model->status == 2)
                                return false;
                        },
                        'adParameter' => 'id'
                    ],
                ],
            ],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

<div class="modal fade" id="solucao-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="solucao-modal-label" style="color:white">Cadastrar Solução</h4>
            </div>
            <?= $this->render('//atendimento/_form_modal', ['model' => new \app\models\Atendimento()]); ?>
        </div>
    </div>
</div>

<div class="modal fade" id="cancelar-modal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-danger">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="cancelar-modal-label">Cancelar atendimento</h4>
            </div>
            <?= $this->render('//atendimento/_form_cancelamento', ['model' => new \app\models\Atendimento()]); ?>
        </div>
    </div>
</div>




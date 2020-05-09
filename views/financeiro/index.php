<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;
use app\modules\DropDownActionColumn;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\FinanceiroSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Contas a Pagar';
$this->params['breadcrumbs'][] = $this->title;

$this->registerJs("
        function modalBaixa(id) {  
            var valor = $(id).attr('data-id');
            document.getElementById('id_baixa').value = valor;             
            $('#baixa-modal').modal('show');
        }
            
        ",
    \yii\web\View::POS_HEAD
);

?>
<div class="financeiro-index">

    <?php Pjax::begin(['id' => 'pjax-funcionario']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Nova conta', ['create', 'tipo' => 1], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">
            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>
            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por nota fical, cliente, conta ou data de emissão'])->label('Pesquisar: ') ?>
            <?php ActiveForm::end(); ?>
        </div>
    </div>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            [
                'label' => 'Cliente',
                'attribute' => 'fk_cliente',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function($model){
                    return $model->fkCliente->nome_fantasia ;
                },
            ],

            [
                'label' => 'Tipo do documento',
                'attribute' => 'fk_tipo_documento',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function($model){
                    return $model->fkTipoDocumento->descricao ;
                },
            ],

            [
                'label' => 'Data de emissão',
                'attribute' => 'data_emissao',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],

            ],

            [
                'label' => 'Valor do título',
                'attribute' => 'valor_titulo',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],

            ],

            [
                'attribute' => 'situacao',
                'filter' => Html::activeDropDownList($model, 'situacao', [2 => 'Liquidado', 0 => 'Aberto', 1 => 'Baixa parcial'], ['class' => 'form-control']),
                'format' => 'raw',
                'value' => function ($model) {
                    switch ($model->situacao) {
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
                    return \yii\helpers\Html::tag('span', \app\models\Financeiro::$statusDesc[$model->situacao], ['class' => 'label label-' . $class]);
                }
            ],

            ['class' => \app\modules\DropDownActionColumn::className(),
                'template' => false,
                'items' => [
                    [
                        'label' => 'Baixa/Pagamento',
                        'icon' => 'fa fa-folder-open',
                        'url' => null,
                        'linkOptions' => [
                            'class' => 'btn-sm cursor-pointer',
                            'data-pjax' => 0,
                            'onclick' => "modalBaixa(this)",
                            'id' => 'baixa-id',
                        ],
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
                        'label' => Yii::t('yii', 'Excluir'),
                        'url' => ['delete'],
                        'icon' => 'glyphicon glyphicon-trash m-r-5',
                        'linkOptions' => [
                            'class' => 'btn-sm',
                            'data-pjax' => 0
                        ],
                        'visible' => true
                    ],
                ],
            ],

            //'fk_banco_portador',
            //'fk_conta_orcamento',
            //'numero_titulo',
            //'',
            //'tipo',
            //'vencimento',
            //'',
            //'valor_pgto',
            //'data_pgto',
            //'valor_desconto',
            //'data_dev',
            //'valor_dev',
            //'saldo',
            //'obs',
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

<div class="modal fade" id="baixa-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="baixa-modal-label" style="color:white">Cadastrar Baixa</h4>
            </div>
            <?= $this->render('//financeiro/_form_modal', ['model' => new \app\models\Financeiro()]); ?>
        </div>
    </div>
</div>
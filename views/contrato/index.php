<?php

use app\models\Atendimento;
use app\models\Contrato;
use app\modules\DropDownActionColumn;
use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;

/* @var $model app\models\Atendimento */

$this->registerJs("
        function modalAditivo(id) {  
            var valor = $(id).attr('data-id');
            document.getElementById('id_contrato').value = valor;             
            $('#aditivo-modal').modal('show');
        }      
        "
    ,
    \yii\web\View::POS_HEAD
);

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\ContratoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */
/* @var $modelAditivo \app\models\Aditivo */

$this->title = Yii::t('app', 'Contratos');
$this->params['breadcrumbs'][] = 'Contratos';

?>
<div class="contrato-index">
    <?php Pjax::begin(['id' => 'pjax-atendimento']); ?>


    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Novo contrato', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">

            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>

            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por cliente, modalidade, data de início ou de término'])->label('Pesquisar: ') ?>

            <?php ActiveForm::end(); ?>
        </div>
    </div>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            /*   [
                   'class' => 'kartik\grid\ExpandRowColumn',
                   'enableRowClick' => true,
                   'expandIcon' => '<i class="icon-plus"></i>',
                   'collapseIcon' => '<i class="icon-minus"></i>',
                   'detailRowCssClass' => 'default',
                   'expandOneOnly' => true,
                   'value' => function ($model, $key, $index, $column){
                       return \kartik\grid\GridView::ROW_COLLAPSED;
                   },
                   'detailUrl' => \yii\helpers\Url::to(['//contrato/get-details'])
               ], */
            [
                'label' => 'Cliente',
                'attribute' => 'cliente',
                'headerOptions' => ['class' => 'text-left'],
                'contentOptions' => ['class' => 'text-left'],
                'value' => function ($model) {
                    return $model->fkCliente->nome_fantasia;
                },
            ],
            [
                'label' => 'Nº do contrato',
                'attribute' => 'numero',
                'headerOptions' => ['class' => 'text-left'],
                'contentOptions' => ['class' => 'text-left'],
            ],
            [
                'label' => 'Modalidade',
                'attribute' => 'modalidade',
                'headerOptions' => ['class' => 'text-left'],
                'contentOptions' => ['class' => 'text-left'],
                'value' => function ($model) {
                    return $model->fkModalidade->descricao;
                },
            ],
            [
                'label' => 'Valor global',
                'attribute' => 'valor_global',
                'headerOptions' => ['class' => 'text-left'],
                'contentOptions' => ['class' => 'text-left'],
            ],
            [
                'label' => "<i class='fa fa-paperclip'></i>",
                'attribute' => 'anexo',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'format' => 'raw',
                'encodeLabel' => false,
                'value' => function ($model) {
                    if (!empty($model->anexo))
                        return "<a href='$model->anexo' target=\"_blank\" ><button data-toggle=\"tooltip\" data-placement=\"top\" title=\"Download\" type=\"button\" type=\"button\" class=\"btn btn-rounded btn-info btn-sm\"><i
                                                    class=\"fa fa-arrow-down\"></i></button></a>";
                },
            ],
            /*
            [
                'label' => 'Anexo aditivo',
                'attribute' => 'aditivo',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'format' => 'raw',
                'visible' => 'if (!empty($modelAditivo->anexo))',
                'value' => function($model){
                    $aditivos = $model->aditivos;
                    foreach ($aditivos as $aditivo) {
                        if (!empty($aditivo->anexo))
                            return "<a href='$aditivo->anexo'><button data-toggle=\"tooltip\" data-placement=\"top\" title=\"Download\" type=\"button\" type=\"button\" class=\"btn btn-rounded btn-info btn-sm\"><i
                                                    class=\"fa fa-arrow-down\"></i></button></a>";
                    }
                },
            ],
            */
            [
                'label' => 'Status',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'format' => 'raw',
                'attribute' => 'status',
                'value' => function ($model) {
                    $status = $model->status;
                    switch ($status) {
                        case 1:
                            $class = 'success';
                            break;

                        case 0:
                            $class = 'danger';
                            break;
                    }
                    return '<span class="label label-' . $class . '">' . Contrato::$descStatus[$status] . '</span>';
                },
            ],

            ['class' => DropDownActionColumn::className(),
                'template' => false,
                'items' => [
                    [
                        'label' => 'Aditivo',
                        'icon' => 'fa fa-folder-open',
                        'url' => null,
                        'linkOptions' => [
                            'class' => 'btn-sm ',
                            'data-pjax' => 0,
                            'onclick' => "modalAditivo(this)",
                            'id' => 'aditivo',
                        ],
                        'visible' => function ($model) {
                            if ($model->status == 0)
                                return false;
                        },
                        'adParameter' => 'id'
                    ],
                    [
                        'label' => 'Desativar',
                        'url' => ['//contrato/desliga-contrato'],
                        'icon' => 'fa fa-times-circle',
                        'primaryKeyOptions' => ['paramName' => 'numero'],
                        'mergePrimaryKey' => true,
                        'visible' => function ($model) {
                            return $model->status == 1;
                        },
                        'linkOptions' => [
                            'class' => 'btn-sm intercept-button-form',
                            'data-confirm' => 'Você deseja realmente cancelar este contrato?',
                            'data-method' => 'post',
                        ],
                        'adParameter' => 'id'
                    ],
                    [
                        'label' => 'Ativar',
                        'url' => ['//contrato/ativa-contrato'],
                        'icon' => 'fa fa-check-circle',
                        'primaryKeyOptions' => ['paramName' => 'numero'],
                        'mergePrimaryKey' => true,
                        'visible' => function ($model) {
                            return $model->status == 0;
                        },
                        'linkOptions' => [
                            'class' => 'btn-sm intercept-button-form',
                            'data-confirm' => 'Você deseja realmente ativar este contrato?',
                            'data-method' => 'post',
                        ],
                        'adParameter' => 'id'
                    ],
                    [
                        'label' => Yii::t('yii', 'Alterar'),
                        'url' => ['update'],
                        'icon' => 'glyphicon glyphicon-pencil m-r-5',
                        'linkOptions' => [
                            'class' => 'btn-sm',
                            'data-pjax' => 0
                        ],
                        'visible' => function ($model) {
                            return $model->status == 1;
                        },
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
                ],
            ],
        ],
    ]);
    ?>

    <?php Pjax::end(); ?>
</div>


<div class="modal fade" id="aditivo-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="aditivo-modal-label" style="color:white">Aditivo</h4>
            </div>
            <?= $this->render('//aditivo/_form_modal', ['model' => new \app\models\Aditivo()]); ?>
        </div>
    </div>
</div>

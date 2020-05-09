<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;
use app\modules\DropDownActionColumn;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\OrcamentoPropostaSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Orcamento Propostas';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="orcamento-proposta-index">
    <?php Pjax::begin(['id' => 'pjax-funcionario']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Novo orçamento', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">
            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>
            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por cliente, contato ou data'])->label('Pesquisar: ') ?>
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
                'label' => 'Contato',
                'attribute' => 'fk_contato_cliente',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function($model){
                    return $model->fkContatoCliente->nome ;
                },
            ],

            [
                'label' => 'Parcelas',
                'attribute' => 'implantacao_parcela',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],

            ],

            [
                'label' => 'Valor da implantação',
                'attribute' => 'implantacao_valor',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],

            ],

            [
                'label' => 'Data',
                'attribute' => 'data',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],

            ['class' => DropDownActionColumn::className()],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

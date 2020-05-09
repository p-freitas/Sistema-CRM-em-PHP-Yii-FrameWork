<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;
use app\modules\DropDownActionColumn;
use app\models\Financeiro;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\FinanceiroReceberSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Contas a Receber';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="financeiro-index">

    <?php Pjax::begin(['id' => 'pjax-funcionario']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Nova conta', ['create', 'tipo' => 2], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">
            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index-receber'],
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
                'label' => 'Nota Fiscal',
                'attribute' => 'fk_nota_fiscal',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function($model){
                    return  $model->fkNotaFiscal->numero_nota;
                },
            ],

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
                'label' => 'Conta',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'attribute' => 'fk_conta',
                'value' => function($model){
                    return $model->fkConta->descricao ;
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

            ['class' => DropDownActionColumn::className()],

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

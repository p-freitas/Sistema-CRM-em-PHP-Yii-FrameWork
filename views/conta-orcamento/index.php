<?php

use app\modules\DropDownActionColumn;
use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\ContaOrcamentoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Conta Orçamentos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="conta-orcamento-index">
    <?php Pjax::begin(['id' => 'pjax-funcionario']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Novo orçamento', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">
            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>
            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por código ou descrição'])->label('Pesquisar: ') ?>
            <?php ActiveForm::end(); ?>
        </div>
    </div>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            [
                'label' => 'Número',
                'attribute' => 'numero',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],

            [
                'label' => 'Código',
                'attribute' => 'codigo',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],

            [
                'label' => 'Descrição',
                'attribute' => 'descricao',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],

            //'id',
            //'fk_entidade',
            //'numero',
            //'codigo',
            //'descricao',
            //'tipo',
            //'tipo_lancamento',

            ['class' => DropDownActionColumn::className()],
        ]
    ]); ?>
    <?php Pjax::end(); ?>
</div>

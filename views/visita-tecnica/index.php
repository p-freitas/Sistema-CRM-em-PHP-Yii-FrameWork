<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\ActiveForm;
use yii\widgets\Pjax;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\VisitaTecnicaSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Visita Tecnicas';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="visita-tecnica-index">
    <?php Pjax::begin(['id' => 'pjax-cliente']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Nova visita', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">
            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>
            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por nome, CPF/CNPJ, tipo do orgão ou cidade '], [''])->label('Pesquisar: ') ?>

            <?php ActiveForm::end(); ?>
        </div>
    </div>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            [
                'label' => 'Usuário',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'attribute' => 'fk_usuario',
                'value' => function ($model) {
                    return $model->fkUsuario->nome_completo;
                },
            ],
            [
                'label' => 'Cliente',
                'attribute' => 'fk_cliente',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function($model){
                    return $model->fkCliente->nome_fantasia;
                },
            ],
            [
                'label' => 'Produto',
                'attribute' => 'fk_produto',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function($model){
                    return $model->fkProduto->descricao;
                },
            ],
            [
                'label' => 'Data',
                'attribute' => 'data',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
    
            ],
            //'solicitante',
            //'agendamento',
            //'situacao',
            //'data_situacao',
            //'motivo:ntext',
            //'ocorrencias:ntext',

            ['class' => \app\modules\DropDownActionColumn::className()],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

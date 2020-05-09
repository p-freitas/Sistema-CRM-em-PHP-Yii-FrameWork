<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\ActiveForm;
use yii\widgets\Pjax;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\ControleVersaoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Controle Versaos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="controle-versao-index">

    <?php Pjax::begin(['id' => 'pjax-funcionario']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Nova controle', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">
            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>
            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por cliente, usuário, número da nota ou data de emissão'])->label('Pesquisar: ') ?>
            <?php ActiveForm::end(); ?>
        </div>
    </div>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            [
                'label' => 'Produto',
                'attribute' => 'fk_produto',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function($model){
                    return $model->fkProduto->descricao;
                },
            ],
            ['label' => 'Usuário', 'attribute' => 'fk_usuario','headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'], 'value' => function($model){
                return $model->fkUsuario->nome_completo ;
            },
            ],
            ['label' => 'Data do atendimento', 'attribute' => 'data_hora', 'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center']],
            ['label' => 'Data do atendimento', 'attribute' => 'numero_versao', 'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center']],

            //'descricao:ntext',
            //'script:ntext',

            ['class' => \app\modules\DropDownActionColumn::className()],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

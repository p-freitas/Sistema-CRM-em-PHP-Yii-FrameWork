<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\ActiveForm;
use yii\widgets\Pjax;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\TipoOcorrenciaSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Tipo Ocorrencias';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="tipo-ocorrencia-index">
    <?php Pjax::begin(['id' => 'pjax-atendimento']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Novo tipo', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">

            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>

            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por ID, descrição, ou prazo'])->label('Pesquisar: ') ?>

            <?php ActiveForm::end(); ?>
        </div>
    </div>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            [
                'label' => 'Entidade',
                'attribute' => 'fk_entidade',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'visible' => Yii::$app->user->isSuperadmin,
                'value' => function ($model) {
                    return $model->fkEntidade->razao_social;
                },
            ],
            [
                'label' => 'Descrição',
                'attribute' => 'descricao',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],
            [
                'label' => 'Prazo',
                'attribute' => 'prazo',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],

            ['class' => \app\modules\DropDownActionColumn::className()],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

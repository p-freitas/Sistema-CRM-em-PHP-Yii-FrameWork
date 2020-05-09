<?php

use app\modules\DropDownActionColumn;
use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\ActiveForm;
use yii\widgets\Pjax;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\TipoAtendimentoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Tipo Atendimentos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="tipo-atendimento-index">
    <?php Pjax::begin(['id' => 'pjax-atendimento']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Novo tipo', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">

            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>

            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por ID ou descrição'])->label('Pesquisar: ') ?>

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

            ['class' => DropDownActionColumn::className()],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

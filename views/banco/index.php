<?php

use yii\helpers\Html;
use yii\grid\GridView;
use app\modules\DropDownActionColumn;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\BancoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Bancos';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="banco-index">

    <?php Pjax::begin(['id' => 'pjax-funcionario']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Novo banco', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
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
                'label' => 'Entidade',
                'attribute' => 'fk_entidade',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function($model) {
                    return $model->fkEntidade->nome_fantasia;
                }

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

            ['class' => DropDownActionColumn::className()],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

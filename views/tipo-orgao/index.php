<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\TipoOrgaoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Tipo orgão');
$this->params['breadcrumbs'][] = Yii::t('app', 'Tipo Orgãos');
?>
<div class="tipo-orgao-index">

    <?php Pjax::begin(['id' => 'pjax-funcionario']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Novo tipo', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">
            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>
            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por descrição ou sigla'])->label('Pesquisar: ') ?>
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
                'attribute' => 'entidade',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'visible' => \Yii::$app->user->isSuperadmin,
                'value' => function($model){
                    return $model->fkEntidade->nome_fantasia;
                },

            ],
            [
                'label' => 'Descrição',
                'attribute' => 'descricao',
                'headerOptions' => ['class' => 'text-left'],
                'contentOptions' => ['class' => 'text-left'],
            ],
            [
                'label' => 'Sigla',
                'attribute' => 'sigla',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],

            ['class' => \app\modules\DropDownActionColumn::className(),],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

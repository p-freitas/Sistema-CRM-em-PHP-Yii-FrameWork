<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\ProdutoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Produtos');
$this->params['breadcrumbs'][] = 'Produtos';
?>
<div class="produto-index">

    <?php Pjax::begin(['id' => 'pjax-funcionario']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Novo produto', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
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
                'attribute' => 'entidade',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'visible' => \Yii::$app->user->isSuperadmin,
                'value' => function($model){
                    return $model->fkEntidade->nome_fantasia;
                },

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
                'headerOptions' => ['class' => 'text-left'],
                'contentOptions' => ['class' => 'text-left'],
            ],

            ['class' => \app\modules\DropDownActionColumn::className(),
                'template' => false,
                'items' => [
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
                    [
                        'label' => Yii::t('yii', 'Alterar'),
                        'url' => ['update'],
                        'icon' => 'glyphicon glyphicon-pencil m-r-5',
                        'linkOptions' => [
                            'class' => 'btn-sm',
                            'data-pjax' => 0
                        ],
                        'visible' => true
                    ],
                    [
                        'label' => Yii::t('yii', 'Deletar'),
                        'url' => ['delete'],
                        'icon' => 'glyphicon glyphicon-trash',
                        'visible' => true,
                        'linkOptions' => [
                            'class' => 'btn-sm',
                            'data-confirm' => Yii::t('yii', 'Are you sure you want to delete this item?'),
                            'data-method' => 'post',
                            'data-pjax' => 0
                        ],
                    ]
                ],
            ],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

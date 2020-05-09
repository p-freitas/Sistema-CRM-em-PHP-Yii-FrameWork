<?php

use yii\helpers\Html;
use yii\grid\GridView;
use webvimark\modules\UserManagement\components\GhostHtml;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\NotaFiscalSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Notas Fiscais';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="nota-fiscal-index">

    <?php Pjax::begin(['id' => 'pjax-funcionario']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Nova nota fiscal', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
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


            ['label' => 'Cliente', 'attribute' => 'fk_cliente',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function($model){
                return $model->fkCliente->nome_fantasia;
            },
            ],

            ['label' => 'Usuário', 'attribute' => 'fk_usuario','headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'], 'value' => function($model){
                return $model->fkUsuario->nome_completo ;
            },
            ],

            [
                'label' => 'Número da nota',
                'attribute' => 'numero_nota',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],

            [
                'label' => 'Data da emissão',
                'attribute' => 'data_emissao',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],

            [
                'label' => 'Status',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'format' => 'raw',
                'attribute' => 'status',
                'value' => function($model){
                    $status = $model->situacao;
                    switch ($status){
                        case 1: $class ='success'; break;

                        case 0: $class = 'danger'; break;
                    }
                    return '<span class="label label-' . $class . '">' . \app\models\NotaFiscal::$descStatus[$status] . '</span>';
                },
            ],

            ['class' => \app\modules\DropDownActionColumn::className()],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

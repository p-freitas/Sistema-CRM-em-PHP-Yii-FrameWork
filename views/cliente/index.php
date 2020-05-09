<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\ClienteSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */


$this->title = Yii::t('app', 'Clientes');
$this->params['breadcrumbs'][] = Yii::t('app', 'Clientes');

$this->registerCss("
    .table.table-condensed.table-striped > thead > tr > th{
        border-top: 1px solid #e4e7ea;
    }
    
    .badge {
        padding: 1px 5px 2px;
        margin-top: 0;  
    }
");

?>

<div class="cliente-index" xmlns="http://www.w3.org/1999/html">
    <?php Pjax::begin(['id' => 'pjax-cliente']); ?>

    <div class="form-group">
        <?= Html::a('<i class="fa fa-plus-circle"></i> Nova Entidade', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
        <div class="pull-right">
            <?php $form = ActiveForm::begin([
                'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                'action' => ['index'],
                'method' => 'get',
            ]); ?>
            <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por nome, CPF/CNPJ, tipo do orgão ou cidade '], [''])->label('Pesquisar: ') ?>

            <div>
                <?= Html::a(Html::tag('i', '', ['class' => 'fa fa-th-large']) . ' Ícone ', ['cliente/index-card'], ['class' => 'pull-right', 'style' => ['color' => '#979797']]) ?>
                <?= Html::a(Html::tag('i', '', ['class' => 'fa fa-th-list']) . ' Lista &ensp;&ensp; ', ['cliente/index'], ['class' => 'pull-right', 'style' => ['color' => '#979797']]) ?>
            </div>

            <?php ActiveForm::end(); ?>
        </div>
    </div>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            [
                'label' => 'Entidade',
                'attribute' => 'entidade',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'visible' => Yii::$app->user->isSuperadmin,
                'value' => function ($model) {
                    return $model->fkEntidade->razao_social;
                },
            ],
            [
                'label' => 'Nome',
                'attribute' => 'nome_fantasia',
                'headerOptions' => ['class' => 'text-left'],
                'contentOptions' => ['class' => 'text-left'],
                'value' => function ($model) {
                    $url = empty($model->brasao) ? \yii\helpers\Url::to('@web/themes/eliteadmin/plugins/images/users/blank-user.jpg', true) :
                        $model->brasao;

                    $nomeTooltip = $model->razao_social;

                    if (strlen($nomeTooltip) > 30) {
                        $nomeTooltip = \yii\helpers\StringHelper::truncate($nomeTooltip, 30);
                        $options = [
                            'data-pjax' => 0,
                            'data-toggle' => 'tooltip',
                            'data-trigger' => 'hover',
                            'title' => $model->razao_social
                        ];
                    } else {
                        $options = [
                            'data-pjax' => 0
                        ];
                    }

                    return Html::a(Html::img($url, ['style' => 'height: 30px; width:35px; margin-right: 10px', 'class' => 'img-circle']) .
                        $nomeTooltip, ['update', 'id' => $model->id], $options);
                },
                'format' => 'raw',
            ],
            [
                'label' => 'CPF/CNPJ',
                'attribute' => 'cpf_cnpj',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function ($model) {
                    return $model->cpf_cnpj;
                },
            ],
            [
                'label' => 'Tipo entidade',
                'attribute' => 'tipo_orgao',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function ($model) {
                    return $model->fkTipoCliente->descricao;
                },
            ],
            [
                'label' => 'Representante',
                'attribute' => 'representante',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function ($model) {
                    return is_null($model->fk_representante) ? null : $model->fkRepresentante->nome_fantasia;
                },
            ],
            [
                'label' => 'Cidade',
                'attribute' => 'cidade',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],

            ],
            [
                'label' => 'Estado',
                'attribute' => 'estado',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],
            [
                'label' => 'Status',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'format' => 'raw',
                'attribute' => 'status',
                'value' => function ($model) {
                    $status = $model->situacao;
                    switch ($status) {
                        case 1:
                            $class = 'success';
                            break;
                        case 0:
                            $class = 'danger';
                            break;
                    }
                    return '<span class="label label-' . $class . '">' . \app\models\Cliente::$descStatus[$status] . '</span>';
                },
            ],

            ['class' => \app\modules\DropDownActionColumn::className(),],
        ],
    ]); ?>
    <?php Pjax::end(); ?>
</div>

<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\widgets\ActiveForm;
use yii\widgets\Pjax;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\LogSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Logs');
$this->params['breadcrumbs'][] = $this->title;
?>



<div class="log-index">
    <?php Pjax::begin(['id' => 'pjax-atendimento']); ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            [
                'attribute' => 'fk_entidade',
                'label' => 'Entidade',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => 'fkUsuario.fkEntidade.nome_fantasia',
                'filter' => \kartik\select2\Select2::widget([
                    'value' => $searchModel->fk_entidade,
                    'initValueText' => empty($searchModel->fk_entidade) ? '' : \app\models\Entidade::findOne($searchModel->fk_entidade)->nome_fantasia,
                    'name' => 'LogSearch[fk_entidade]',
                    'theme' => 'bootstrap',
                    'language' => 'pt-BR',
                    'options' => ['placeholder' => 'Entidade'],
                    'pluginOptions' => [
                        'dropdownCssClass' => 'wide-select2',
                        'allowClear' => true,
                        'minimumInputLength' => 3,
                        'ajax' => [
                            'url' => \yii\helpers\Url::to(['entidade/busca-ajax']),
                            'dataType' => 'json',
                            'data' => new \yii\web\JsExpression('function(params) { return {q:params.term}; }')
                        ],
                    ],
                ]),
                'visible' => Yii::$app->user->isSuperadmin,
                'contentOptions' => ['style' => 'width: 20%'],
            ],
            [
                'label' => 'Usuário',
                'attribute' => 'user_id',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'contentOptions' => ['style' => 'width: 20%'],
                'format' => 'text',
                'value' => function ($model, $key, $index, $column) {
                    return \app\models\Usuario::findOne($model->user_id)->nome_completo;
                },
            ],
            [
                'label' => 'Operação',
                'attribute' => 'type',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'filter' => Html::activeDropDownList($searchModel, 'type', ["" => 'Todos', 'insert' => 'Inclusão', 'update' => 'Atualização', 'delete' => 'Exclusão'], ['class' => 'form-control']),
                'contentOptions' => ['class' => 'text-center'],
                'format' => 'raw',
                'value' => function ($model, $key, $index, $column) {
                    return Html::tag('span', mb_strtoupper(\app\models\Log::$types[$model->type], 'UTF-8'), ['class' => 'label label-info']);
                },
            ],
            [
                'attribute' => 'happened_at',
                'format' => 'datetime',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'filter' => \yii\widgets\MaskedInput::widget([
                    'value' => $searchModel->happened_at,
                    'name' => 'LogSearch[happened_at]',
                    'clientOptions' => [
                        'alias' => 'date',
                        'clearIncomplete' => true,
                        'placeholder' => '__/__/____'
                    ]
                ]),
                'label' => 'Data'
            ],
            [
                'attribute' => 'data',
                'label' => 'Dados',
                'filter' => false,
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'contentOptions' => ['style' => 'width: 30%'],
                'format' => 'raw',
                'value' => function ($model, $key, $index, $column) {
                    /* @var $model \yii\db\ActiveRecord */

                    //catch empty data
                    $changes = $model->changes;
                    if ($changes === null || count($changes) === 0) {
                        return null;
                    }

                    $ret = Html::beginTag('strong', ['class' => 'mb-5']);
                    $ret .= explode('\\', $model->model_type)[2] . ' - ' . \yii\helpers\Json::decode($model->foreign_pk, true)['id'];
                    $ret .= Html::endTag('strong');
                    $ret .= Html::beginTag('table', ['class' => 'table table-condensed table-bordered table-responsive']);

                    //colgroup
                    $ret .= Html::beginTag('colgroup');
                    $widths = [
                        'attribute' => null,
                        'from' => '30%',
                        'to' => '30%',
                    ];

                    $ret .= Html::tag('col', '', ['style' => sprintf('width: %s;', isset($widths['attribute']) ? $widths['attribute'] : 'auto')]);
                    if ($model->type === \app\behaviors\LogBehavior::AUDIT_TYPE_UPDATE) {
                        $ret .= Html::tag('col', '', ['style' => sprintf('width: %s;', isset($widths['from']) ? $widths['from'] : 'auto')]);
                    }
                    $ret .= Html::tag('col', '', ['style' => sprintf('width: %s;', isset($widths['to']) ? $widths['to'] : 'auto')]);

                    //table head
                    $ret .= Html::beginTag('thead');
                    $ret .= Html::beginTag('tr');
                    $ret .= Html::tag('th', Yii::t('app', 'Attribute'));
                    if ($model->type === \app\behaviors\LogBehavior::AUDIT_TYPE_UPDATE) {
                        $ret .= Html::tag('th', Yii::t('app', 'From'));
                    }
                    $ret .= Html::tag('th', Yii::t('app', 'To'));
                    $ret .= Html::endTag('tr');
                    $ret .= Html::endTag('thead');

                    //table body
                    $ret .= Html::beginTag('tbody');
                    foreach ($changes as $change) {
                        //render data row
                        $ret .= Html::beginTag('tr');
                        $ret .= Html::tag('td', \yii\helpers\StringHelper::truncate($model->getAttributeLabel($change['attr']), 20));
                        if ($model->type === \app\behaviors\LogBehavior::AUDIT_TYPE_UPDATE) {
                            $ret .= Html::tag('td',  \yii\helpers\StringHelper::truncate($change['from'], 20));
                        }
                        $ret .= Html::tag('td',  \yii\helpers\StringHelper::truncate($change['to'], 20));
                        $ret .= Html::endTag('tr');
                    }
                    $ret .= Html::endTag('tbody');

                    $ret .= Html::endTag('table');

                    return $ret;
                },
            ],
            ['class' => \app\modules\DropDownActionColumn::className(),],
        ],
    ]); ?>
</div>

<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\EntidadeSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Entidade';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="entidade-index">
    <p>
        <?= \webvimark\modules\UserManagement\components\GhostHtml::a(
            '<span class="glyphicon glyphicon-plus-sign"></span> Novo',
            ['create'],
            ['class' => 'btn btn-success']
        ) ?>
    </p>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            [
                'label' => 'CNPJ',
                'attribute' => 'cnpj',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],
            [
                'label' => 'Endereço',
                'attribute' => 'endereco',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],
            [
                'label' => 'Logo marca',
                'attribute' => 'logo_marca',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'format' => 'raw',
                'value' => function ($model) {
                    $url = empty($model->logo_marca) ? \yii\helpers\Url::to('@web/themes/eliteadmin/plugins/images/users/blank-user.jpg', true) :
                        $model->logo_marca;

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

                    return Html::a(Html::img($url, ['style' => 'height: 30px; width:35px; margin-right: 10px;', 'class' => 'img-circle']), ['update', 'id' => $model->id], $options);
                },
                'contentOptions' =>
                    ['style' => 'width:40px; text-align: center;'],
            ],
            ['class' => \app\modules\DropDownActionColumn::className(),],
        ],
    ]); ?>
</div>

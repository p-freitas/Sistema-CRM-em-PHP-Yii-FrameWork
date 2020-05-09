<?php
use yii\helpers\Html;
use yii\grid\GridView;
?>

<?= GridView::widget([
    'dataProvider' => $dataProvider,
    'filterModel' => $searchModel,
    'columns' => [
        [
            'class' => 'yii\grid\ActionColumn',
            'header' => 'Pendências',
            'template' => '{dropdown}',
            'buttons' => [
                'dropdown' => function ($url, $model, $key) {
                    if (empty($model->afmsItems)) {
                        return \yii\bootstrap\ButtonDropdown::widget([
                            'encodeLabel' => false,
                            'label' => '<i class="fa fa-exclamation"></i>',
                            'dropdown' => [
                                'items' => [
                                    [
                                        'label' => 'Itens',
                                        'url' => ['wizard-afms/index', 'id' => $key, 'step' => 1],
                                    ],
                                ],
                                'options' => [
                                    'class' => 'dropdown-menu-right',
                                ],
                            ],
                            'options' => [
                                'class' => 'btn border-warning text-warning-600 btn-flat btn-icon btn-rounded',
                            ],
                        ]);
                    } else {
                        return Html::label('Nenhuma', null, ['class' => 'label label-flat label-rounded border-success text-success-600']);
                    }
                },
            ],
        ],
        [
            'class' => 'yii\grid\ActionColumn',
            'template' => '{view}{pdf}{update}{delete}',
            'buttons' => [
                'update' => function ($url, $model) {
                    $url = \yii\helpers\Url::to(['wizard-afms/index', 'id' => $model->ID]);
                    return Html::a('<span class="glyphicon glyphicon-pencil"></span>', $url, [
                        'title' => Yii::t('app', 'Update'),
                    ]);
                },
                'pdf' => function ($url, $model) {
                    $url = \yii\helpers\Url::to(['afms/gera-pdf-pedido', 'id' => $model->ID]);
                    return Html::a('<span class="glyphicon glyphicon-floppy-save"></span>', $url, [
                        'title' => 'Gerar PDF',
                    ]);
                }
            ],
            'visibleButtons' => [
                'pdf' => function ($model, $key, $index) {
                    return !empty($model->afmsItems);
                }
            ]
        ],
    ]
]); ?>
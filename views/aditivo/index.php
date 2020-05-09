<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\search\AditivoSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->params['breadcrumbs'][] = Yii::t('app', 'Aditivos');
?>
<div class="aditivo-index">


    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= \webvimark\modules\UserManagement\components\GhostHtml::a(
            '<span class="glyphicon glyphicon-plus-sign"></span> Novo',
            ['create'],
            ['class' => 'btn btn-success']
        ) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            [
                'label' => 'Contrato',
                'attribute' => 'contrato',
                'value' => function($model){
                    return $model->fkContrato->numero;
                },

            ],
            'numero',
            [
                'attribute' => 'valor',
                'format' => 'raw',
                'value' => function($model){
                    return '<div style=text-align:right>R$ '. $model->valor.' </div>';
                }
            ],
            [
                'label' => 'Data Início',
                'attribute' => '',
                'value' => function($model){
                    return $model->data_inicio;
                },

            ],
            [
                'label' => 'Data Término',
                'attribute' => '',
                'value' => function($model){
                    return $model->data_termino;
                },

            ],


            ['class' => \app\modules\DropDownActionColumn::className(),],
        ],
    ]); ?>
</div>

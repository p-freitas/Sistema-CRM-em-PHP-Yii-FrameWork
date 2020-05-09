<?php

use webvimark\modules\UserManagement\components\GhostHtml;
use webvimark\modules\UserManagement\UserManagementModule;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\helpers\ArrayHelper;
use yii\widgets\Pjax;
use webvimark\extensions\GridBulkActions\GridBulkActions;
use webvimark\extensions\GridPageSize\GridPageSize;
use yii\grid\GridView;
use yii\widgets\ActiveForm;

/**
 * @var yii\web\View $this
 * @var yii\data\ActiveDataProvider $dataProvider
 * @var webvimark\modules\UserManagement\models\rbacDB\search\AuthItemGroupSearch $searchModel
 */

$this->title = UserManagementModule::t('back', 'Permission groups');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="auth-item-group-index">
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>
    <div class="panel panel-default">
        <div class="panel-body">
            <?php Pjax::begin(['id' => 'pjax-atendimento']); ?>

            <div class="form-group">
                <?= Html::a('<i class="fa fa-plus-circle"></i> Nova permissão', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
                <div class="pull-right">

                    <?php $form = ActiveForm::begin([
                        'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                        'action' => ['index'],
                        'method' => 'get',
                    ]); ?>


                    <?php ActiveForm::end(); ?>
                </div>
            </div>


            <?php Pjax::begin([
                'id' => 'auth-item-group-grid-pjax',
            ]) ?>

            <?= GridView::widget([
                'id' => 'auth-item-group-grid',
                'dataProvider' => $dataProvider,
                'tableOptions' => ['class' => 'table table-striped'],
                'pager' => [
                    'options' => ['class' => 'pagination pagination-sm'],
                    'hideOnSinglePage' => true,
                    'lastPageLabel' => '>>',
                    'firstPageLabel' => '<<',
                ],

                'columns' => [
                    ['class' => 'yii\grid\SerialColumn', 'options' => ['style' => 'width:10px']],

                    [
                        'attribute' => 'name',
                        'headerOptions' => ['class' => 'text-center'],
                        'contentOptions' => ['class' => 'text-center'],
                        'value' => function ($model) {
                            return Html::a($model->name, ['update', 'id' => $model->code], ['data-pjax' => 0]);
                        },
                        'format' => 'raw',
                    ],
                    [
                        'label' => 'Código',
                        'attribute' => 'code',
                        'headerOptions' => ['class' => 'text-center'],
                        'contentOptions' => ['class' => 'text-center'],
                    ],


                    [
                        'class' => \app\modules\DropDownActionColumn::className(),
                        'primaryKey' => [
                            'paramName' => 'id'
                        ],
                        'contentOptions' => ['style' => 'width:70px; text-align:center;'],
                    ],
                ],
            ]); ?>

            <?php Pjax::end() ?>
        </div>
    </div>
</div>

<?php

use webvimark\extensions\GridBulkActions\GridBulkActions;
use webvimark\extensions\GridPageSize\GridPageSize;
use webvimark\modules\UserManagement\components\GhostHtml;
use webvimark\modules\UserManagement\models\rbacDB\AuthItemGroup;
use webvimark\modules\UserManagement\models\rbacDB\Role;
use webvimark\modules\UserManagement\UserManagementModule;
use yii\grid\GridView;
use yii\helpers\ArrayHelper;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;

/**
 * @var yii\data\ActiveDataProvider $dataProvider
 * @var webvimark\modules\UserManagement\models\rbacDB\search\RoleSearch $searchModel
 * @var yii\web\View $this
 */
$this->title = UserManagementModule::t('back', 'Roles');
$this->params['breadcrumbs'][] = $this->title;

?>
<div class="panel panel-default">
    <div class="panel-body">
        <?php Pjax::begin(['id' => 'pjax-atendimento']); ?>

        <div class="form-group">
            <?= Html::a('<i class="fa fa-plus-circle"></i> Nova função', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
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
            'id' => 'role-grid-pjax',
        ]) ?>

        <?= GridView::widget([
            'id' => 'role-grid',
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
                    'attribute' => 'description',
                    'headerOptions' => ['class' => 'text-center'],
                    'contentOptions' => ['class' => 'text-center'],
                    'value' => function (Role $model) {
                        return Html::a($model->description, ['view', 'id' => $model->name], ['data-pjax' => 0]);
                    },
                    'format' => 'raw',
                ],
                [
                    'label' => 'Código',
                    'attribute' => 'name',
                    'headerOptions' => ['class' => 'text-center'],
                    'contentOptions' => ['class' => 'text-center'],
                ],

                ['class' => \app\modules\DropDownActionColumn::className(),],
            ],
        ]); ?>

        <?php Pjax::end() ?>
    </div>
</div>
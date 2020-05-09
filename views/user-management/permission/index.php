<?php
use webvimark\extensions\GridBulkActions\GridBulkActions;
use webvimark\extensions\GridPageSize\GridPageSize;
use webvimark\modules\UserManagement\components\GhostHtml;
use webvimark\modules\UserManagement\models\rbacDB\AuthItemGroup;
use webvimark\modules\UserManagement\models\rbacDB\Permission;
use webvimark\modules\UserManagement\UserManagementModule;
use yii\grid\GridView;
use yii\helpers\ArrayHelper;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\widgets\Pjax;
use yii\widgets\ActiveForm;

/**
 * @var yii\data\ActiveDataProvider $dataProvider
 * @var $searchModel webvimark\module-user-management\models\rbacDB\searchPermissionSearch
 * @var yii\web\View $this
 */
$this->title = UserManagementModule::t('back', 'Permissions');
$this->params['breadcrumbs'][] = $this->title;

?>
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
			'id'=>'permission-grid-pjax',
		]) ?>



		<?= GridView::widget([
			'id'=>'permission-grid',
			'dataProvider' => $dataProvider,
            'tableOptions' => ['class' => 'table table-striped'],
			'pager'=>[
				'options'=>['class'=>'pagination pagination-sm'],
				'hideOnSinglePage'=>true,
				'lastPageLabel'=>'>>',
				'firstPageLabel'=>'<<',
			],

			'columns' => [
				['class' => 'yii\grid\SerialColumn', 'options'=>['style'=>'width:10px'] ],

				[
					'attribute'=>'description',
                    'headerOptions' => ['class' => 'text-center'],
                    'contentOptions' => ['class' => 'text-center'],
					'value'=>function($model){
							if ( $model->name == Yii::$app->getModule('user-management')->commonPermissionName )
							{
								return Html::a(
									$model->description,
									['view', 'id'=>$model->name],
									['data-pjax'=>0, 'class'=>'label label-primary']
								);
							}
							else
							{
								return Html::a($model->description, ['view', 'id'=>$model->name], ['data-pjax'=>0]);
							}
						},
					'format'=>'raw',
				],
                [
                    'label' => 'Código',
                    'attribute' => 'name',
                    'headerOptions' => ['class' => 'text-center'],
                    'contentOptions' => ['class' => 'text-center'],
                ],
				[
					'attribute'=>'group_code',
                    'headerOptions' => ['class' => 'text-center'],
                    'contentOptions' => ['class' => 'text-center'],
					'filter'=>ArrayHelper::map(AuthItemGroup::find()->asArray()->all(), 'code', 'name'),
					'value'=>function(Permission $model){
							return $model->group_code ? $model->group->name : '';
						},
				],
				[
                    'class' => \app\modules\DropDownActionColumn::className(),
                    'primaryKey' => [
                        'paramName' => 'id'
                    ],
					'contentOptions'=>['style'=>'width:70px; text-align:center;'],
				],
			],
		]); ?>

		<?php Pjax::end() ?>
	</div>
</div>
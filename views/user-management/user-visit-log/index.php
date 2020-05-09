<?php

use webvimark\extensions\DateRangePicker\DateRangePicker;
use webvimark\modules\UserManagement\UserManagementModule;
use yii\helpers\Html;
use yii\widgets\Pjax;
use webvimark\extensions\GridPageSize\GridPageSize;
use yii\grid\GridView;
use yii\widgets\ActiveForm;

/**
 * @var yii\web\View $this
 * @var yii\data\ActiveDataProvider $dataProvider
 * @var webvimark\modules\UserManagement\models\search\UserVisitLogSearch $searchModel
 */

$this->title = UserManagementModule::t('back', 'Visit log');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-visit-log-index">

	<?php // echo $this->render('_search', ['model' => $searchModel]); ?>

	<div class="panel panel-default">

		<div class="panel-body">

            <?php Pjax::begin(['id' => 'pjax-atendimento']); ?>

			<?php Pjax::begin([
				'id'=>'user-visit-log-grid-pjax',
			]) ?>

			<?= GridView::widget([
				'id'=>'user-visit-log-grid',
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
						'attribute'=>'user_id',
                        'headerOptions' => ['class' => 'text-center'],
                        'contentOptions' => ['class' => 'text-center'],
						'value'=>function($model){
								return Html::a(@$model->user->username, ['view', 'id'=>$model->id], ['data-pjax'=>0]);
							},
						'format'=>'raw',
					],
                    [
                        'label' => 'Idioma',
                        'attribute' => 'language',
                        'headerOptions' => ['class' => 'text-center'],
                        'contentOptions' => ['class' => 'text-center'],
                    ],

                    [
                        'label' => 'Sistema Operacional',
                        'attribute' => 'os',
                        'headerOptions' => ['class' => 'text-center'],
                        'contentOptions' => ['class' => 'text-center'],
                    ],

                    [
                        'label' => 'Navegador',
                        'attribute' => 'browser',
                        'headerOptions' => ['class' => 'text-center'],
                        'contentOptions' => ['class' => 'text-center'],
                    ],

                    array(
						'attribute'=>'ip',
                        'headerOptions' => ['class' => 'text-center'],
                        'contentOptions' => ['class' => 'text-center'],
						'value'=>function($model){
								return Html::a($model->ip, "http://ipinfo.io/" . $model->ip, ["target"=>"_blank"]);
							},
						'format'=>'raw',
					),
                        'visit_time:datetime',
					[
                        'class' => \app\modules\DropDownActionColumn::className(),
						'template'=>'{view}',
						'contentOptions'=>['style'=>'width:70px; text-align:center;'],
					],
				],
			]); ?>
		
			<?php Pjax::end() ?>
		</div>
	</div>
</div>

<?php DateRangePicker::widget([
	'model'     => $searchModel,
	'attribute' => 'visit_time',
]) ?>
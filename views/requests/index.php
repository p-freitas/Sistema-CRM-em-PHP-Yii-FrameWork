<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel app\models\RequestsSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */


$this->title = Yii::t('app', 'Requests');
$this->params['breadcrumbs'][] = $this->title;
?>

<div class="requests-index" id="mensagem-modal" data-url="<?= \yii\helpers\Url::toRoute('requests/modal-mensagem') ?>">



    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'tableOptions' => ['class' => 'table table-striped'],
        'columns' => [
            [
                'label' => 'IP',
                'attribute' => 'ip',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],
            [
                'attribute' => 'data_ini_req',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function ($model) {
                    return Yii::$app->formatter->asDatetime($model->data_ini_req, 'php:d/m/Y H:i:s');
                },
            ],
            [
                'attribute' => 'data_fim_req',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'value' => function ($model) {
                    return Yii::$app->formatter->asDatetime($model->data_fim_req, 'php:d/m/Y H:i:s');
                },
            ],
            [
                'label' => 'Status',
                'attribute' => 'status',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
            ],
            [
                'attribute' => 'mensagem',
                'headerOptions' => ['class' => 'text-center'],
                'contentOptions' => ['class' => 'text-center'],
                'format' => 'raw',
                'value' => function($model){
                   return Html::button( $model->mensagem = ($model->mensagem == 'Salvo com sucesso' ? 'Salvo com sucesso' : 'Erro durante processamento'), ['class' => 'btn btn-default', 'onclick' => "abreModalMensagem($model->id)"]);  
                   //$href = Html::a('Gerar PDF', ['requests/mensagem-pdf', 'id' => $model->id], ['class' => 'profile-link']);    
                }
            ], 

            //'mensagem:ntext',
        ],
    ]); ?>

     <div class="modal" id="modal-rm">
        <div class="modal-dialog  modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="pull-left">
                                <form method="post" target="_blank"
                                      action="<?= \yii\helpers\Url::toRoute('requests/mensagem-pdf') ?>">
                                    <input type="hidden" name="_csrf"
                                           value="<?= Yii::$app->request->getCsrfToken() ?>"/>
                                    <input type="hidden" name="Mensagem[ID]" id="mensagem_id" value="">
                                
                                </form>
                            </div>
                            <div class="pull-right">
                                <button type="button" class="btn btn-default" data-dismiss="modal"><i
                                            class="fa fa-times"></i> Fechar
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12" id="change-body">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>





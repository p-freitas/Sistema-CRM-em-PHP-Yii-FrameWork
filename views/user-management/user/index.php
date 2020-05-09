<?php

use webvimark\modules\UserManagement\components\GhostHtml;
use webvimark\modules\UserManagement\models\rbacDB\Role;
use webvimark\modules\UserManagement\models\User;
use webvimark\modules\UserManagement\UserManagementModule;
use yii\helpers\Html;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use yii\widgets\Pjax;
use webvimark\extensions\GridBulkActions\GridBulkActions;
use webvimark\extensions\GridPageSize\GridPageSize;
use yii\grid\GridView;
use yii\widgets\ActiveForm;

/**
 * @var yii\web\View $this
 * @var yii\data\ActiveDataProvider $dataProvider
 * @var \app\models\search\UsuarioSearch $searchModel
 */


$this->registerCss("
    .table.table-condensed.table-striped > thead > tr > th{
        border-top: 1px solid #e4e7ea;
    }
    
    .badge {
        padding: 1px 5px 2px;
        margin-top: 0;  
    }
");

$this->registerJs("
    $(document).on('pjax:end', function() {
        reloadIntercepts();
        $('[data-toggle=\"tooltip\"]').tooltip();
    });
    
    function reloadIntercepts(){
        $('.intercept-button-list, .intercept-button-form, .intercept-button-edit, .intercept-button-view').off('click').click(function(e){
            var button = $(this);
            $.ajax({
                'url' : $(this).attr('href'),
                'type' : 'GET',
                'beforeSend': function(){
                    $(\".preloader\").fadeIn();
                }
            }).done(function(data){
                var retorno = JSON.parse(data);
                if(button.hasClass('intercept-button-list')){
                    $('#modal-list div.modal-content').html(retorno.content);
                    $('#modal-list').modal('show');
                }else if(button.hasClass('intercept-button-view')){
                    $('#modal-view div.modal-content').html(retorno.content);
                    $('#modal-list').modal('hide');
                    $('#modal-view').modal('show');
                }else{
                    $('#modal-form div.modal-content').html(retorno.content);
                    $('#modal-list').modal('hide');
                    $('#modal-form').modal('show');
                }
            });
            e.preventDefault();
        });
        
        $('.intercept-button-delete').click(function(e){
            var button = $(this);
             
            swal({
                title: \"Atenção\",
                text: \"Deseja realmente excluir o item?\",
                type: \"warning\",
                showCancelButton: true,
                confirmButtonColor: \"#DD6B55\",
                confirmButtonText: \"Sim, prosseguir\",
                cancelButtonText: \"Não, voltar\",
            }).then(result => {
                if (result.value) {
                    $.ajax({
                        'url' : button.attr('href'),
                        'type' : 'GET',
                        'beforeSend': function(){
                            $(\".preloader\").fadeIn();
                        }
                    }).done(function(data){
                        var retorno = JSON.parse(data);
                        if(retorno.status == 200){
                            $.toast({
                                heading: \"\",
                                text: \"Excluído com sucesso\",
                                position: \"top-right\",
                                loaderBg: \"#ff6849\",
                                icon: \"success\",
                                hideAfter: 2000,
                            });
                            
                            button.parents('tr').remove();
                            $.pjax.reload('#pjax-funcionario', {timeout: 3000});
                        }else{
                            $.toast({
                                heading: \"Atenção\",
                                text: \"Não foi possível excluir o item.\",
                                position: \"top-right\",
                                loaderBg: '#ff6849',
                                icon: 'error',
                                hideAfter: 2000,
                            });
                        }
                        
                        $(\".preloader\").fadeOut();
                    });
                }
            });
            
            e.preventDefault();
        });
    }
   
    reloadIntercepts();
    
    $('#modal-list, #modal-form, #modal-view').on('shown.bs.modal', function(){
        reloadIntercepts();
        $(\".preloader\").fadeOut();
    });
    
    $('#modal-form, #modal-view').on('hide.bs.modal', function(){
        var modal = $(this);
        reloadIntercepts();
        
        if(modal.find('#form-desligamento').length == 0)
            $('#modal-list').modal('show');
            
        $(\".preloader\").fadeOut();
    });
");

$this->title = UserManagementModule::t('back', 'Users');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-index">
    <?php Pjax::begin(['id' => 'pjax-atendimento']); ?>
    <div class="panel panel-default">
        <div class="panel-body">

            <h1><?= Html::encode($this->title) ?></h1>
            <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

            <div class="form-group">
                <?= Html::a('<i class="fa fa-plus-circle"></i> Novo usuário', ['create'], ['class' => 'btn btn-success', 'data-pjax' => 0]) ?>
                <div class="pull-right">

                    <?php $form = ActiveForm::begin([
                        'options' => ['class' => 'form-inline', 'data-pjax' => 1],
                        'action' => ['index'],
                        'method' => 'get',
                    ]); ?>

                    <?= $form->field($searchModel, 'search')->textInput(['data-toggle' => 'tooltip', 'title' => 'Pesquisa por nome, usuario ou email'])->label('Pesquisar: ') ?>

                    <?php ActiveForm::end(); ?>
                </div>
            </div>


                <?= GridView::widget([
                    'id'=>'user-grid',
                    'dataProvider' => $dataProvider,

                    'tableOptions' => ['class' => 'table table-striped'],
                    'pager'=>[
                        'options'=>['class'=>'pagination pagination-sm'],
                        'hideOnSinglePage'=>true,
                        'lastPageLabel'=>'>>',
                        'firstPageLabel'=>'<<',
                    ],

                    'layout'=>'{items}<div class="row"><div class="col-sm-8">{pager}</div><div class="col-sm-4 text-right">{summary}'.GridBulkActions::widget([
                            'gridId'=>'user-grid',
                            'actions'=>[
                                Url::to(['bulk-activate', 'attribute'=>'status'])=>GridBulkActions::t('app', 'Activate'),
                                Url::to(['bulk-deactivate', 'attribute'=>'status'])=>GridBulkActions::t('app', 'Deactivate'),
                                '----'=>[
                                    Url::to(['bulk-delete'])=>GridBulkActions::t('app', 'Delete'),
                                ],
                            ],
                        ]).'</div></div>',


                    'columns' => [
                        ['class' => 'yii\grid\SerialColumn', 'options'=>['style'=>'width:10px'] ],
                        [
                            'attribute' => 'fk_entidade',
                            'headerOptions' => ['class' => 'text-center'],
                            'contentOptions' => ['class' => 'text-center'],
                            'value' => 'fkEntidade.nome_fantasia',
                            'filter' => \kartik\select2\Select2::widget([
                                'value' => $searchModel->fk_entidade,
                                'initValueText' => empty($searchModel->fk_entidade) ? '' : $searchModel->fkEntidade->nome,
                                'name' => 'UserSearch[fk_entidade]',
                                'theme' => 'bootstrap',
                                'language' => 'pt-BR',
                                'options' => ['placeholder' => 'Entidade'],
                                'pluginOptions' => [
                                    'dropdownCssClass' => 'wide-select2',
                                    'allowClear' => true,
                                    'minimumInputLength' => 3,
                                    'ajax' => [
                                        'url' => \yii\helpers\Url::to(['//entidade/busca-ajax']),
                                        'dataType' => 'json',
                                        'data' => new \yii\web\JsExpression('function(params) { return {q:params.term}; }')
                                    ],
                                ],
                            ]),
                            'visible' => Yii::$app->user->isSuperadmin
                        ],
                        [
                            'label' => 'Usuário',
                            'attribute'=>'nome_completo',
                            'headerOptions' => ['class' => 'text-center'],
                            'contentOptions' => ['class' => 'text-center'],
                            'value'=>function(\app\models\Usuario $model){
                                return Html::a($model->nome_completo,['view', 'id'=>$model->id],['data-pjax'=>0]);
                            },
                            'format'=>'raw',
                        ],
                        [
                            'attribute'=>'username',
                            'headerOptions' => ['class' => 'text-center'],
                            'contentOptions' => ['class' => 'text-center'],
                            'value'=>function(User $model){
                                return Html::a($model->username,['view', 'id'=>$model->id],['data-pjax'=>0]);
                            },
                            'format'=>'raw',
                        ],
                        [
                            'attribute'=>'email',
                            'format'=>'raw',
                            'headerOptions' => ['class' => 'text-center'],
                            'contentOptions' => ['class' => 'text-center'],
                            'visible'=>User::hasPermission('viewUserEmail'),
                        ],

                        [
                            'class'=>'webvimark\components\StatusColumn',
                            'attribute'=>'status',
                            'headerOptions' => ['class' => 'text-center'],
                            'contentOptions' => ['class' => 'text-center'],
                            'optionsArray'=>[
                                [User::STATUS_ACTIVE, UserManagementModule::t('back', 'Active'), 'success'],
                                [User::STATUS_INACTIVE, UserManagementModule::t('back', 'Inactive'), 'warning'],
                                [User::STATUS_BANNED, UserManagementModule::t('back', 'Banned'), 'danger'],
                            ],
                        ],

                        [
                            'value'=>function(User $model){
                                return GhostHtml::a(
                                    UserManagementModule::t('back', 'Change password'),
                                    ['change-password', 'id'=>$model->id],
                                    ['class'=>'btn btn-sm btn-default text-center', 'data-pjax'=>0, 'style' => "
                                                                                                            margin-left: 80px;
                                                                                                            "]);
                            },
                            'format'=>'raw',
                            'headerOptions' => ['class' => 'text-center'],
                            'contentOptions' => ['class' => 'text-center'],
                            'options'=>[
                                'width'=>'10px',
                            ],
                        ],
                        ['class' => \app\modules\DropDownActionColumn::className(),],
                    ],
                ]); ?>


            <?php Pjax::end() ?>
        </div>
    </div>
</div>

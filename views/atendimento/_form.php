<?php

use app\models\Atendimento;
use kartik\datetime\DateTimePicker;
use kartik\file\FileInput;
use kartik\select2\Select2;
use wbraganca\dynamicform\DynamicFormWidget;
use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Atendimento */
/* @var $form yii\widgets\ActiveForm */
/* @var $modelAnexo app\models\AtendimentoAnexos */
/* @var $modelOcorrencia app\models\TipoOcorrencia */


$this->registerJs("
$('#form-funcionario').on('afterValidate', function(event, messages, errorAttributes){
    if(errorAttributes.length !== 0){
        checkTabs();
    }
});

$('#modal-add-contato').on('show.bs.modal', function(){
        $('#contato-cliente').select2('close');
    });

$(document).ready(function(){
  $('#solucao-btn-salvar').click(function(){
      $('#form-solucao').submit();
  });
});

$('#save-contato-btn').on('submit', function(){
        $(\"#contato-modal\").modal(\"hide\");
    });


$('#modal-solucao-btn').on('click', function(){
    $('#solucao-modal').modal('show');
});

$('#solucao-modal').on('submit', function(){
    $('#atendimento-status').val('') == '1';
});

$('#modal-add-agencia').on('show.bs.modal', function(){
    $('#funcionarioconta-fk_agencia').select2('close');
});

$('#modal-add-classe').on('show.bs.modal', function(){
    $('#funcionarioinfoadm-fk_classe').select2('close');
});

$('#modal-add-departamento').on('show.bs.modal', function(){
    $('#funcionarioinfoadm-fk_departamento').modal('close');
    });

$('#modal-add-fonte').on('show.bs.modal', function(){
    $('#funcionarioinfoadm-fk_fonte_recurso').select2('close');
});

$('#modal-add-lotacao').on('show.bs.modal', function(){
    $('#funcionarioinfoadm-fk_lotacao').select2('close');
});

$('#modal-add-nivel').on('show.bs.modal', function(){
    $('#funcionarioinfoadm-fk_nivel').select2('close');
});

$('#modal-add-secretaria').on('show.bs.modal', function(){
    $('#lotacao-fk_secretaria').select2('close');
    $('#modal-add-lotacao').modal('hide');
    }).on('hide.bs.modal', function(){
        $('#modal-add-lotacao').modal('show');
    });

$('#modal-add-lote').on('show.bs.modal', function(){
    $('#funcionarioinfoadm-fk_lote_pagamento').select2('close');
});

$('#modal-add-sindicato').on('show.bs.modal', function(){
    $('#funcionarioinfoadm-fk_sindicato').select2('close');
});

$('#modal-add-regime').on('show.bs.modal', function(){
    $('#funcionarioinfoadm-fk_regime').select2('close');
});

$('#usuario-id').attr('disabled', true); 


");

\app\assets\DatatablesAsset::register($this);
$this->registerJsFile('@web/js/produtos.js', ['depends' => [\yii\web\JqueryAsset::className()]]);

$this->title = 'Criar atendimento';
?>


<div class="atendimento-form">
    <?php $form = ActiveForm::begin(['id' => 'form-atendimento', 'options' => ['enctype' => 'multipart/form-data']]); ?>
    <?php if ($model->isNewRecord) { ?>
        <div class="row">
            <div class="col-md-4">
                <?= $form->field($model, 'fk_cliente')->widget(Select2::classname(), [
                    'theme' => 'bootstrap',
                    'language' => 'pt-BR',
                    'options' => ['placeholder' => 'Selecione', 'id' => 'cliente-id'],
                        'data' => \app\modules\Helper::map(\app\models\Cliente::find()->findClienteByEntidade()->andFilterWhere(['like', 'fk_tipo_cliente', '2'])->orderBy([\app\models\Cliente::tableName() . '.razao_social' => SORT_ASC])->asArray()->all(), 'id', 'razao_social')
                ])->label('Cliente') ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'fk_contato_cliente')->widget(\kartik\depdrop\DepDrop::className(), [
                    'type' => \kartik\depdrop\DepDrop::TYPE_SELECT2,
                    'options' => ['placeholder' => 'Selecione', 'id' => 'contato-cliente'],
                    'select2Options' => [
                        'theme' => 'bootstrap',
                        'language' => 'pt-BR',
                        'pluginOptions' => ['allowClear' => true],
                    ],
                    'pluginOptions' => [
                        'initialize' => true,
                        'loadingText' => 'Carregando',
                        'depends' => ['cliente-id'],
                        'placeholder' => 'Selecione',
                        'url' => \yii\helpers\Url::to(['contato-cliente/get-contato-cliente']),
                        'language' => 'pt',
                        'params' => ['cliente-id'],
                        'data' => new \yii\web\JsExpression('function(params) { return {q:params.term}; }')
                    ],
                    'pluginEvents' => [
                        "select2:open" => "function(){
                                if($(\"#new-contato\").length === 0){ 
                                    $(\".select2-results\").find('button').remove();
                                    $(\".select2-results:not(:has(a))\").append('<button class=\"btn btn-success pull-right\" id=\"new-contato\" data-target=\"#modal-add-contato\" data-toggle=\"modal\"><i class=\"fa fa-plus\"></i> Criar novo contato</button>'); 
                                }else{
                                    $(\".select2-results\").find('button:not(#new-contato)').remove();
                                }
                            }",
                    ]
                ])->label('Contato') ?>
            </div>

            <div class="col-md-4">
                <?= $form->field($model, 'fk_contrato')->widget(\kartik\depdrop\DepDrop::className(), [
                    'type' => \kartik\depdrop\DepDrop::TYPE_SELECT2,
                    'options' => ['placeholder' => 'Selecione', 'id' => 'contrato-id'],
                    'select2Options' => [
                        'theme' => 'bootstrap',
                        'language' => 'pt-BR',
                        'pluginOptions' => ['allowClear' => true],
                    ],
                    'pluginOptions' => [
                        'loadingText' => 'Carregando',
                        'depends' => ['cliente-id'],
                        'placeholder' => 'Selecione',
                        'url' => \yii\helpers\Url::to(['contrato/get-contrato-cliente']),
                        'initialize' => true,
                        'language' => 'pt',
                    ],
                ])->label('Contrato')
                //'data' => \yii\helpers\ArrayHelper::map(\app\models\Contrato::find()->asArray()->all(), 'id', 'numero'),
                ?>
            </div>
        </div>
    <?php } else { ?>
        <div class="row">
            <div class="col-md-4">
                <label>Cliente</label>
                <input type="text" class="form-control" value="<?= $model->fkCliente->razao_social ?>" disabled>
            </div>
            <div class="col-md-4">
                <label>Contato</label>
                <input type="text" class="form-control"
                       value="<?= (is_null($model->fk_contato_cliente)) ? 'Não definido' : $model->fkContatoCliente->email ?>"
                       disabled>
            </div>
            <div class="col-md-4">
                <label>Contrato</label>
                <input type="text" class="form-control"
                       value="<?= (is_null($model->fk_contrato)) ? 'Não definido' : $model->fkContrato->numero ?>"
                       disabled>
            </div>
        </div>
    <?php } ?>

    <br>

    <div class="row">
        <?php if ($model->isNewRecord) { ?>
            <div class="col-md-4">
                <?= $form->field($model, 'fk_produto')->widget(\kartik\depdrop\DepDrop::className(), [
                    'type' => \kartik\depdrop\DepDrop::TYPE_SELECT2,
                    'options' => ['placeholder' => 'Selecione', 'id' => 'produto-id'],
                    'select2Options' => [
                        'theme' => 'bootstrap',
                        'language' => 'pt-BR',
                        'pluginOptions' => ['allowClear' => true],
                    ],
                    'pluginOptions' => [
                        'loadingText' => 'Carregando',
                        'depends' => ['contrato-id'],
                        'placeholder' => 'Selecione',
                        'url' => \yii\helpers\Url::to(['produto/get-produtos']),
                        'initialize' => true,
                        'language' => 'pt',
                    ],
                ])->label('Produtos')
                //'data' => \yii\helpers\ArrayHelper::map(\app\models\Contrato::find()->asArray ()->all(), 'id', 'numero'),
                ?>
            </div>
        <?php } else { ?>
            <div class="col-md-4">
                <label>Produto</label>
                <input type="text" class="form-control"
                       value="<?= (is_null($model->fk_produto)) ? 'Não definido' : $model->fkProduto->descricao ?>"
                       disabled>
            </div>
        <?php } ?>

        <div class="col-md-4">
            <?= $form->field($model, 'fk_tipo_atendimento')->widget(\kartik\select2\Select2::className(), [
                'theme' => 'bootstrap',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear' => true],
                'language' => 'pt-BR',
                'data' => \yii\helpers\ArrayHelper::map(\app\models\TipoAtendimento::find()->asArray()->all(), 'id', 'descricao'),
            ])->label('Tipo de Atendimento') ?>
        </div>
        <div class="col-md-4">
            <?= $form->field($model, 'fk_tipo_ocorrencia')->widget(\kartik\select2\Select2::className(), [
                'theme' => 'bootstrap',
                'options' => ['placeholder' => 'Selecione'],
                'pluginOptions' => ['allowClear' => true],
                'language' => 'pt-BR',
                'data' => \yii\helpers\ArrayHelper::map(\app\models\TipoOcorrencia::find()->asArray()->all(), 'id', 'descricao'),
            ])->label('Tipo de Ocorrência') ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <?= $form->field($model, 'solicitacao')->textarea(['rows' => 6])->label('Solicitação') ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <?= $form->field($modelAnexo, 'url')->widget(\kartik\file\FileInput::classname(), [
                'options' => ['accept' => 'image/*'],
                'language' => 'pt',
                'pluginOptions' => [
                    'showUpload' => false,
                    'showRemove' => true,
                    'browseLabel' => '',
                    'removeLabel' => '',
                    'initialPreview' => [
                        is_null($modelAnexo->anexo) ? true : \yii\helpers\Url::to('@web/img/') . $modelAnexo->anexo
                    ],
                    'maxFileSize' => 1024,
                    'initialPreviewAsData' => true,
                    'allowedFileExtensions' => ['jpg', 'gif', 'png', 'jpeg'],
                ],
            ])->label('Anexo') ?>
        </div>

        <div class="col-md-3">
            <?= $form->field($modelAnexo, 'descricao')->textInput()->label('Descrição do anexo') ?>
        </div>
    </div>

    <?php if (!$model->isNewRecord) { ?>
        <div class="row" style="margin-bottom: 2%;">
            <div style="margin-top: 2%">
                <div class="col-md-3 text-center" style="margin-top: 2%">
                    <label>Data do atendimento</label>
                    <input type="text" class="form-control text-center" value="<?= $model->data_atendimento ?>"
                           disabled>
                </div>
                <div class="col-md-3 text-center" style="margin-top: 2%">
                    <label>Usuário do atendimento</label>
                    <input type="text" class="form-control text-center" value="<?= $model->fkUsuario->username ?>"
                           disabled>
                </div>
                <div class="col-md-2 text-center" style="margin-top: 2%">
                    <?= $form->field($model, 'numero_atendimento')->textInput([
                        'disabled' => true,
                    ])->label('Número atendimento') ?>
                </div>
                <div class="col-md-2 text-center" style="margin-top: 2%">
                    <?= $form->field($model, 'status')->dropDownList([
                        0 => 'Pendente',
                        1 => 'Concluído',
                        2 => 'Cancelado',
                    ],
                        ['class' => 'form-control', 'disabled' => true, 'id' => 'status-id']
                    ) ?>
                </div>
            </div>
        </div>

        <br>

        <?php if ($model->solucao != null) { ?>
            <fieldset>
                <legend>Solução</legend>
                <div class="row">
                    <div class="col-md-12 text-center">
                        <?= $form->field($model, 'solucao')->textarea(['rows' => 4, 'disabled' => true])->label('Solução') ?>
                    </div>

                    <div class="col-md-3 text-center">
                        <label>Data da solucao</label>
                        <input type="text" class="form-control text-center" value="<?= $model->data_solucao ?>"
                               disabled>
                    </div>

                    <div class="col-md-3 text-center">
                        <label>Usuário da solução</label>
                        <input type="text" class="form-control" value="<?= $model->fkUsuarioSolucao->username ?>"
                               disabled>
                    </div>

                    <div class="col-md-3 text-center">
                        <label>Data prevista</label>
                        <input type="text" class="form-control text-center" value="<?= $model->data_prevista ?>"
                               disabled>
                    </div>
                </div>
            </fieldset>
        <?php } ?>
    <?php } ?>
</div>

<br> <br>

<div class="form-group">
    <?= Html::submitButton('Salvar', ['class' => 'btn btn-success']) ?>
    <?= Html::Button('Solução', ['class' => 'btn btn-warning', 'id' => 'modal-solucao-btn', 'data-target' => '#solucao-modal']) ?>
</div>

    <div class="modal fade" id="solucao-modal" tabindex="-1" role="dialog" aria-labelledby="solucao-modal-label">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-info">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="solucao-modal-label" style="color:white">Cadastrar Solução</h4>
                </div>
                <div id="content-solucao">

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <?= $form->field($model, 'solucao')->textarea(['rows' => 6])->label('Solução') ?>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <?= Html::Button('Salvar', ['class' => 'btn btn-success waves-effect', 'type' => 'submit', 'id' => 'solucao-btn-salvar']) ?>
                        <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Fechar</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
<?php ActiveForm::end(); ?>

<div class="modal" id="modal-add-contato">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Adicionr contato</h4>
            </div>
            <div class="modal-ajax">
                <?= $this->render('//contato-cliente/_form_modal', [
                    'model' => new \app\models\ContatoCliente()
                ]) ?>
            </div>
        </div>
    </div>
</div>
